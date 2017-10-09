{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections #-}

{-| This module implements the core algebra of Karps with respect to
structured transforms. It takes functional structured transforms and flattens
them into simpler, flat projections.

This is probably one of the most complex parts of the optimizer.
-}
module Spark.Core.Internal.StructuredFlattening(
  structuredFlatten
) where

import Formatting
import Spark.Core.Internal.Utilities
import Data.List(nub)
import Data.Maybe(mapMaybe)
import qualified Data.Vector as V
import qualified Data.List.NonEmpty as N
import qualified Data.Map.Strict as M
import Data.List.NonEmpty(NonEmpty(..))

import Spark.Core.Internal.StructureFunctions
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.NodeBuilder(nbName)
import Spark.Core.Internal.ComputeDag
import Spark.Core.Internal.ContextStructures(ComputeGraph)
import Spark.Core.Internal.DAGStructures(Vertex(..), Edge(..), IndexedEdge(..), gIndexedEdges)
import Spark.Core.Internal.BrainStructures(makeParentEdge, nodeAsVertex)
import Spark.Core.Internal.TypesStructures(DataType(..), StrictDataType(Struct), StructType(..), StructField(..))
import Spark.Core.Internal.TypesFunctions(extractFields, structType', extractFields2)
import Spark.Core.Internal.DatasetStructures(OperatorNode(..), StructureEdge(ParentEdge), onOp, onPath, onType, onLocality)
import Spark.Core.Internal.DatasetFunctions(filterParentNodes)
import Spark.Core.InternalStd.Filter(filterBuilder)
import Spark.Core.StructuresInternal(FieldName(..), FieldPath(..), NodePath, nodePathAppendSuffix)
import Spark.Core.Try

{-| Takes a graph that may contain some functional nodes, and attempts to
apply these nodes as operands, flattening the inner functions and the groups
in the process.

This outputs a graph where all the functional elements have been replaced by
their low-level, imperative equivalents.

It works by doing the following:
 - build a new DAG in which the edges track the groupings.
 - traverse the DAG and apply the functional nodes
 - reconstuct the final DAG
-}
structuredFlatten :: ComputeGraph -> Try ComputeGraph
structuredFlatten cg = do
  -- The functional structures are identified.
  -- They are not fully parsed and may present errors.
  labeled <- _labelNodesInitial cg
  {- The final topology is in place:
   - nodes are identified and linked.
   - initial placeholders are linked to start node.
   - final node is connected to a single sink.
  -}
  connected <- _labelConnectNodes labeled
  -- return $ _labelConvert connected
  -- The transform is performed.
  let analyzed = _analyzeGraph connected
  trans <- _mainTransform analyzed
  -- -- Some post-processing for filter?
  -- undefined
  -- Convert the graph back to a compute graph, and add the preprocessing nodes.
  _mainTransformReturn trans
  -- -- fg <- _fgraph cg
  -- -- fg' <- _performTrans fg
  -- -- _fgraphBack cg fg'

{-| The different moves that happen in the stack of keys.

This is then used to infer the type and datatype of the key.
-}
data StackMove =
    StackEnter1 -- We are entering one more layer in the stack.
  | StackKeep -- We are maintainng our current position in the stack.
  | StackExit1 -- We are dropping the last key from the stack.
  deriving (Eq, Show)

-- Convenient shortcut
type CDag v = ComputeDag v StructureEdge

{-| The type of function that is applied:
-}
data NodeFunctionalType =
    {-| shuffle:
      overall: distributed -> distributed
      inner function: distributed -> local
    -}
    FunctionalShuffle
  deriving (Eq, Show)

-- data FunctionalNodeAnalysis = FunctionalNodeAnalysis {
--   fnaId :: !VertexId,
--   fnaType :: !NodeParseType,
--   fnaParent :: !VertexId, -- The direct parent of the functional node
--   fnaFunctionStart :: !VertexId, -- The placeholder that starts
--   fnaFunctionEnd :: !VertexId -- The final node of the function that ends
-- } deriving (Eq, Show)

-- ******* Initial parsing ********
-- This step verifies some basic topology. The shape invariants are supposed
-- to have been verified by the builders.

-- Labeling of nodes with information about the functional structure.
-- This is the forward pass structure.
data FunctionalParsing =
    -- The final node of a functional operation
    -- Includes itself, path of start, path of placeholder, path of sink.
    FConclusion OperatorNode NodeFunctionalType NodePath NodePath NodePath
    -- Some other node
  | FOther OperatorNode
  deriving (Show)

-- Labeling of the nodes with information about functional structure.
-- This is the output of the backward pass.
data FunctionalLabeling =
    -- The final node, see FConclusion
    FLFinal OperatorNode NodePath NodePath NodePath
    -- The sink node of the inner function.
    -- and the path of the final node
  | FLSink OperatorNode NodePath
    -- The start placeholder node and the path of the final node.
  | FLPlaceholder OperatorNode NodePath
    -- The start node that is the input to the functional operation.
    -- and the path of the final node.
  | FLStart OperatorNode NodePath
  | FLOther OperatorNode
  deriving (Show)

{-| Preliminary checks and labeling of nodes.
-}
_labelNodesInitial :: ComputeGraph -> Try (CDag FunctionalLabeling)
_labelNodesInitial cg = do
    -- Forward pass: identify the parents.
    cg1 <- computeGraphMapVertices cg fun1
    let rcg1 = reverseGraph cg1
    -- Backward pass: identify the inputs of the functional nodes.
    let rcg2 = computeGraphMapVerticesI rcg1 f2
    let cg2 = reverseGraph rcg2
    return cg2
  where
    functionalType :: OperatorNode -> Maybe NodeFunctionalType
    functionalType on = case onOp on of
      NodeDistributedOp so | soName so == nbName functionalShuffleBuilder -> Just FunctionalShuffle
      _ -> Nothing
    p :: FunctionalParsing -> NodePath
    p (FConclusion on _ _ _ _) = onPath on
    p (FOther on) = onPath on
    fun1 on l = f1' (functionalType on) on (filterParentNodes l)
    -- Just operates on the parents.
    f1' :: Maybe NodeFunctionalType -> OperatorNode -> [FunctionalParsing] -> Try FunctionalParsing
    f1' (Just nft) on [onInit, onPlaceholder, onSink] =
      -- TODO: could do more checks on the type of the placeholder too.
      pure $ FConclusion on nft (p onInit) (p onPlaceholder) (p onSink)
    f1' (Just _) on l =
      tryError $ sformat ("_labelNodesInitial: expected 3 parents "%sh%"but got "%sh) on l
    f1' Nothing on _ = pure $ FOther on
    findPlaceholderParent on = concatMap f where
      f (FLFinal onEnd _ pPlaceholder _ ) | onPath on == pPlaceholder = [FLPlaceholder on (onPath onEnd)]
      f _ = []
    f2 :: FunctionalParsing -> [(FunctionalLabeling, StructureEdge)] -> FunctionalLabeling
    f2 (FConclusion on _ pInit pPlaceholder pSink) _ = FLFinal on pInit pPlaceholder pSink
    f2 (FOther on) l = traceHint ("_labelNodesInitial: on="<>show' on<>" l="<>show' l<>" res=") $ case filterParentNodes l of
      [FLFinal onEnd pInit _ _] | onPath on == pInit -> FLStart on (onPath onEnd)
      [FLFinal onEnd _ _ pSink] | onPath on == pSink -> FLSink on (onPath onEnd)
      -- Try to isolate a placeholder out of all the parents
      lp -> case findPlaceholderParent on lp of
          -- TODO: it is a programming errors to find multiple parents.
          -- We should return an error in that case.
          (x:_) -> x
          [] -> FLOther on -- No placeholder parent

{-| Connects the functional nodes:
 - the placeholder is not connected to the start
 - the sink is disconnected from the start and the placeholder.
-}
_labelConnectNodes :: CDag FunctionalLabeling -> Try (CDag FunctionalLabeling)
_labelConnectNodes cg = do
    cg1 <- tryEither $ graphAdd cg [] eds
    return $ graphFilterEdges' cg1 fun
  where
    -- We add one edge between the start and the placeholder.
    eds = concatMap f (graphVertexData cg) where
      f (FLFinal _ pInit pPlaceholder _) = [makeParentEdge pInit pPlaceholder]
      f _ = []
    -- Remember that True == we keep it.
    fun FLFinal{} ParentEdge FLStart{} = False
    fun FLFinal{} ParentEdge FLPlaceholder{} = False
    fun _ _ _ = True

-- Temporary while the function is not complete.
_labelConvert :: CDag FunctionalLabeling -> ComputeGraph
_labelConvert = mapVertexData (_onFunctionalLabel . traceHint "_labelConvert: x=")

_onFunctionalLabel :: FunctionalLabeling -> OperatorNode
_onFunctionalLabel (FLFinal on _ _ _) = on
_onFunctionalLabel (FLSink on _) = on
_onFunctionalLabel (FLPlaceholder on _) = on
_onFunctionalLabel (FLStart on _) = on
_onFunctionalLabel (FLOther on) = on

-- ************ Initial analysis *********
-- This pass does not calculate datatypes or transforms, but
-- extracts all the information required from the nodes.
-- It does not modify the operations nor does it add extra columns for the key.
-- All these passes could be combined in one big pass, but it is easier
-- to reason about them separately for the time being.

{-| The different types of nodes that are recognized by the algorithm.
-}
data FNodeType =
    FDistributedTransform ColOp -- Parents are assumed to be distributed too.
  | FLocalTransform ColOp -- Parents are assumed to be local or aggs.
  | FImperativeAggregate AggOp -- A call to a low-level aggregate (reduce)
  | FImperativeShuffle AggOp -- The keyed reduction.
  | FEnter -- The placeholder that starts the functional shuffle.
  | FExit -- The sink node for functional operations. Nothing special happens on this node.
  | FUnknown -- Some unknown type of node (allowed at the top level)
  | FFilter -- A filter operation.
  -- Unimplemented other operations for now
  -- | FLocalPack
  deriving (Eq, Show)

{-| A node, once the functional analysis has been conducted.

This node does not do type checking when being built.

Arguments:
 - the original operator node
 - the stack move that is associated with this operator
 - the interpretation of the node
-}
data FNode = FNode OperatorNode FNodeType deriving (Eq, Show)


_analyzeGraph :: CDag FunctionalLabeling -> CDag FNode
_analyzeGraph cg = computeGraphMapVerticesI cg f' where
  -- Just consider the parents
  f' fl _ = FNode on' (f (onOp on') fl) where
    on' = _onFunctionalLabel fl
  -- To check on the parents for now
  f :: NodeOp -> FunctionalLabeling -> FNodeType
  f _ FLPlaceholder{} = FEnter
  f _ FLFinal{} = FExit
  f (NodeReduction ao) _ = FImperativeAggregate ao
  f (NodeGroupedReduction ao) _ = FImperativeShuffle ao
  f (NodeStructuredTransform co) _ = FDistributedTransform co
  f (NodeLocalStructuredTransform co) _ = FLocalTransform co
  f (NodeDistributedOp so) _ | soName so == nbName filterBuilder = FFilter
  -- We do not know about any other node for now.
  f _ _ = FUnknown

-- ******** Transform **********
-- This is the step that attempts to perform the transform.

{- Details on the layout of the data.

For nodes at the top level, the datatype does not change.

For nodes inside a stack, the datatype is encapsulated inside a structure, in
the following form:
{key:{key1:DT1, .... keyN:DTN}, value:DT}
DT.. and DT are determined by the grouping operations.
keyN is the deepest key, which corresponds to the top of the stack.

The scheme above is robust to any collision with user-specified column names,
but it requires a bit more bookkeeping to go in out of the top level and to
add new keys.
-}

{-| The different types of nodes that will be output.
Every non-unknown node translate to one of these.
-}
data FPNodeType =
    FPDistributedTransform ColOp
  | FPLocalTransform ColOp
  | FPImperativeAggregate AggOp
  | FPImperativeShuffle AggOp
  | FPFilter
  | FPUnknown
  deriving (Eq, Show)


type FStack = [NodePath]
type FStack' = NonEmpty NodePath

{-| Like the functional node, but with the stack of all the entrances that
have not been closed by exits so far.

This is important to know with respect to the unknown nodes.

The operator node and the node type contain the final node operation and
node type (with key information plugged in).
-}
data FPostNode = FPostNode {
  fpnNode :: !OperatorNode,
  _fpnType :: !FPNodeType,
  fpnStack :: !FStack,
  fpnPreNode :: !(Maybe OperatorNode)
} deriving (Eq, Show)

fpostNode :: OperatorNode -> FPNodeType -> FStack -> FPostNode
fpostNode on fpnt fs = FPostNode on fpnt fs Nothing

{-| The main transform.

This transform does not add conversion nodes required by some operators.

This function only works with linear transforms for now. Only a single parent
is accepted. Multiparent, multi-level transforms will added in the future.
-}
_mainTransform :: CDag FNode -> Try (CDag FPostNode)
_mainTransform cg = computeGraphMapVertices cg fun where
  -- For the unknown nodes, just let them go through at the root level.
  -- The only case accepted for now is top level with multiple parents and
  -- single parent inside stacks.
  -- Anything else is rejected.
  fun :: FNode -> [(FPostNode, StructureEdge)] -> Try FPostNode
  fun (FNode on fnt) l = do
      currentStack <- currentStackt
      _ <- check1Parent currentStack parents
      f1 currentStack parentTypes fnt on
    where
      parents = filterParentNodes l
      parentTypes = onType . fpnNode <$> parents
      parentsStacks = fpnStack <$> parents
      currentStackt = _currentStackSame parentsStacks
      -- Checks that there is only parent for deeper nodes.
      check1Parent [] _ = pure ()
      check1Parent (_:_) [] = pure ()
      check1Parent (_:_) [_] = pure ()
      check1Parent (_:_) parents' =
        tryError $ sformat ("Found more than one parent in the stack parents="%sh%" node="%sh) parents' on
    -- else tryError $ sformat ("Trying to use unrecognized node inside a keyed function:"%sh%" its parents are "%sh) on l

_mainTransformReturn :: CDag FPostNode -> Try ComputeGraph
-- TODO: this is pretty heavy and completely reconstructs the graph from
-- scratch using indexed edges. There should be a function that does
-- add-nodes-and-swap
_mainTransformReturn cg = tryEither $
    buildGraphFromList' vertices' (iedges2 ++ edges1) inputs outputs where
  -- Find all the pairs of pre-nodes and nodes.
  -- For these, we need to a) insert an edge between the two, and b) swap the
  -- incoming edges.
  -- The pairs of nodes that will need to be modified: (preNode, node)
  withPre = mapMaybe f (V.toList (cdVertices cg)) where
    f (Vertex _ fpn) = (,fpnNode fpn) <$> fpnPreNode fpn
  vertices1 = nodeAsVertex . fst <$> withPre
  vertices2 = fmap fpnNode <$> V.toList (cdVertices cg)
  vertices' = vertices2 ++ vertices1
  -- We should not have changed inputs and outputs, so no need to perform
  -- swapping here.
  inputs = vertexId <$> V.toList (cdInputs cg)
  outputs = vertexId <$> V.toList (cdOutputs cg)
  iedges = gIndexedEdges (computeGraphToGraph cg)
  numEdges = length iedges
  edges1 = f <$> zip [numEdges..] withPre where
    f (idx, (pre, n)) = IndexedEdge {
          iedgeFromIndex = idx,
          iedgeFrom = edgeFrom e,
          iedgeToIndex = idx,
          iedgeTo = edgeTo e,
          iedgeData = edgeData e
        } where e = makeParentEdge (onPath pre) (onPath n)
  -- The new vertices
  -- TODO: I always get confused which one is the first or the last, so just
  -- putting the two there. It should not be a problem because we are adding
  -- a new node.
  swapDct = M.fromList $ concatMap f edges1 where
    f v = [(iedgeFrom v, iedgeTo v), (iedgeTo v, iedgeFrom v)]
  -- For all the edges that were coming to the node, point them to the
  -- prenode instead.
  iedges2 = f <$> iedges where
    f ie = ie1 where
        ie1 = case iedgeFrom ie `M.lookup` swapDct of
          Just vid -> ie { iedgeFrom = vid }
          Nothing -> ie
        -- ie2 = case iedgeTo ie1 `M.lookup` swapDct of
        --   Just vid -> ie1 { iedgeTo = vid }
        --   Nothing -> ie1

-- Given the current stack, transforms the current operation.
-- Most of the actual work is delegated to subfunctions.
-- This function does not leave the graph in a proper state: some operations
-- such as filter require structural transforms before and after the filter
-- itself.
-- TODO: rename to _flatteningMain
f1 ::
  FStack -> -- The stack of the parents
  [DataType] -> -- The datatype of the parents (including the key)
  FNodeType -> -- The current node type
  OperatorNode -> -- The op node of the current node
  Try FPostNode -- The result of the operation.
-- Enters: they should have only one parent.
f1 [] [dt] FEnter on = _performEnter0 dt on
f1 (h:t) [dt] FEnter on = _performEnter (h:|t) dt (onPath on)
f1 _ _ FEnter on = tryError $ "_flatteningMain: wrong FEnter on "<>show' on
-- Exits: should have one parent and be inside a stack.
f1 [] _ FExit on = tryError $ sformat ("Trying to exit a functional group, but there no group to exit from. node:"%sh) on
f1 (h:t) [dt] FExit on = _performExit (h:|t) dt (onPath on) (onLocality on)
f1 _ _ FExit on = tryError $ "_flatteningMain: wrong FExit on "<>show' on
-- Any node at the top level -> go through
f1 [] _ FUnknown on = pure $ fpostNode on FPUnknown []
f1 [] _ (FDistributedTransform co) on = pure $ fpostNode on (FPDistributedTransform co) []
f1 [] _ (FLocalTransform co) on = pure $ fpostNode on (FPLocalTransform co) []
f1 [] _ (FImperativeAggregate ao) on = pure $ fpostNode on (FPImperativeAggregate ao) []
f1 [] _ (FImperativeShuffle ao) on = pure $ fpostNode on (FPImperativeShuffle ao) []
f1 [] _ FFilter on = pure $ fpostNode on FPFilter []
-- Unknown at a higher level -> error
f1 l _ FUnknown on = tryError $ sformat ("Unknown node found inside stack "%sh%": node="%sh) l on
-- Distribute transform within a group.
f1 (h:t) [dt] (FDistributedTransform co) on = _performDistributedTrans (h:|t) dt (onPath on) (onType on) co
f1 _ _ (FDistributedTransform _) on = tryError $ "_flatteningMain: wrong FDistributedTransform on "<>show' on
f1 (h:t) [dt] (FImperativeAggregate ao) on = _performAggregate (h:|t) dt (onPath on) (onType on) ao
f1 _ _ (FImperativeAggregate _) on = tryError $ "_flatteningMain: wrong FImperativeAggregate on "<>show' on
-- Filters
f1 (h:t) [dt] FFilter on = _performFilter (h:|t) dt (onPath on)
f1 _ _ FFilter on = tryError $ "_flatteningMain: wrong FFilter on "<>show' on
-- Missing
f1 _ _ (FLocalTransform _) on = missing $ "_flatteningMain: FLocalTransform"<>show' on
f1 _ _ (FImperativeShuffle _) on = missing $ "_flatteningMain: FImperativeShuffle"<>show' on

{-| Entering from the root. The input is expected to be
-}
_performEnter0 :: (HasCallStack) => DataType -> OperatorNode -> Try FPostNode
_performEnter0 dt on = do
    -- The parent data type should be a struct of the form {key:dt1, value:dt2}
    -- Isolate both parts and write a projection operator for it
    (keyDt, valueDt) <- _getStartPair dt
    let dt' = _keyGroupType (keyDt:|[]) valueDt
    -- TODO: for now, just handling distributed nodes at the entrance.
    let on' = on {onNodeInfo = coreNodeInfo dt' Distributed no}
    return $ fpostNode on' (FPDistributedTransform co) [p]
  where
    co = _colStruct [
        TransformField _key (_colStruct [
            TransformField (_keyIdx 1) $ _extraction [_key]
          ]),
        TransformField _group $ _extraction [_value]
      ]
    no = NodeStructuredTransform co
    p = onPath on

{-| Entering within a stack. -}
_performEnter :: FStack' -> DataType -> NodePath -> Try FPostNode
_performEnter (h:|t) dt np = do
    -- The parent data type should be a struct of the form:
    -- {key:{...}, value:{key:keyDT, value:valueDT}}
    -- We need to shift the inner key to the other ones and move the value
    -- one level up.
    (keyDt1:|keyDts, groupDt) <- _getGroupedType dt
    (innerKeyDt, valueDt) <- _getStartPair groupDt
    let dt' = _keyGroupType (innerKeyDt:|keyDt1:keyDts) valueDt
    let on' = OperatorNode nid np $ coreNodeInfo dt' Distributed no
    return $ fpostNode on' (FPDistributedTransform co) (np:h:t)
  where
    -- The initial number of keys, which is how we are going to build
    -- the extraction.
    numKeys = length (h:t)
    -- The original keys, nothing special other than moving them.
    fields = f <$> [1..numKeys] where
      f idx = TransformField (_keyIdx idx) $ _extraction [_key, _keyIdx idx]
    newField = TransformField (_keyIdx (numKeys + 1)) $ _extraction [_value, _key]
    co = _colStruct [
        TransformField _key (_colStruct (fields ++ [newField])),
        TransformField _group $ _extraction [_group, _value]
      ]
    no = NodeStructuredTransform co
    nid = error "_performEnter: id not computed"

{-| Exit: the top key is moved from the stack onto the value group.

If this is the last value, we just simplify the key names.
-}
_performExit :: FStack' -> DataType -> NodePath -> Locality -> Try FPostNode
_performExit (_:|t) dt np loc = do
    -- Get the current types in the keys
    (keyDts, groupDt) <- _getGroupedType dt
    case N.tail keyDts of
      [] -> do
        -- We drop the structure for the keys, there is only one key.
        let co = _colStruct [
              TransformField _key $ _extraction [_key, _keyIdx 1],
              TransformField _value $ _extraction [_group]]
        let dt' = structType' (StructField _key (N.head keyDts) :| [StructField _group groupDt])
        let no = exitTrans co
        let on' = OperatorNode nid np $ coreNodeInfo dt' loc no
        return $ fpostNode on' (exitFTrans co) t
      (hdt:tdt) -> do
        -- We still have some keys that need to be kept around.
        -- Move the last key from the key group into the value group.
        -- Drop the last key from the key group.
        let co = _colStruct [
                TransformField _key keyCo,
                TransformField _group $ _colStruct [
                  TransformField _key $ _extraction [_key, _keyIdx (numRemKeys + 1)],
                  TransformField _value $ _extraction [_group]
                ]]
        let no = exitTrans co
        let dt' = _keyGroupType (hdt:|tdt) groupDt
        let on' = OperatorNode nid np $ coreNodeInfo dt' loc no
        return $ fpostNode on' (exitFTrans co) t
  where
    (exitFTrans, exitTrans) = case loc of
      Distributed -> (FPDistributedTransform, NodeStructuredTransform)
      Local -> (FPLocalTransform, NodeLocalStructuredTransform)
    nid = error "_performExit: id not computed"
    numRemKeys = length t -- The number of remaining keys
    keyCo = _colStruct (f <$> [1..numRemKeys]) where
      f idx = TransformField (_keyIdx idx) $ _extraction [_key, _keyIdx idx]

_performDistributedTrans ::
  FStack' ->
  DataType -> -- The start datatype. Must be a group data type.
  NodePath -> -- The path of the current node.
  DataType -> -- The result data type of the transform.
  ColOp -> -- The current op
  Try FPostNode
_performDistributedTrans (h:|t) parentDt np dt co = do
    (keyDts, _) <- _getGroupedType parentDt
    let dt' = _keyGroupType keyDts dt
    let on' = makeOp dt'
    return $ fpostNode on' (FPDistributedTransform co') (h:t)
  where
    -- Unlike aggregation, transforms must be wrapped to account for the groups:
    --  1. the extractors must peek inside the group
    --  2. the result must also transform the keyset (which is unchanged)
    gCo = _wrapGroup co
    co' = _colStruct [
            TransformField _key $ _extraction [_key],
            TransformField _group gCo]
    no = NodeStructuredTransform co'
    nid = error "_performDistributedTrans: id not computed"
    makeOp dt' = OperatorNode nid np $ coreNodeInfo dt' Distributed no


