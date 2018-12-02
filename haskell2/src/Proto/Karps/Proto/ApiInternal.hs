{- This file was auto-generated from karps/proto/api_internal.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.ApiInternal
       (AnalysisMessage(..), CompilerStep(..), CompilingPhase(..),
        CompilingPhase(), CompilingPhase'UnrecognizedValue,
        ErrorMessage(..), ErrorMessage'StackElement(..),
        GraphTransformRequest(..), GraphTransformResponse(..),
        MessageSeverity(..), MessageSeverity(),
        MessageSeverity'UnrecognizedValue, NodeBuilderRequest(..),
        NodeBuilderResponse(..), NodeMapItem(..))
       where
import qualified Data.ProtoLens.Reexport.Lens.Labels.Prism
       as Lens.Labels.Prism
import qualified Data.ProtoLens.Reexport.Prelude as Prelude
import qualified Data.ProtoLens.Reexport.Data.Int as Data.Int
import qualified Data.ProtoLens.Reexport.Data.Word as Data.Word
import qualified Data.ProtoLens.Reexport.Data.ProtoLens
       as Data.ProtoLens
import qualified
       Data.ProtoLens.Reexport.Data.ProtoLens.Message.Enum
       as Data.ProtoLens.Message.Enum
import qualified
       Data.ProtoLens.Reexport.Data.ProtoLens.Service.Types
       as Data.ProtoLens.Service.Types
import qualified Data.ProtoLens.Reexport.Lens.Family2
       as Lens.Family2
import qualified Data.ProtoLens.Reexport.Lens.Family2.Unchecked
       as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Reexport.Data.Default.Class
       as Data.Default.Class
import qualified Data.ProtoLens.Reexport.Data.Text as Data.Text
import qualified Data.ProtoLens.Reexport.Data.Map as Data.Map
import qualified Data.ProtoLens.Reexport.Data.ByteString
       as Data.ByteString
import qualified Data.ProtoLens.Reexport.Data.ByteString.Char8
       as Data.ByteString.Char8
import qualified Data.ProtoLens.Reexport.Lens.Labels as Lens.Labels
import qualified Data.ProtoLens.Reexport.Text.Read as Text.Read
import qualified Proto.Karps.Proto.Computation
import qualified Proto.Karps.Proto.Graph
import qualified Proto.Karps.Proto.Spark
import qualified Proto.Tensorflow.Core.Framework.Graph

{- | Fields :

    * 'Proto.Karps.Proto.ApiInternal_Fields.computation' @:: Lens' AnalysisMessage Proto.Karps.Proto.Computation.ComputationId@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'computation' @:: Lens' AnalysisMessage
  (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.session' @:: Lens' AnalysisMessage Proto.Karps.Proto.Computation.SessionId@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'session' @:: Lens' AnalysisMessage
  (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.relevantId' @:: Lens' AnalysisMessage Proto.Karps.Proto.Graph.NodeId@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'relevantId' @:: Lens' AnalysisMessage
  (Prelude.Maybe Proto.Karps.Proto.Graph.NodeId)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.path' @:: Lens' AnalysisMessage Proto.Karps.Proto.Graph.Path@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'path' @:: Lens' AnalysisMessage (Prelude.Maybe Proto.Karps.Proto.Graph.Path)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.content' @:: Lens' AnalysisMessage Data.Text.Text@
    * 'Proto.Karps.Proto.ApiInternal_Fields.level' @:: Lens' AnalysisMessage MessageSeverity@
    * 'Proto.Karps.Proto.ApiInternal_Fields.stackTracePretty' @:: Lens' AnalysisMessage Data.Text.Text@
 -}
data AnalysisMessage = AnalysisMessage{_AnalysisMessage'computation
                                       ::
                                       !(Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId),
                                       _AnalysisMessage'session ::
                                       !(Prelude.Maybe Proto.Karps.Proto.Computation.SessionId),
                                       _AnalysisMessage'relevantId ::
                                       !(Prelude.Maybe Proto.Karps.Proto.Graph.NodeId),
                                       _AnalysisMessage'path ::
                                       !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                                       _AnalysisMessage'content :: !Data.Text.Text,
                                       _AnalysisMessage'level :: !MessageSeverity,
                                       _AnalysisMessage'stackTracePretty :: !Data.Text.Text,
                                       _AnalysisMessage'_unknownFields :: !Data.ProtoLens.FieldSet}
                         deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f AnalysisMessage x a, a ~ b) =>
         Lens.Labels.HasLens f AnalysisMessage AnalysisMessage x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AnalysisMessage "computation"
           (Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'computation
                 (\ x__ y__ -> x__{_AnalysisMessage'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AnalysisMessage "maybe'computation"
           (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'computation
                 (\ x__ y__ -> x__{_AnalysisMessage'computation = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AnalysisMessage "session"
           (Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'session
                 (\ x__ y__ -> x__{_AnalysisMessage'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AnalysisMessage "maybe'session"
           (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'session
                 (\ x__ y__ -> x__{_AnalysisMessage'session = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AnalysisMessage "relevantId"
           (Proto.Karps.Proto.Graph.NodeId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'relevantId
                 (\ x__ y__ -> x__{_AnalysisMessage'relevantId = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AnalysisMessage "maybe'relevantId"
           (Prelude.Maybe Proto.Karps.Proto.Graph.NodeId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'relevantId
                 (\ x__ y__ -> x__{_AnalysisMessage'relevantId = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AnalysisMessage "path"
           (Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'path
                 (\ x__ y__ -> x__{_AnalysisMessage'path = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AnalysisMessage "maybe'path"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'path
                 (\ x__ y__ -> x__{_AnalysisMessage'path = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AnalysisMessage "content" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'content
                 (\ x__ y__ -> x__{_AnalysisMessage'content = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AnalysisMessage "level" (MessageSeverity)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'level
                 (\ x__ y__ -> x__{_AnalysisMessage'level = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AnalysisMessage "stackTracePretty"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'stackTracePretty
                 (\ x__ y__ -> x__{_AnalysisMessage'stackTracePretty = y__}))
              Prelude.id
instance Data.Default.Class.Default AnalysisMessage where
        def
          = AnalysisMessage{_AnalysisMessage'computation = Prelude.Nothing,
                            _AnalysisMessage'session = Prelude.Nothing,
                            _AnalysisMessage'relevantId = Prelude.Nothing,
                            _AnalysisMessage'path = Prelude.Nothing,
                            _AnalysisMessage'content = Data.ProtoLens.fieldDefault,
                            _AnalysisMessage'level = Data.Default.Class.def,
                            _AnalysisMessage'stackTracePretty = Data.ProtoLens.fieldDefault,
                            _AnalysisMessage'_unknownFields = ([])}
instance Data.ProtoLens.Message AnalysisMessage where
        messageName _ = Data.Text.pack "karps.core.AnalysisMessage"
        fieldsByTag
          = let computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'computation")))
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'session")))
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                relevantId__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "relevant_id"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.NodeId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'relevantId")))
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'path")))
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                content__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "content"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "content")))
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                level__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "level"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor MessageSeverity)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "level")))
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                stackTracePretty__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "stack_trace_pretty"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "stackTracePretty")))
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, computation__field_descriptor),
                 (Data.ProtoLens.Tag 2, session__field_descriptor),
                 (Data.ProtoLens.Tag 3, relevantId__field_descriptor),
                 (Data.ProtoLens.Tag 4, path__field_descriptor),
                 (Data.ProtoLens.Tag 5, content__field_descriptor),
                 (Data.ProtoLens.Tag 6, level__field_descriptor),
                 (Data.ProtoLens.Tag 7, stackTracePretty__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _AnalysisMessage'_unknownFields
              (\ x__ y__ -> x__{_AnalysisMessage'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.ApiInternal_Fields.phase' @:: Lens' CompilerStep CompilingPhase@
    * 'Proto.Karps.Proto.ApiInternal_Fields.graph' @:: Lens' CompilerStep Proto.Karps.Proto.Graph.Graph@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'graph' @:: Lens' CompilerStep (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.graphDef' @:: Lens' CompilerStep Proto.Tensorflow.Core.Framework.Graph.GraphDef@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'graphDef' @:: Lens' CompilerStep
  (Prelude.Maybe Proto.Tensorflow.Core.Framework.Graph.GraphDef)@
 -}
data CompilerStep = CompilerStep{_CompilerStep'phase ::
                                 !CompilingPhase,
                                 _CompilerStep'graph ::
                                 !(Prelude.Maybe Proto.Karps.Proto.Graph.Graph),
                                 _CompilerStep'graphDef ::
                                 !(Prelude.Maybe Proto.Tensorflow.Core.Framework.Graph.GraphDef),
                                 _CompilerStep'_unknownFields :: !Data.ProtoLens.FieldSet}
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f CompilerStep x a, a ~ b) =>
         Lens.Labels.HasLens f CompilerStep CompilerStep x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilerStep "phase" (CompilingPhase)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilerStep'phase
                 (\ x__ y__ -> x__{_CompilerStep'phase = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilerStep "graph"
           (Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilerStep'graph
                 (\ x__ y__ -> x__{_CompilerStep'graph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilerStep "maybe'graph"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilerStep'graph
                 (\ x__ y__ -> x__{_CompilerStep'graph = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilerStep "graphDef"
           (Proto.Tensorflow.Core.Framework.Graph.GraphDef)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilerStep'graphDef
                 (\ x__ y__ -> x__{_CompilerStep'graphDef = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilerStep "maybe'graphDef"
           (Prelude.Maybe Proto.Tensorflow.Core.Framework.Graph.GraphDef)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilerStep'graphDef
                 (\ x__ y__ -> x__{_CompilerStep'graphDef = y__}))
              Prelude.id
instance Data.Default.Class.Default CompilerStep where
        def
          = CompilerStep{_CompilerStep'phase = Data.Default.Class.def,
                         _CompilerStep'graph = Prelude.Nothing,
                         _CompilerStep'graphDef = Prelude.Nothing,
                         _CompilerStep'_unknownFields = ([])}
instance Data.ProtoLens.Message CompilerStep where
        messageName _ = Data.Text.pack "karps.core.CompilerStep"
        fieldsByTag
          = let phase__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "phase"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor CompilingPhase)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "phase")))
                      :: Data.ProtoLens.FieldDescriptor CompilerStep
                graph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graph")))
                      :: Data.ProtoLens.FieldDescriptor CompilerStep
                graphDef__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph_def"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Tensorflow.Core.Framework.Graph.GraphDef)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graphDef")))
                      :: Data.ProtoLens.FieldDescriptor CompilerStep
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, phase__field_descriptor),
                 (Data.ProtoLens.Tag 2, graph__field_descriptor),
                 (Data.ProtoLens.Tag 3, graphDef__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _CompilerStep'_unknownFields
              (\ x__ y__ -> x__{_CompilerStep'_unknownFields = y__})
data CompilingPhase = INITIAL
                    | REMOVE_UNREACHABLE
                    | DATA_SOURCE_INSERTION
                    | POINTER_SWAP_1
                    | FUNCTIONAL_FLATTENING
                    | AUTOCACHE_FULLFILL
                    | CACHE_CHECK
                    | MERGE_AGGREGATIONS
                    | MERGE_TRANSFORMS
                    | MERGE_AGGREGATIONS_2
                    | REMOVE_OBSERVABLE_BROADCASTS
                    | MERGE_PREAGG_AGGREGATIONS
                    | FINAL
                    | CompilingPhase'Unrecognized !CompilingPhase'UnrecognizedValue
                        deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
newtype CompilingPhase'UnrecognizedValue = CompilingPhase'UnrecognizedValue Data.Int.Int32
                                             deriving (Prelude.Eq, Prelude.Ord, Prelude.Show)
instance Data.ProtoLens.MessageEnum CompilingPhase where
        maybeToEnum 0 = Prelude.Just INITIAL
        maybeToEnum 1 = Prelude.Just REMOVE_UNREACHABLE
        maybeToEnum 2 = Prelude.Just DATA_SOURCE_INSERTION
        maybeToEnum 3 = Prelude.Just POINTER_SWAP_1
        maybeToEnum 4 = Prelude.Just FUNCTIONAL_FLATTENING
        maybeToEnum 5 = Prelude.Just AUTOCACHE_FULLFILL
        maybeToEnum 6 = Prelude.Just CACHE_CHECK
        maybeToEnum 7 = Prelude.Just MERGE_AGGREGATIONS
        maybeToEnum 8 = Prelude.Just MERGE_TRANSFORMS
        maybeToEnum 9 = Prelude.Just MERGE_AGGREGATIONS_2
        maybeToEnum 10 = Prelude.Just REMOVE_OBSERVABLE_BROADCASTS
        maybeToEnum 11 = Prelude.Just MERGE_PREAGG_AGGREGATIONS
        maybeToEnum 1000 = Prelude.Just FINAL
        maybeToEnum k
          = Prelude.Just
              (CompilingPhase'Unrecognized
                 (CompilingPhase'UnrecognizedValue (Prelude.fromIntegral k)))
        showEnum INITIAL = "INITIAL"
        showEnum REMOVE_UNREACHABLE = "REMOVE_UNREACHABLE"
        showEnum REMOVE_OBSERVABLE_BROADCASTS
          = "REMOVE_OBSERVABLE_BROADCASTS"
        showEnum DATA_SOURCE_INSERTION = "DATA_SOURCE_INSERTION"
        showEnum POINTER_SWAP_1 = "POINTER_SWAP_1"
        showEnum MERGE_AGGREGATIONS = "MERGE_AGGREGATIONS"
        showEnum MERGE_PREAGG_AGGREGATIONS = "MERGE_PREAGG_AGGREGATIONS"
        showEnum MERGE_TRANSFORMS = "MERGE_TRANSFORMS"
        showEnum MERGE_AGGREGATIONS_2 = "MERGE_AGGREGATIONS_2"
        showEnum FUNCTIONAL_FLATTENING = "FUNCTIONAL_FLATTENING"
        showEnum AUTOCACHE_FULLFILL = "AUTOCACHE_FULLFILL"
        showEnum CACHE_CHECK = "CACHE_CHECK"
        showEnum FINAL = "FINAL"
        showEnum
          (CompilingPhase'Unrecognized (CompilingPhase'UnrecognizedValue k))
          = Prelude.show k
        readEnum "INITIAL" = Prelude.Just INITIAL
        readEnum "REMOVE_UNREACHABLE" = Prelude.Just REMOVE_UNREACHABLE
        readEnum "REMOVE_OBSERVABLE_BROADCASTS"
          = Prelude.Just REMOVE_OBSERVABLE_BROADCASTS
        readEnum "DATA_SOURCE_INSERTION"
          = Prelude.Just DATA_SOURCE_INSERTION
        readEnum "POINTER_SWAP_1" = Prelude.Just POINTER_SWAP_1
        readEnum "MERGE_AGGREGATIONS" = Prelude.Just MERGE_AGGREGATIONS
        readEnum "MERGE_PREAGG_AGGREGATIONS"
          = Prelude.Just MERGE_PREAGG_AGGREGATIONS
        readEnum "MERGE_TRANSFORMS" = Prelude.Just MERGE_TRANSFORMS
        readEnum "MERGE_AGGREGATIONS_2" = Prelude.Just MERGE_AGGREGATIONS_2
        readEnum "FUNCTIONAL_FLATTENING"
          = Prelude.Just FUNCTIONAL_FLATTENING
        readEnum "AUTOCACHE_FULLFILL" = Prelude.Just AUTOCACHE_FULLFILL
        readEnum "CACHE_CHECK" = Prelude.Just CACHE_CHECK
        readEnum "FINAL" = Prelude.Just FINAL
        readEnum k
          = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded CompilingPhase where
        minBound = INITIAL
        maxBound = FINAL
instance Prelude.Enum CompilingPhase where
        toEnum k__
          = Prelude.maybe
              (Prelude.error
                 ((Prelude.++) "toEnum: unknown value for enum CompilingPhase: "
                    (Prelude.show k__)))
              Prelude.id
              (Data.ProtoLens.maybeToEnum k__)
        fromEnum INITIAL = 0
        fromEnum REMOVE_UNREACHABLE = 1
        fromEnum DATA_SOURCE_INSERTION = 2
        fromEnum POINTER_SWAP_1 = 3
        fromEnum FUNCTIONAL_FLATTENING = 4
        fromEnum AUTOCACHE_FULLFILL = 5
        fromEnum CACHE_CHECK = 6
        fromEnum MERGE_AGGREGATIONS = 7
        fromEnum MERGE_TRANSFORMS = 8
        fromEnum MERGE_AGGREGATIONS_2 = 9
        fromEnum REMOVE_OBSERVABLE_BROADCASTS = 10
        fromEnum MERGE_PREAGG_AGGREGATIONS = 11
        fromEnum FINAL = 1000
        fromEnum
          (CompilingPhase'Unrecognized (CompilingPhase'UnrecognizedValue k))
          = Prelude.fromIntegral k
        succ FINAL
          = Prelude.error
              "CompilingPhase.succ: bad argument FINAL. This value would be out of bounds."
        succ INITIAL = REMOVE_UNREACHABLE
        succ REMOVE_UNREACHABLE = DATA_SOURCE_INSERTION
        succ DATA_SOURCE_INSERTION = POINTER_SWAP_1
        succ POINTER_SWAP_1 = FUNCTIONAL_FLATTENING
        succ FUNCTIONAL_FLATTENING = AUTOCACHE_FULLFILL
        succ AUTOCACHE_FULLFILL = CACHE_CHECK
        succ CACHE_CHECK = MERGE_AGGREGATIONS
        succ MERGE_AGGREGATIONS = MERGE_TRANSFORMS
        succ MERGE_TRANSFORMS = MERGE_AGGREGATIONS_2
        succ MERGE_AGGREGATIONS_2 = REMOVE_OBSERVABLE_BROADCASTS
        succ REMOVE_OBSERVABLE_BROADCASTS = MERGE_PREAGG_AGGREGATIONS
        succ MERGE_PREAGG_AGGREGATIONS = FINAL
        succ _
          = Prelude.error
              "CompilingPhase.succ: bad argument: unrecognized value"
        pred INITIAL
          = Prelude.error
              "CompilingPhase.pred: bad argument INITIAL. This value would be out of bounds."
        pred REMOVE_UNREACHABLE = INITIAL
        pred DATA_SOURCE_INSERTION = REMOVE_UNREACHABLE
        pred POINTER_SWAP_1 = DATA_SOURCE_INSERTION
        pred FUNCTIONAL_FLATTENING = POINTER_SWAP_1
        pred AUTOCACHE_FULLFILL = FUNCTIONAL_FLATTENING
        pred CACHE_CHECK = AUTOCACHE_FULLFILL
        pred MERGE_AGGREGATIONS = CACHE_CHECK
        pred MERGE_TRANSFORMS = MERGE_AGGREGATIONS
        pred MERGE_AGGREGATIONS_2 = MERGE_TRANSFORMS
        pred REMOVE_OBSERVABLE_BROADCASTS = MERGE_AGGREGATIONS_2
        pred MERGE_PREAGG_AGGREGATIONS = REMOVE_OBSERVABLE_BROADCASTS
        pred FINAL = MERGE_PREAGG_AGGREGATIONS
        pred _
          = Prelude.error
              "CompilingPhase.pred: bad argument: unrecognized value"
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.Default.Class.Default CompilingPhase where
        def = INITIAL
instance Data.ProtoLens.FieldDefault CompilingPhase where
        fieldDefault = INITIAL
{- | Fields :

    * 'Proto.Karps.Proto.ApiInternal_Fields.message' @:: Lens' ErrorMessage Data.Text.Text@
    * 'Proto.Karps.Proto.ApiInternal_Fields.hsStack' @:: Lens' ErrorMessage [ErrorMessage'StackElement]@
    * 'Proto.Karps.Proto.ApiInternal_Fields.path' @:: Lens' ErrorMessage [Data.Text.Text]@
 -}
data ErrorMessage = ErrorMessage{_ErrorMessage'message ::
                                 !Data.Text.Text,
                                 _ErrorMessage'hsStack :: ![ErrorMessage'StackElement],
                                 _ErrorMessage'path :: ![Data.Text.Text],
                                 _ErrorMessage'_unknownFields :: !Data.ProtoLens.FieldSet}
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ErrorMessage x a, a ~ b) =>
         Lens.Labels.HasLens f ErrorMessage ErrorMessage x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ErrorMessage "message" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ErrorMessage'message
                 (\ x__ y__ -> x__{_ErrorMessage'message = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ErrorMessage "hsStack"
           ([ErrorMessage'StackElement])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ErrorMessage'hsStack
                 (\ x__ y__ -> x__{_ErrorMessage'hsStack = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ErrorMessage "path" ([Data.Text.Text])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ErrorMessage'path
                 (\ x__ y__ -> x__{_ErrorMessage'path = y__}))
              Prelude.id
instance Data.Default.Class.Default ErrorMessage where
        def
          = ErrorMessage{_ErrorMessage'message = Data.ProtoLens.fieldDefault,
                         _ErrorMessage'hsStack = [], _ErrorMessage'path = [],
                         _ErrorMessage'_unknownFields = ([])}
instance Data.ProtoLens.Message ErrorMessage where
        messageName _ = Data.Text.pack "karps.core.ErrorMessage"
        fieldsByTag
          = let message__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "message"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "message")))
                      :: Data.ProtoLens.FieldDescriptor ErrorMessage
                hsStack__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "hs_stack"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ErrorMessage'StackElement)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "hsStack")))
                      :: Data.ProtoLens.FieldDescriptor ErrorMessage
                path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")))
                      :: Data.ProtoLens.FieldDescriptor ErrorMessage
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, message__field_descriptor),
                 (Data.ProtoLens.Tag 2, hsStack__field_descriptor),
                 (Data.ProtoLens.Tag 3, path__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ErrorMessage'_unknownFields
              (\ x__ y__ -> x__{_ErrorMessage'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.ApiInternal_Fields.function' @:: Lens' ErrorMessage'StackElement Data.Text.Text@
    * 'Proto.Karps.Proto.ApiInternal_Fields.package' @:: Lens' ErrorMessage'StackElement Data.Text.Text@
    * 'Proto.Karps.Proto.ApiInternal_Fields.module'' @:: Lens' ErrorMessage'StackElement Data.Text.Text@
    * 'Proto.Karps.Proto.ApiInternal_Fields.file' @:: Lens' ErrorMessage'StackElement Data.Text.Text@
    * 'Proto.Karps.Proto.ApiInternal_Fields.startLine' @:: Lens' ErrorMessage'StackElement Data.Int.Int32@
    * 'Proto.Karps.Proto.ApiInternal_Fields.startCol' @:: Lens' ErrorMessage'StackElement Data.Int.Int32@
 -}
data ErrorMessage'StackElement = ErrorMessage'StackElement{_ErrorMessage'StackElement'function
                                                           :: !Data.Text.Text,
                                                           _ErrorMessage'StackElement'package ::
                                                           !Data.Text.Text,
                                                           _ErrorMessage'StackElement'module' ::
                                                           !Data.Text.Text,
                                                           _ErrorMessage'StackElement'file ::
                                                           !Data.Text.Text,
                                                           _ErrorMessage'StackElement'startLine ::
                                                           !Data.Int.Int32,
                                                           _ErrorMessage'StackElement'startCol ::
                                                           !Data.Int.Int32,
                                                           _ErrorMessage'StackElement'_unknownFields
                                                           :: !Data.ProtoLens.FieldSet}
                                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ErrorMessage'StackElement x a,
          a ~ b) =>
         Lens.Labels.HasLens f ErrorMessage'StackElement
           ErrorMessage'StackElement
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ErrorMessage'StackElement "function"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ErrorMessage'StackElement'function
                 (\ x__ y__ -> x__{_ErrorMessage'StackElement'function = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ErrorMessage'StackElement "package"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ErrorMessage'StackElement'package
                 (\ x__ y__ -> x__{_ErrorMessage'StackElement'package = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ErrorMessage'StackElement "module'"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ErrorMessage'StackElement'module'
                 (\ x__ y__ -> x__{_ErrorMessage'StackElement'module' = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ErrorMessage'StackElement "file"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ErrorMessage'StackElement'file
                 (\ x__ y__ -> x__{_ErrorMessage'StackElement'file = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ErrorMessage'StackElement "startLine"
           (Data.Int.Int32)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ErrorMessage'StackElement'startLine
                 (\ x__ y__ -> x__{_ErrorMessage'StackElement'startLine = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ErrorMessage'StackElement "startCol"
           (Data.Int.Int32)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ErrorMessage'StackElement'startCol
                 (\ x__ y__ -> x__{_ErrorMessage'StackElement'startCol = y__}))
              Prelude.id
instance Data.Default.Class.Default ErrorMessage'StackElement where
        def
          = ErrorMessage'StackElement{_ErrorMessage'StackElement'function =
                                        Data.ProtoLens.fieldDefault,
                                      _ErrorMessage'StackElement'package =
                                        Data.ProtoLens.fieldDefault,
                                      _ErrorMessage'StackElement'module' =
                                        Data.ProtoLens.fieldDefault,
                                      _ErrorMessage'StackElement'file = Data.ProtoLens.fieldDefault,
                                      _ErrorMessage'StackElement'startLine =
                                        Data.ProtoLens.fieldDefault,
                                      _ErrorMessage'StackElement'startCol =
                                        Data.ProtoLens.fieldDefault,
                                      _ErrorMessage'StackElement'_unknownFields = ([])}
instance Data.ProtoLens.Message ErrorMessage'StackElement where
        messageName _
          = Data.Text.pack "karps.core.ErrorMessage.StackElement"
        fieldsByTag
          = let function__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "function"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "function")))
                      :: Data.ProtoLens.FieldDescriptor ErrorMessage'StackElement
                package__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "package"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "package")))
                      :: Data.ProtoLens.FieldDescriptor ErrorMessage'StackElement
                module'__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "module"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "module'")))
                      :: Data.ProtoLens.FieldDescriptor ErrorMessage'StackElement
                file__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "file"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "file")))
                      :: Data.ProtoLens.FieldDescriptor ErrorMessage'StackElement
                startLine__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "start_line"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "startLine")))
                      :: Data.ProtoLens.FieldDescriptor ErrorMessage'StackElement
                startCol__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "start_col"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "startCol")))
                      :: Data.ProtoLens.FieldDescriptor ErrorMessage'StackElement
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, function__field_descriptor),
                 (Data.ProtoLens.Tag 2, package__field_descriptor),
                 (Data.ProtoLens.Tag 3, module'__field_descriptor),
                 (Data.ProtoLens.Tag 4, file__field_descriptor),
                 (Data.ProtoLens.Tag 5, startLine__field_descriptor),
                 (Data.ProtoLens.Tag 6, startCol__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _ErrorMessage'StackElement'_unknownFields
              (\ x__ y__ -> x__{_ErrorMessage'StackElement'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.ApiInternal_Fields.functionalGraph' @:: Lens' GraphTransformRequest Proto.Karps.Proto.Graph.Graph@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'functionalGraph' @:: Lens' GraphTransformRequest
  (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.requestedPaths' @:: Lens' GraphTransformRequest [Proto.Karps.Proto.Graph.Path]@
 -}
data GraphTransformRequest = GraphTransformRequest{_GraphTransformRequest'functionalGraph
                                                   ::
                                                   !(Prelude.Maybe Proto.Karps.Proto.Graph.Graph),
                                                   _GraphTransformRequest'requestedPaths ::
                                                   ![Proto.Karps.Proto.Graph.Path],
                                                   _GraphTransformRequest'_unknownFields ::
                                                   !Data.ProtoLens.FieldSet}
                               deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f GraphTransformRequest x a,
          a ~ b) =>
         Lens.Labels.HasLens f GraphTransformRequest GraphTransformRequest x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphTransformRequest "functionalGraph"
           (Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformRequest'functionalGraph
                 (\ x__ y__ -> x__{_GraphTransformRequest'functionalGraph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphTransformRequest
           "maybe'functionalGraph"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformRequest'functionalGraph
                 (\ x__ y__ -> x__{_GraphTransformRequest'functionalGraph = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphTransformRequest "requestedPaths"
           ([Proto.Karps.Proto.Graph.Path])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformRequest'requestedPaths
                 (\ x__ y__ -> x__{_GraphTransformRequest'requestedPaths = y__}))
              Prelude.id
instance Data.Default.Class.Default GraphTransformRequest where
        def
          = GraphTransformRequest{_GraphTransformRequest'functionalGraph =
                                    Prelude.Nothing,
                                  _GraphTransformRequest'requestedPaths = [],
                                  _GraphTransformRequest'_unknownFields = ([])}
instance Data.ProtoLens.Message GraphTransformRequest where
        messageName _ = Data.Text.pack "karps.core.GraphTransformRequest"
        fieldsByTag
          = let functionalGraph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "functional_graph"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'functionalGraph")))
                      :: Data.ProtoLens.FieldDescriptor GraphTransformRequest
                requestedPaths__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "requested_paths"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "requestedPaths")))
                      :: Data.ProtoLens.FieldDescriptor GraphTransformRequest
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 3, functionalGraph__field_descriptor),
                 (Data.ProtoLens.Tag 5, requestedPaths__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _GraphTransformRequest'_unknownFields
              (\ x__ y__ -> x__{_GraphTransformRequest'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.ApiInternal_Fields.pinnedGraph' @:: Lens' GraphTransformResponse Proto.Karps.Proto.Graph.Graph@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'pinnedGraph' @:: Lens' GraphTransformResponse
  (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.messages' @:: Lens' GraphTransformResponse [AnalysisMessage]@
    * 'Proto.Karps.Proto.ApiInternal_Fields.steps' @:: Lens' GraphTransformResponse [CompilerStep]@
    * 'Proto.Karps.Proto.ApiInternal_Fields.error' @:: Lens' GraphTransformResponse ErrorMessage@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'error' @:: Lens' GraphTransformResponse (Prelude.Maybe ErrorMessage)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.spark' @:: Lens' GraphTransformResponse Proto.Karps.Proto.Spark.SparkGraph@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'spark' @:: Lens' GraphTransformResponse
  (Prelude.Maybe Proto.Karps.Proto.Spark.SparkGraph)@
 -}
data GraphTransformResponse = GraphTransformResponse{_GraphTransformResponse'pinnedGraph
                                                     ::
                                                     !(Prelude.Maybe Proto.Karps.Proto.Graph.Graph),
                                                     _GraphTransformResponse'messages ::
                                                     ![AnalysisMessage],
                                                     _GraphTransformResponse'steps ::
                                                     ![CompilerStep],
                                                     _GraphTransformResponse'error ::
                                                     !(Prelude.Maybe ErrorMessage),
                                                     _GraphTransformResponse'spark ::
                                                     !(Prelude.Maybe
                                                         Proto.Karps.Proto.Spark.SparkGraph),
                                                     _GraphTransformResponse'_unknownFields ::
                                                     !Data.ProtoLens.FieldSet}
                                deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f GraphTransformResponse x a,
          a ~ b) =>
         Lens.Labels.HasLens f GraphTransformResponse GraphTransformResponse
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphTransformResponse "pinnedGraph"
           (Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'pinnedGraph
                 (\ x__ y__ -> x__{_GraphTransformResponse'pinnedGraph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphTransformResponse "maybe'pinnedGraph"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'pinnedGraph
                 (\ x__ y__ -> x__{_GraphTransformResponse'pinnedGraph = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphTransformResponse "messages"
           ([AnalysisMessage])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'messages
                 (\ x__ y__ -> x__{_GraphTransformResponse'messages = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphTransformResponse "steps"
           ([CompilerStep])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'steps
                 (\ x__ y__ -> x__{_GraphTransformResponse'steps = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphTransformResponse "error"
           (ErrorMessage)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'error
                 (\ x__ y__ -> x__{_GraphTransformResponse'error = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphTransformResponse "maybe'error"
           (Prelude.Maybe ErrorMessage)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'error
                 (\ x__ y__ -> x__{_GraphTransformResponse'error = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphTransformResponse "spark"
           (Proto.Karps.Proto.Spark.SparkGraph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'spark
                 (\ x__ y__ -> x__{_GraphTransformResponse'spark = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphTransformResponse "maybe'spark"
           (Prelude.Maybe Proto.Karps.Proto.Spark.SparkGraph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'spark
                 (\ x__ y__ -> x__{_GraphTransformResponse'spark = y__}))
              Prelude.id
instance Data.Default.Class.Default GraphTransformResponse where
        def
          = GraphTransformResponse{_GraphTransformResponse'pinnedGraph =
                                     Prelude.Nothing,
                                   _GraphTransformResponse'messages = [],
                                   _GraphTransformResponse'steps = [],
                                   _GraphTransformResponse'error = Prelude.Nothing,
                                   _GraphTransformResponse'spark = Prelude.Nothing,
                                   _GraphTransformResponse'_unknownFields = ([])}
instance Data.ProtoLens.Message GraphTransformResponse where
        messageName _ = Data.Text.pack "karps.core.GraphTransformResponse"
        fieldsByTag
          = let pinnedGraph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "pinned_graph"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'pinnedGraph")))
                      :: Data.ProtoLens.FieldDescriptor GraphTransformResponse
                messages__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "messages"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor AnalysisMessage)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "messages")))
                      :: Data.ProtoLens.FieldDescriptor GraphTransformResponse
                steps__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "steps"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor CompilerStep)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "steps")))
                      :: Data.ProtoLens.FieldDescriptor GraphTransformResponse
                error__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "error"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ErrorMessage)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'error")))
                      :: Data.ProtoLens.FieldDescriptor GraphTransformResponse
                spark__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "spark"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Spark.SparkGraph)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'spark")))
                      :: Data.ProtoLens.FieldDescriptor GraphTransformResponse
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, pinnedGraph__field_descriptor),
                 (Data.ProtoLens.Tag 3, messages__field_descriptor),
                 (Data.ProtoLens.Tag 4, steps__field_descriptor),
                 (Data.ProtoLens.Tag 5, error__field_descriptor),
                 (Data.ProtoLens.Tag 6, spark__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _GraphTransformResponse'_unknownFields
              (\ x__ y__ -> x__{_GraphTransformResponse'_unknownFields = y__})
data MessageSeverity = INFO
                     | WARNING
                     | FATAL
                     | MessageSeverity'Unrecognized !MessageSeverity'UnrecognizedValue
                         deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
newtype MessageSeverity'UnrecognizedValue = MessageSeverity'UnrecognizedValue Data.Int.Int32
                                              deriving (Prelude.Eq, Prelude.Ord, Prelude.Show)
instance Data.ProtoLens.MessageEnum MessageSeverity where
        maybeToEnum 0 = Prelude.Just INFO
        maybeToEnum 1 = Prelude.Just WARNING
        maybeToEnum 2 = Prelude.Just FATAL
        maybeToEnum k
          = Prelude.Just
              (MessageSeverity'Unrecognized
                 (MessageSeverity'UnrecognizedValue (Prelude.fromIntegral k)))
        showEnum INFO = "INFO"
        showEnum WARNING = "WARNING"
        showEnum FATAL = "FATAL"
        showEnum
          (MessageSeverity'Unrecognized
             (MessageSeverity'UnrecognizedValue k))
          = Prelude.show k
        readEnum "INFO" = Prelude.Just INFO
        readEnum "WARNING" = Prelude.Just WARNING
        readEnum "FATAL" = Prelude.Just FATAL
        readEnum k
          = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded MessageSeverity where
        minBound = INFO
        maxBound = FATAL
instance Prelude.Enum MessageSeverity where
        toEnum k__
          = Prelude.maybe
              (Prelude.error
                 ((Prelude.++) "toEnum: unknown value for enum MessageSeverity: "
                    (Prelude.show k__)))
              Prelude.id
              (Data.ProtoLens.maybeToEnum k__)
        fromEnum INFO = 0
        fromEnum WARNING = 1
        fromEnum FATAL = 2
        fromEnum
          (MessageSeverity'Unrecognized
             (MessageSeverity'UnrecognizedValue k))
          = Prelude.fromIntegral k
        succ FATAL
          = Prelude.error
              "MessageSeverity.succ: bad argument FATAL. This value would be out of bounds."
        succ INFO = WARNING
        succ WARNING = FATAL
        succ _
          = Prelude.error
              "MessageSeverity.succ: bad argument: unrecognized value"
        pred INFO
          = Prelude.error
              "MessageSeverity.pred: bad argument INFO. This value would be out of bounds."
        pred WARNING = INFO
        pred FATAL = WARNING
        pred _
          = Prelude.error
              "MessageSeverity.pred: bad argument: unrecognized value"
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.Default.Class.Default MessageSeverity where
        def = INFO
instance Data.ProtoLens.FieldDefault MessageSeverity where
        fieldDefault = INFO
{- | Fields :

    * 'Proto.Karps.Proto.ApiInternal_Fields.opName' @:: Lens' NodeBuilderRequest Data.Text.Text@
    * 'Proto.Karps.Proto.ApiInternal_Fields.extra' @:: Lens' NodeBuilderRequest Proto.Karps.Proto.Graph.OpExtra@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'extra' @:: Lens' NodeBuilderRequest
  (Prelude.Maybe Proto.Karps.Proto.Graph.OpExtra)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.parents' @:: Lens' NodeBuilderRequest [Proto.Karps.Proto.Graph.Node]@
    * 'Proto.Karps.Proto.ApiInternal_Fields.requestedScope' @:: Lens' NodeBuilderRequest Proto.Karps.Proto.Graph.Path@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'requestedScope' @:: Lens' NodeBuilderRequest
  (Prelude.Maybe Proto.Karps.Proto.Graph.Path)@
 -}
data NodeBuilderRequest = NodeBuilderRequest{_NodeBuilderRequest'opName
                                             :: !Data.Text.Text,
                                             _NodeBuilderRequest'extra ::
                                             !(Prelude.Maybe Proto.Karps.Proto.Graph.OpExtra),
                                             _NodeBuilderRequest'parents ::
                                             ![Proto.Karps.Proto.Graph.Node],
                                             _NodeBuilderRequest'requestedScope ::
                                             !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                                             _NodeBuilderRequest'_unknownFields ::
                                             !Data.ProtoLens.FieldSet}
                            deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f NodeBuilderRequest x a, a ~ b) =>
         Lens.Labels.HasLens f NodeBuilderRequest NodeBuilderRequest x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeBuilderRequest "opName" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeBuilderRequest'opName
                 (\ x__ y__ -> x__{_NodeBuilderRequest'opName = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeBuilderRequest "extra"
           (Proto.Karps.Proto.Graph.OpExtra)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeBuilderRequest'extra
                 (\ x__ y__ -> x__{_NodeBuilderRequest'extra = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeBuilderRequest "maybe'extra"
           (Prelude.Maybe Proto.Karps.Proto.Graph.OpExtra)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeBuilderRequest'extra
                 (\ x__ y__ -> x__{_NodeBuilderRequest'extra = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeBuilderRequest "parents"
           ([Proto.Karps.Proto.Graph.Node])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeBuilderRequest'parents
                 (\ x__ y__ -> x__{_NodeBuilderRequest'parents = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeBuilderRequest "requestedScope"
           (Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeBuilderRequest'requestedScope
                 (\ x__ y__ -> x__{_NodeBuilderRequest'requestedScope = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeBuilderRequest "maybe'requestedScope"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeBuilderRequest'requestedScope
                 (\ x__ y__ -> x__{_NodeBuilderRequest'requestedScope = y__}))
              Prelude.id
instance Data.Default.Class.Default NodeBuilderRequest where
        def
          = NodeBuilderRequest{_NodeBuilderRequest'opName =
                                 Data.ProtoLens.fieldDefault,
                               _NodeBuilderRequest'extra = Prelude.Nothing,
                               _NodeBuilderRequest'parents = [],
                               _NodeBuilderRequest'requestedScope = Prelude.Nothing,
                               _NodeBuilderRequest'_unknownFields = ([])}
instance Data.ProtoLens.Message NodeBuilderRequest where
        messageName _ = Data.Text.pack "karps.core.NodeBuilderRequest"
        fieldsByTag
          = let opName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "op_name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "opName")))
                      :: Data.ProtoLens.FieldDescriptor NodeBuilderRequest
                extra__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "extra"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.OpExtra)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'extra")))
                      :: Data.ProtoLens.FieldDescriptor NodeBuilderRequest
                parents__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "parents"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Node)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parents")))
                      :: Data.ProtoLens.FieldDescriptor NodeBuilderRequest
                requestedScope__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "requested_scope"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'requestedScope")))
                      :: Data.ProtoLens.FieldDescriptor NodeBuilderRequest
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, opName__field_descriptor),
                 (Data.ProtoLens.Tag 2, extra__field_descriptor),
                 (Data.ProtoLens.Tag 3, parents__field_descriptor),
                 (Data.ProtoLens.Tag 4, requestedScope__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _NodeBuilderRequest'_unknownFields
              (\ x__ y__ -> x__{_NodeBuilderRequest'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.ApiInternal_Fields.error' @:: Lens' NodeBuilderResponse ErrorMessage@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'error' @:: Lens' NodeBuilderResponse (Prelude.Maybe ErrorMessage)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.success' @:: Lens' NodeBuilderResponse Proto.Karps.Proto.Graph.Node@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'success' @:: Lens' NodeBuilderResponse
  (Prelude.Maybe Proto.Karps.Proto.Graph.Node)@
 -}
data NodeBuilderResponse = NodeBuilderResponse{_NodeBuilderResponse'error
                                               :: !(Prelude.Maybe ErrorMessage),
                                               _NodeBuilderResponse'success ::
                                               !(Prelude.Maybe Proto.Karps.Proto.Graph.Node),
                                               _NodeBuilderResponse'_unknownFields ::
                                               !Data.ProtoLens.FieldSet}
                             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f NodeBuilderResponse x a, a ~ b) =>
         Lens.Labels.HasLens f NodeBuilderResponse NodeBuilderResponse x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeBuilderResponse "error" (ErrorMessage)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeBuilderResponse'error
                 (\ x__ y__ -> x__{_NodeBuilderResponse'error = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeBuilderResponse "maybe'error"
           (Prelude.Maybe ErrorMessage)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeBuilderResponse'error
                 (\ x__ y__ -> x__{_NodeBuilderResponse'error = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeBuilderResponse "success"
           (Proto.Karps.Proto.Graph.Node)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeBuilderResponse'success
                 (\ x__ y__ -> x__{_NodeBuilderResponse'success = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeBuilderResponse "maybe'success"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Node)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeBuilderResponse'success
                 (\ x__ y__ -> x__{_NodeBuilderResponse'success = y__}))
              Prelude.id
instance Data.Default.Class.Default NodeBuilderResponse where
        def
          = NodeBuilderResponse{_NodeBuilderResponse'error = Prelude.Nothing,
                                _NodeBuilderResponse'success = Prelude.Nothing,
                                _NodeBuilderResponse'_unknownFields = ([])}
instance Data.ProtoLens.Message NodeBuilderResponse where
        messageName _ = Data.Text.pack "karps.core.NodeBuilderResponse"
        fieldsByTag
          = let error__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "error"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ErrorMessage)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'error")))
                      :: Data.ProtoLens.FieldDescriptor NodeBuilderResponse
                success__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "success"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Node)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'success")))
                      :: Data.ProtoLens.FieldDescriptor NodeBuilderResponse
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, error__field_descriptor),
                 (Data.ProtoLens.Tag 2, success__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _NodeBuilderResponse'_unknownFields
              (\ x__ y__ -> x__{_NodeBuilderResponse'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.ApiInternal_Fields.node' @:: Lens' NodeMapItem Proto.Karps.Proto.Graph.NodeId@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'node' @:: Lens' NodeMapItem (Prelude.Maybe Proto.Karps.Proto.Graph.NodeId)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.path' @:: Lens' NodeMapItem Proto.Karps.Proto.Graph.Path@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'path' @:: Lens' NodeMapItem (Prelude.Maybe Proto.Karps.Proto.Graph.Path)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.computation' @:: Lens' NodeMapItem Proto.Karps.Proto.Computation.ComputationId@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'computation' @:: Lens' NodeMapItem
  (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)@
    * 'Proto.Karps.Proto.ApiInternal_Fields.session' @:: Lens' NodeMapItem Proto.Karps.Proto.Computation.SessionId@
    * 'Proto.Karps.Proto.ApiInternal_Fields.maybe'session' @:: Lens' NodeMapItem
  (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)@
 -}
data NodeMapItem = NodeMapItem{_NodeMapItem'node ::
                               !(Prelude.Maybe Proto.Karps.Proto.Graph.NodeId),
                               _NodeMapItem'path :: !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                               _NodeMapItem'computation ::
                               !(Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId),
                               _NodeMapItem'session ::
                               !(Prelude.Maybe Proto.Karps.Proto.Computation.SessionId),
                               _NodeMapItem'_unknownFields :: !Data.ProtoLens.FieldSet}
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f NodeMapItem x a, a ~ b) =>
         Lens.Labels.HasLens f NodeMapItem NodeMapItem x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeMapItem "node"
           (Proto.Karps.Proto.Graph.NodeId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'node
                 (\ x__ y__ -> x__{_NodeMapItem'node = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeMapItem "maybe'node"
           (Prelude.Maybe Proto.Karps.Proto.Graph.NodeId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'node
                 (\ x__ y__ -> x__{_NodeMapItem'node = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeMapItem "path"
           (Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'path
                 (\ x__ y__ -> x__{_NodeMapItem'path = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeMapItem "maybe'path"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'path
                 (\ x__ y__ -> x__{_NodeMapItem'path = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeMapItem "computation"
           (Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'computation
                 (\ x__ y__ -> x__{_NodeMapItem'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeMapItem "maybe'computation"
           (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'computation
                 (\ x__ y__ -> x__{_NodeMapItem'computation = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeMapItem "session"
           (Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'session
                 (\ x__ y__ -> x__{_NodeMapItem'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeMapItem "maybe'session"
           (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'session
                 (\ x__ y__ -> x__{_NodeMapItem'session = y__}))
              Prelude.id
instance Data.Default.Class.Default NodeMapItem where
        def
          = NodeMapItem{_NodeMapItem'node = Prelude.Nothing,
                        _NodeMapItem'path = Prelude.Nothing,
                        _NodeMapItem'computation = Prelude.Nothing,
                        _NodeMapItem'session = Prelude.Nothing,
                        _NodeMapItem'_unknownFields = ([])}
instance Data.ProtoLens.Message NodeMapItem where
        messageName _ = Data.Text.pack "karps.core.NodeMapItem"
        fieldsByTag
          = let node__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "node"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.NodeId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'node")))
                      :: Data.ProtoLens.FieldDescriptor NodeMapItem
                path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'path")))
                      :: Data.ProtoLens.FieldDescriptor NodeMapItem
                computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'computation")))
                      :: Data.ProtoLens.FieldDescriptor NodeMapItem
                session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'session")))
                      :: Data.ProtoLens.FieldDescriptor NodeMapItem
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, node__field_descriptor),
                 (Data.ProtoLens.Tag 2, path__field_descriptor),
                 (Data.ProtoLens.Tag 3, computation__field_descriptor),
                 (Data.ProtoLens.Tag 4, session__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _NodeMapItem'_unknownFields
              (\ x__ y__ -> x__{_NodeMapItem'_unknownFields = y__})