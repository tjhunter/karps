package org.karps.ops

import scala.util.{Failure, Success, Try}

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}

import org.apache.spark.sql.{Column, KarpsStubs, _}
import org.apache.spark.sql.catalyst.analysis.FunctionRegistry
import org.apache.spark.sql.catalyst.expressions.aggregate.AggregateFunction

import org.karps.{ColumnWithType, KarpsException}
import org.karps.structures.{AugmentedDataType, Nullable}

object SQLFunctionsExtraction extends Logging {
  type SQLFunctionName = String

  def buildFunction(
      funName: String,
      inputs: Seq[ColumnWithType],
      ref: DataFrame,
      expectedType: Option[AugmentedDataType]): Try[ColumnWithType] = {
    for (sparkName <- nameTranslation.get(funName)) {
      return buildFunction(sparkName, inputs, ref, expectedType)
    }
    FunctionRegistry.builtin.lookupFunctionBuilder(funName.toLowerCase.trim) match {
      case Some(builder) =>
        val exps = inputs.map(_.col).map(KarpsStubs.getExpression)
        val expt = Try {
          builder.apply(exps)
        }
        expt.flatMap { exp =>
          val c = exp match {
            case agg: AggregateFunction =>
              KarpsStubs.makeColumn(agg.toAggregateExpression(isDistinct = false))
            case x =>
              KarpsStubs.makeColumn(x)
          }
          val inputNullability = Nullable.intersect(inputs.map(_.rectifiedSchema.nullability))
          val res = buildColumn(c, ref, inputNullability, expectedType)
          logger.debug(s"buildFunction: c=$c")
          logger.debug(s"buildFunction: inputNullability=$inputNullability")
          logger.debug(s"buildFunction: expectedType=$expectedType")
          logger.debug(s"buildFunction: res=$res")
          res
        }

      case None => Failure(new KarpsException(s"Could not find function name '$funName' in the " +
        s"spark registry"))
    }
  }

  // Associate the SQL names with the Spark names.
  private val nameTranslation = Map(
    "plus"->"+",
    "minus"->"-",
    "divide"->"/",
    "cast_double"->"double",
    "greater_equal"->">="
  )

  private def buildColumn(
      c: Column,
      ref: DataFrame,
      inputNullability: Nullable,
      expected: Option[AugmentedDataType]): Try[ColumnWithType] = {
    val df2 = ref.select(c)
    val dt = df2.schema.fields match {
      case Array(f1) => f1.dataType
      case _ => return Failure(KarpsException(s"ref=$ref df2=$df2 c=$c"))
    }
    expected match {
      case Some(adt) =>
        // Check for errors.
        for (errors <- AugmentedDataType.isCompatible(adt, df2.schema)) {
          return Failure(KarpsException(s"Found errors: df2=$df2 adt=$adt error=$errors"))
        }
        // Incorporate the nullability of the parents.
        val adt2 = adt.copy(nullability = adt.nullability.intersect(inputNullability))
        Success(ColumnWithType(c, adt2, ref))
      case None =>
        val adt = AugmentedDataType(dt, inputNullability)
        Success(ColumnWithType(c, adt, ref))
    }
  }
}
