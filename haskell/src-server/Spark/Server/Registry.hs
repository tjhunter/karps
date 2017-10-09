{-| The registry of all the functions currently known to the program.
-}
module Spark.Server.Registry(
  structuredRegistry,
  nodeRegistry
) where

import Spark.Core.InternalStd.Aggregation
import Spark.Core.InternalStd.Column
import Spark.Core.InternalStd.Filter
import Spark.Core.InternalStd.Dataset
import Spark.Core.InternalStd.Observable
import Spark.Core.Internal.StructuredBuilder
import Spark.Core.Internal.NodeBuilder
import Spark.Core.Internal.DatasetStd
import Spark.Core.Internal.Joins
import Spark.Core.Internal.StructureFunctions


structuredRegistry :: StructuredBuilderRegistry
structuredRegistry = buildStructuredRegistry sqls udfs aggs where
  sqls = [castDoubleCBuilder,
          divideCBuilder,
          eqCBuilder,
          greaterCBuilder,
          greaterEqCBuilder,
          inverseCBuilder,
          lowerCBuilder,
          lowerEqCBuilder,
          minusCBuilder,
          multiplyCBuilder,
          plusCBuilder]
  udfs = []
  aggs = [collectAggBuilder,
          countABuilder,
          maxABuilder,
          minABuilder,
          sumABuilder]


nodeRegistry :: NodeBuilderRegistry
nodeRegistry = buildNodeRegistry [
  autocacheBuilder,
  broadcastPairBuilder,
  filterBuilder,
  functionalShuffleBuilder,
  functionalTransformBuilder,
  functionalLocalTransformBuilder,
  functionalReduceBuilder,
  identityBuilderD,
  identityBuilderL,
  -- joinBuilder,
  literalBuilderD,
  literalBuilderL,
  localPackBuilder,
  localTransformBuilder structuredRegistry,
  placeholderBuilder,
  pointerBuilder,
  reduceBuilder structuredRegistry,
  shuffleBuilder structuredRegistry,
  transformBuilder structuredRegistry]
