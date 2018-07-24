{-# LANGUAGE OverloadedStrings #-}

{-| This module contains data structures and functions to
build operator nodes, both in the DSL and the context of loading
and verifying graphs.
-}
module Spark.Core.Internal.NodeBuilder(
  BuilderFunction,
  NodeBuilder(..),
  NodeBuilderRegistry,
  NodeDefName,
  -- Basic tools
  cniStandardOp,
  cniStandardOp',
  -- No parent
  buildOpExtra,
  -- One parent
  buildOp1,
  buildOp1Extra,
  buildOpD,
  buildOpDExtra,
  buildOpL,
  buildOpLExtra,
  -- Two parents
  buildOp2,
  buildOp2Extra,
  buildOpDD,
  buildOpDDExtra,
  buildOpDL,
  -- Three parents
  buildOp3,
  -- Multiple parents
  buildOpVariable,
  buildOpVariableExtra,
  -- Registry functions
  registryNode,
  buildNodeRegistry
) where

import qualified Data.Map.Strict as M
import qualified Data.List.NonEmpty as N
import Control.Arrow ((&&&))
import Data.Text(Text)
import Data.ProtoLens.Message(Message)

import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.OpFunctions(convertToExtra, decodeExtra)
import Spark.Core.Internal.TypesStructures(DataType)
import Spark.Core.Internal.Utilities
import Spark.Core.Try

{-| Function that describes how to build a node, given some extra
data (which may be empty) and a context of all the parents' shapes.
-}
type BuilderFunction = OpExtra -> [NodeShape] -> Try CoreNodeInfo

type NodeDefName = Text

{-| Describes how to build a node.
-}
data NodeBuilder = NodeBuilder {
  nbName :: !NodeDefName,
  nbBuilder :: !BuilderFunction
}

{-| A registry for node functions. This is the
standard interface to build nodes from a set of existing nodes.
-}
data NodeBuilderRegistry = NodeBuilderRegistry {
  _registryNode :: NodeDefName -> Maybe NodeBuilder
}

{-| This is the typed interface to building nodes.

This allows developers to properly define a schema to the content.
-}
data TypedNodeBuilder a = TypedNodeBuilder !Text (a -> [NodeShape] -> Try CoreNodeInfo)

registryNode :: NodeBuilderRegistry -> NodeDefName -> Maybe NodeBuilder
registryNode = _registryNode

buildNodeRegistry :: [NodeBuilder] -> NodeBuilderRegistry
buildNodeRegistry l = NodeBuilderRegistry f where
  m = M.map N.head . myGroupBy $ (nbName &&& id) <$> l
  f ndn = M.lookup ndn m

buildOpExtra :: Message a => Text -> (a -> Try CoreNodeInfo) -> NodeBuilder
buildOpExtra opName f = untypedBuilder $ TypedNodeBuilder opName f' where
  f' a [] = f a
  f' _ l = tryError $ "buildOpExtra: "<>show' opName<>": got extra parents: "<>show' l

{-| Takes one argument, no extra.
-}
buildOp1 :: Text -> (NodeShape -> Try CoreNodeInfo) -> NodeBuilder
buildOp1 opName f = NodeBuilder opName f' where
  f' _ [] = tryError $ "buildOp1: "<>show' opName<>": missing parents "
  f' _ [ns] = f ns
  f' _ l = tryError $ "buildOp1: "<>show' opName<>": got extra parents: "<>show' l

buildOp1Extra :: Message a => Text -> (NodeShape -> a -> Try CoreNodeInfo) -> NodeBuilder
buildOp1Extra opName f = untypedBuilder $ TypedNodeBuilder opName f' where
  f' _ [] = tryError $ "buildOp1Extra: "<>show' opName<>": missing parents "
  f' a [ns] = f ns a
  f' _ l = tryError $ "buildOp1Extra: "<>show' opName<>": got extra parents: "<>show' l

{-| Takes one argument, no extra.
-}
buildOp2 :: Text -> (NodeShape -> NodeShape -> Try CoreNodeInfo) -> NodeBuilder
buildOp2 opName f = NodeBuilder opName f' where
  f' _ [] = tryError $ "buildOp2: "<>show' opName<>": missing parents "
  f' _ [ns1, ns2] = f ns1 ns2
  f' _ l = tryError $ "buildOp2: "<>show' opName<>": got extra parents: "<>show' l

buildOp2Extra :: Message a => Text -> (NodeShape -> NodeShape -> a -> Try CoreNodeInfo) -> NodeBuilder
buildOp2Extra opName f = untypedBuilder $ TypedNodeBuilder opName f' where
  f' _ [] = tryError $ "buildOp2Extra: "<>show' opName<>": missing parents "
  f' a [ns1, ns2] = f ns1 ns2 a
  f' _ l = tryError $ "buildOp2Extra: "<>show' opName<>": got extra parents: "<>show' l

{-| Takes one argument, no extra.
-}
buildOp3 :: Text -> (NodeShape -> NodeShape -> NodeShape -> Try CoreNodeInfo) -> NodeBuilder
buildOp3 opName f = NodeBuilder opName f' where
  f' _ [ns1, ns2, ns3] = f ns1 ns2 ns3
  f' _ l = tryError $ "buildOp3: "<>show' opName<>": expected 3 parent nodes, but got: "<>show' l

{-| Takes one dataframe, no extra.
-}
buildOpD :: Text -> (DataType -> Try CoreNodeInfo) -> NodeBuilder
-- TODO check that there is no extra
buildOpD opName f = buildOp1 opName f' where
  f' (NodeShape dt Local) = tryError $ "buildOpD: "<>show' opName<>": expected distributed node, but got a local node of type "<>show' dt<>" instead."
  f' (NodeShape dt Distributed) = f dt

buildOpDExtra :: Message a => Text -> (DataType -> a -> Try CoreNodeInfo) -> NodeBuilder
buildOpDExtra opName f = buildOp1Extra opName f' where
  f' (NodeShape dt Local) _ = tryError $ "buildOpDExtra: "<>show' opName<>": expected distributed node, but got a local node of type "<>show' dt<>" instead."
  f' (NodeShape dt Distributed) x = f dt x

{-| Takes two dataframes, no extra.
-}
buildOpDD :: Text -> (DataType -> DataType -> Try CoreNodeInfo) -> NodeBuilder
-- TODO check that there is no extra
buildOpDD opName f = buildOp2 opName f' where
  f' (NodeShape dt1 Distributed) (NodeShape dt2 Distributed) = f dt1 dt2
  f' ns1 ns2 = tryError $ "buildOpDD: "<>show' opName<>": expected two distributed nodes, but got a local node of type: "<>show' (ns1, ns2)

{-| Takes two dataframes, with extra.
-}
buildOpDDExtra :: (Message a) => Text -> (DataType -> DataType -> a -> Try CoreNodeInfo) -> NodeBuilder
buildOpDDExtra opName f = buildOp2Extra opName f' where
  f' (NodeShape dt1 Distributed) (NodeShape dt2 Distributed) x = f dt1 dt2 x
  f' ns1 ns2 _ = tryError $ "buildOpDD: "<>show' opName<>": expected two distributed nodes, but got a local node of type: "<>show' (ns1, ns2)


{-| Takes one dataframe, one local, no extra.
-}
buildOpDL :: Text -> (DataType -> DataType -> Try CoreNodeInfo) -> NodeBuilder
-- TODO check that there is no extra
buildOpDL opName f = buildOp2 opName f' where
  f' (NodeShape dt1 Distributed) (NodeShape dt2 Local) = f dt1 dt2
  f' ns1 ns2 = tryError $ "buildOpDL: "<>show' opName<>": expected two nodes (Distributed, Local), but got another combination node of type: "<>show' (ns1, ns2)

{-| Takes one observable, no extra.
-}
buildOpL :: Text -> (DataType -> Try CoreNodeInfo) -> NodeBuilder
-- TODO check that there is no extra
buildOpL opName f = buildOp1 opName f' where
  f' (NodeShape dt Local) = f dt
  f' (NodeShape dt Distributed) = tryError $ "buildOpD: "<>show' opName<>": expected local node, but got a distributed node of type "<>show' dt<>" instead."

buildOpLExtra :: Message a => Text -> (DataType -> a -> Try CoreNodeInfo) -> NodeBuilder
buildOpLExtra opName f = buildOp1Extra opName f' where
  f' (NodeShape dt Distributed) _ = tryError $ "buildOpLExtra: "<>show' opName<>": expected local node, but got a distributed node of type "<>show' dt<>" instead."
  f' (NodeShape dt Local) x = f dt x

{-| Takes a variable number of parents and some extra.

This should be used in special occasions, use the specialized ones instead.
-}
buildOpVariableExtra :: Message a => Text -> ([NodeShape] -> a -> Try CoreNodeInfo) -> NodeBuilder
buildOpVariableExtra opName f = untypedBuilder $ TypedNodeBuilder opName (flip f)

buildOpVariable :: Text -> ([NodeShape] -> Try CoreNodeInfo) -> NodeBuilder
buildOpVariable opName f = NodeBuilder opName f' where
  f' _ l = f l

{-| Converts a typed builder to an untyped builder.
-}
untypedBuilder :: Message a => TypedNodeBuilder a -> NodeBuilder
untypedBuilder (TypedNodeBuilder n f) = NodeBuilder n (_convertTyped f)

cniStandardOp :: Message a => Locality -> Text -> DataType -> a -> CoreNodeInfo
cniStandardOp loc opName dt extra = CoreNodeInfo {
    cniShape = NodeShape {
      nsType = dt,
      nsLocality = loc
    },
    cniOp = NodeDistributedOp StandardOperator {
      soName = opName,
      soOutputType = dt,
      soExtra = convertToExtra extra
    }
  }

{-| Builds a standard operator node that does not take extra arguments. -}
cniStandardOp' :: Locality -> Text -> DataType -> CoreNodeInfo
cniStandardOp' loc opName dt = CoreNodeInfo {
    cniShape = NodeShape {
      nsType = dt,
      nsLocality = loc
    },
    cniOp = NodeDistributedOp StandardOperator {
      soName = opName,
      soOutputType = dt,
      soExtra = emptyExtra
    }
  }


_convertTyped :: Message a => (a -> [NodeShape] -> Try CoreNodeInfo) -> BuilderFunction
_convertTyped _ o _ | o == emptyExtra = tryError "buildOp0: missing extra info"
_convertTyped f o l = decodeExtra o >>= \x -> f x l