{-| Performs the aggregate inside a stack.
-}
_performAggregate :: (HasCallStack) =>
  FStack' ->
  DataType -> -- The start data type. Must be a group data type.
  NodePath -> -- The path of the current node
  -- The result data type of the aggregation,
  -- It is expected to be a structure {key:X, value:Y}
  -- (this corresponds to the application of an aggregation outside a stack)
  DataType ->
  -- The op
  AggOp ->
  Try FPostNode
_performAggregate (h:|t) parentDt np dt ao = do
    (keysDt, _) <- _getGroupedType parentDt
    let dt' = _keyGroupType keysDt dt
    return $ fpostNode (on' dt') (FPImperativeShuffle ao) (h:t)
  where
    -- Wrap the aggregation:
    --  1. the extractors need not be rewritten because they already expect
    --     the values to be in a sub-field called 'value'
    --  2. the output is itseld inside a group, and this is already taken
    --     into account by the backend.
    -- ao' = AggStruct . V.fromList $ [AggField _group ao]
    no = NodeGroupedReduction ao
    nid = error "_performAggregate: id not computed"
    on' dt' = OperatorNode nid np $ coreNodeInfo dt' Distributed no

{-|
The filtering. It builds 3 nodes:
 - a preprocessing node that moves the keys inside the value and exposes
   the filter column
 - the filter node
There is no need for post processing since the outcome of the fister is
already in the proper position.
-}
_performFilter ::
  FStack' ->
  -- The start data type. Must be a group data type of the following structure:
  -- {key:{...}, value:{filter:bool, value:XX}}
  DataType ->
  NodePath -> -- The path of the current node
  -- The result data type of the aggregation,
  -- It is expected to be a structure {key:X, value:Y}
  -- (this corresponds to the application of an aggregation outside a stack)
  Try FPostNode
