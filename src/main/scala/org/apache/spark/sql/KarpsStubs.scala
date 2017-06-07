package org.apache.spark.sql

import org.apache.spark.SparkContext
import org.apache.spark.sql.catalyst.encoders.ExpressionEncoder
import org.apache.spark.sql.catalyst.expressions.Expression
import org.apache.spark.sql.execution.{QueryExecution, SQLExecution}

object KarpsStubs {
  def withExecutionId[T](sc: SparkContext, executionId: String)(body: => T): T= {
    SQLExecution.withExecutionId(sc, executionId)(body)
  }

  def withNewExecutionId[T](
      sparkSession: SparkSession,
      queryExecution: QueryExecution)(body: => T): T = {
    SQLExecution.withNewExecutionId(sparkSession, queryExecution)(body)
  }

  def getBoundEncoder(df: DataFrame): ExpressionEncoder[Row] = {
    df.exprEnc.resolveAndBind(df.logicalPlan.output,
      df.sparkSession.sessionState.analyzer)
  }

  def getExpression(c: Column): Expression = c.expr

  def makeColumn(exp: Expression): Column = Column.apply(exp)
}
