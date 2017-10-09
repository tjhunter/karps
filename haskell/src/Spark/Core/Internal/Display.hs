{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

{-| This module takes compute graph and turns them into a string representation
 that is easy to display using TensorBoard. See the python and Haskell
 frontends to see how to do that given the string representations.
-}
module Spark.Core.Internal.Display(
  displayGraph
) where

import qualified Data.Map as M
import qualified Data.Vector as V
import qualified Data.Text as T
import Data.Text(Text)
import Data.Default
import Lens.Family2 ((&), (.~))
import Data.Monoid((<>))
import Data.Text.Encoding(encodeUtf8)
import Data.Functor.Identity(runIdentity, Identity)

import qualified Proto.Tensorflow.Core.Framework.Graph as PG
import qualified Proto.Tensorflow.Core.Framework.NodeDef as PN
import qualified Proto.Tensorflow.Core.Framework.AttrValue as PAV
import Spark.Core.Internal.ContextStructures(ComputeGraph)
import Spark.Core.Internal.ComputeDag(computeGraphMapVertices, cdVertices)
import Spark.Core.Internal.DAGStructures(Vertex(vertexData))
import Spark.Core.Internal.OpStructures(OpExtra(opContentDebug))
import Spark.Core.Internal.OpFunctions(simpleShowOp, extraNodeOpData)
import Spark.Core.Internal.DatasetStructures(OperatorNode(..), StructureEdge(..), onOp, onType, onLocality)
import Spark.Core.StructuresInternal(prettyNodePath)
import Spark.Core.Internal.Utilities(show')

{-| Converts a compute graph to a form that can be displayed by TensorBoard.
-}
displayGraph :: ComputeGraph -> PG.GraphDef
displayGraph cg = PG.GraphDef nodes where
  f :: OperatorNode -> [(PN.NodeDef, StructureEdge)] -> Identity PN.NodeDef
  f on l = pure $ _displayNode on parents logical where
             f' edgeType = PN._NodeDef'name . fst <$> filter ((edgeType ==).snd) l
             parents = f' ParentEdge
             logical = f' LogicalEdge
  cg2 = runIdentity $ computeGraphMapVertices cg f
  nodes = vertexData <$> V.toList (cdVertices cg2)


_displayNode :: OperatorNode -> [Text] -> [Text] -> PN.NodeDef
_displayNode on parents logical = (def :: PN.NodeDef)
    & PN.name .~ (trim . prettyNodePath . onPath $ on)
    & PN.input .~ (trim <$> parents ++ (("^" <>) . trim <$> logical))
    & PN.op .~ simpleShowOp (onOp on)
    & PN.attr .~ _attributes on
    & PN.device .~ "/spark:0" where
  trim txt
      | T.null txt = ""
      | T.head txt == '/' = T.tail txt
      | otherwise = txt

_attributes :: OperatorNode -> M.Map Text PAV.AttrValue
_attributes on = M.fromList [("type", t), ("locality", l), ("zextra", e)] where
  l' = encodeUtf8 . show' . onLocality $ on
  t' = encodeUtf8 . show' . onType $ on
  e' = encodeUtf8 . _clean . opContentDebug . extraNodeOpData . onOp $ on
  l = (def :: PAV.AttrValue) & PAV.s .~ l'
  t = (def :: PAV.AttrValue) & PAV.s .~ t'
  e = (def :: PAV.AttrValue) & PAV.s .~ e'

_clean :: Text -> Text
_clean = T.replace "\"" "." . T.replace "\n" "" . T.replace "\\" ""