_performFilter (h:|t) parentDt np = do
    (keysDt, valueDt) <- _getGroupedType parentDt
    (filtDt, valDt) <- extractFields2 "filter" "value" valueDt
    let finalType = _keyGroupType keysDt valDt
    let preType = structType' $ StructField "filter" filtDt :| [StructField "value" finalType]
    return $ FPostNode (filtNode finalType) FPFilter (h:t) (Just (preNode preType))
  where
    co = _colStruct [
            TransformField "filter" $ _extraction [_group, "filter"],
            TransformField "value" $ _colStruct [
              TransformField _key $ _extraction [_key],
              TransformField _group $ _extraction [_group, "value"]
            ]
          ]
    no = NodeStructuredTransform co
    nid = error "_performFilter: id not computed"
    npPre = nodePathAppendSuffix np "_kagg_filter"
    preNode dt' = OperatorNode nid npPre $ coreNodeInfo dt' Distributed no
    filtNode dt' = OperatorNode nid np cni where
      so = StandardOperator (nbName filterBuilder) dt' emptyExtra
      no' = NodeDistributedOp so
      cni = coreNodeInfo dt' Distributed no'


_extraction :: [FieldName] -> ColOp
_extraction = ColExtraction . FieldPath . V.fromList

_colStruct :: [TransformField] -> ColOp
_colStruct = ColStruct . V.fromList


-- Is this stack for the top level?
_isTopLevel :: FStack -> Bool
_isTopLevel [] = True
_isTopLevel _ = False

{-| Checks that all the given stacks are the same.
-}
_currentStackSame :: [FStack] -> Try FStack
_currentStackSame [] = pure [] -- No parent -> root level
_currentStackSame (h:t) = case N.nub (h :| t) of
  (s :| []) -> pure s
  _ -> tryError $ sformat ("_currentStackSame: Nodes with different stacks cannot be merged: "%sh) (h:t)


{-| The name of the field that holds the keys.
-}
_key :: FieldName
_key = "key"

{-| The name of the field that holds the values. -}
_group :: FieldName
-- TODO: harmonize everywhere to this, it is much simpler to
-- have a single name when dealing with operators that expect a pair.
_group = "value"

-- TODO: remove
_value :: FieldName
_value = "value"

-- | Given a key index, returns the corresponding field name.
_keyIdx :: Int -> FieldName
_keyIdx idx = FieldName $ "key_" <> show' idx

-- Builds an extractor for a given key
_keyExtractor :: Int -> ColOp
_keyExtractor idx = ColExtraction . FieldPath . V.fromList $ [_key, _keyIdx idx]

-- The extractor for the group.
_groupExtractor :: ColOp
_groupExtractor = ColExtraction . FieldPath . V.singleton $ _group

-- The extractor for the entire set of keys.
_keyStructExtractor :: ColOp
_keyStructExtractor = ColExtraction . FieldPath . V.fromList $ [_key]

-- The name of the field that holds values at the start of a functional block.
_startValue :: FieldName
_startValue = "value"

-- Attempts to pattern match this data type into {key: dt1, value: dt2}
-- which is what is expected at the start node.
_getStartPair :: (HasCallStack) => DataType -> Try (DataType, DataType)
_getStartPair (StrictType (Struct (StructType v))) = case V.toList v of
  [StructField n1 dt1, StructField n2 dt2] | n1 == _key && n2 == _startValue -> pure (dt1, dt2)
  _ -> tryError $ sformat ("_getStartPair: could not find key,value pair from the inner struct "%sh) v
_getStartPair dt = tryError $ sformat ("_getStartPair: could not find key,value pair in the type "%sh) dt

-- Attempts to extract the types of the keys and the type of the value.
_getGroupedType :: (HasCallStack) => DataType -> Try (NonEmpty DataType, DataType)
_getGroupedType (StrictType (Struct (StructType v))) = case V.toList v of
  [StructField n1 dt1, StructField n2 dt2] | n1 == _key && n2 == _group -> (,dt2) <$> l1 where
    -- It does not check the names of the fields, they are assumed to be in order
    -- with the uppermost the first and the deepest the last.
    l1 = case dt1 of
      (StrictType (Struct (StructType v'))) -> case f <$> V.toList v' of
        [] -> tryError "_getGroupedType: empty key struct"
        (h:t) -> pure (N.reverse (h:|t))
      _ -> tryError $ sformat ("_getGroupedType: expected struct for keys but got "%sh) dt1
    f (StructField _ dt') = dt'
  _ -> tryError $ sformat ("_getGroupedType: could not find key,value pair from the inner struct "%sh) v
_getGroupedType dt = tryError $ sformat ("_getGroupedType: could not find key,value pair in the type "%sh) dt


{-| builds the data type of a keyed group.

The deepest key is the head.
Second arg is the group type.
-}
_keyGroupType :: NonEmpty DataType -> DataType -> DataType
_keyGroupType (h:|t) groupDt = structType' (df1:|[df2]) where
  -- Accomodate for the fact that the deepest key is the head.
  indexedKeys = N.reverse (N.zip (1:|[2..]) (N.reverse (h:|t)))
  keyDt = structType' $ f <$> indexedKeys where
    f (idx,dt) = StructField (_keyIdx idx) dt
  df1 = StructField _key keyDt
  df2 = StructField _group groupDt

-- Given a list of stacks (coming from all the parents), tries to
-- find the deepest stack. All the other ones are supposed to a prefix
-- of the deepest.
_currentStack :: [FStack] -> Try FStack
_currentStack [] = pure []
_currentStack l = do
    head' <- headt
    rest <- restt
    return $ head' : rest
  where
    groups = concatMap f l where
      f (h : t) = [(h, t)]
      f _ = []
    headt = checkTop (fst <$> groups)
    restt = _currentStack (snd <$> groups)
    checkTop l' = case nub l' of
      [] -> tryError "_currentStack: empty"
      [x] -> pure x
      l'' -> tryError $ sformat ("_currentStack: one of the node paths is not a proper subset of the other: "%sh%" list of paths:"%sh) l'' l

_extractGroupType :: DataType -> Try (DataType, DataType)
_extractGroupType dt = do
  l <- extractFields [_key, _value] dt
  case l of
    [keyDt, valueDt] -> pure (keyDt, valueDt)
    _ -> tryError $ sformat ("_extractGroupType: expected a structure with 2 field, but got "%sh) dt


{-| Takes a col and makes sure that the extraction patterns are wrapped inside
the group instead of directly accessing the field path.
-}
_wrapGroup :: ColOp -> ColOp
-- TODO: make this function pure.
_wrapGroup (ColBroadcast _) = error "_wrapGroup: ColBroadcast encountered. It should have been removed already"
_wrapGroup (ColExtraction fp) = ColExtraction (_wrapFieldPath fp)
_wrapGroup (ColFunction sn v t) = ColFunction sn (_wrapGroup <$> v) t
_wrapGroup (x @ ColLit{}) = x
_wrapGroup (ColStruct v) = ColStruct (f <$> v) where
  f (TransformField fn v') = TransformField fn (_wrapGroup v')

{-| Takes an agg and wraps the extraction patterns so that it accesses inside
the group instead of the top-level field path.
-}
_wrapAgg :: AggOp -> AggOp
_wrapAgg (AggUdaf ua ucn fp) = AggUdaf ua ucn (_wrapFieldPath fp)
_wrapAgg (AggFunction sfn fp t) = AggFunction sfn (_wrapFieldPath fp) t
_wrapAgg (AggStruct v) = AggStruct (f <$> v) where
  f (AggField fn v') = AggField fn (_wrapAgg v')

_wrapFieldPath :: FieldPath -> FieldPath
_wrapFieldPath (FieldPath v) = FieldPath v' where
  v' = V.fromList (_value : V.toList v)
