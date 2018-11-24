{- This file was auto-generated from karps/proto/api_internal.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Karps.Proto.ApiInternal where
import qualified Data.ProtoLens.Reexport.Prelude as Prelude
import qualified Data.ProtoLens.Reexport.Data.Int as Data.Int
import qualified Data.ProtoLens.Reexport.Data.Word as Data.Word
import qualified Data.ProtoLens.Reexport.Data.ProtoLens
       as Data.ProtoLens
import qualified
       Data.ProtoLens.Reexport.Data.ProtoLens.Message.Enum
       as Data.ProtoLens.Message.Enum
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
import qualified Data.ProtoLens.Reexport.Lens.Labels as Lens.Labels
import qualified Proto.Karps.Proto.Computation
import qualified Proto.Karps.Proto.Graph
import qualified Proto.Karps.Proto.Interface
import qualified Proto.Karps.Proto.Io
import qualified Proto.Tensorflow.Core.Framework.Graph

data AnalysisMessage = AnalysisMessage{_AnalysisMessage'computation
                                       ::
                                       !(Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId),
                                       _AnalysisMessage'session ::
                                       !(Prelude.Maybe Proto.Karps.Proto.Computation.SessionId),
                                       _AnalysisMessage'relevantId :: !(Prelude.Maybe NodeId),
                                       _AnalysisMessage'path ::
                                       !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                                       _AnalysisMessage'content :: !Data.Text.Text,
                                       _AnalysisMessage'level :: !MessageSeverity,
                                       _AnalysisMessage'stackTracePretty :: !Data.Text.Text}
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Computation.ComputationId,
          b ~ Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "computation" f AnalysisMessage AnalysisMessage
         a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'computation
                 (\ x__ y__ -> x__{_AnalysisMessage'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'computation" f AnalysisMessage
         AnalysisMessage a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'computation
                 (\ x__ y__ -> x__{_AnalysisMessage'computation = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Computation.SessionId,
          b ~ Proto.Karps.Proto.Computation.SessionId, Prelude.Functor f) =>
         Lens.Labels.HasLens "session" f AnalysisMessage AnalysisMessage a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'session
                 (\ x__ y__ -> x__{_AnalysisMessage'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'session" f AnalysisMessage
         AnalysisMessage a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'session
                 (\ x__ y__ -> x__{_AnalysisMessage'session = y__}))
              Prelude.id

instance (a ~ NodeId, b ~ NodeId, Prelude.Functor f) =>
         Lens.Labels.HasLens "relevantId" f AnalysisMessage AnalysisMessage
         a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'relevantId
                 (\ x__ y__ -> x__{_AnalysisMessage'relevantId = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe NodeId, b ~ Prelude.Maybe NodeId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'relevantId" f AnalysisMessage
         AnalysisMessage a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'relevantId
                 (\ x__ y__ -> x__{_AnalysisMessage'relevantId = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Graph.Path,
          b ~ Proto.Karps.Proto.Graph.Path, Prelude.Functor f) =>
         Lens.Labels.HasLens "path" f AnalysisMessage AnalysisMessage a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'path
                 (\ x__ y__ -> x__{_AnalysisMessage'path = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'path" f AnalysisMessage AnalysisMessage
         a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'path
                 (\ x__ y__ -> x__{_AnalysisMessage'path = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "content" f AnalysisMessage AnalysisMessage a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'content
                 (\ x__ y__ -> x__{_AnalysisMessage'content = y__}))
              Prelude.id

instance (a ~ MessageSeverity, b ~ MessageSeverity,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "level" f AnalysisMessage AnalysisMessage a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalysisMessage'level
                 (\ x__ y__ -> x__{_AnalysisMessage'level = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "stackTracePretty" f AnalysisMessage
         AnalysisMessage a b where
        lensOf _
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
                            _AnalysisMessage'stackTracePretty = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message AnalysisMessage where
        descriptor
          = let computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField maybe'computation)
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField maybe'session)
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                relevantId__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "relevant_id"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor NodeId)
                      (Data.ProtoLens.OptionalField maybe'relevantId)
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField maybe'path)
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                content__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "content"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional content)
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                level__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "level"
                      (Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor MessageSeverity)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional level)
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
                stackTracePretty__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "stack_trace_pretty"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         stackTracePretty)
                      :: Data.ProtoLens.FieldDescriptor AnalysisMessage
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.AnalysisMessage")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, computation__field_descriptor),
                    (Data.ProtoLens.Tag 2, session__field_descriptor),
                    (Data.ProtoLens.Tag 3, relevantId__field_descriptor),
                    (Data.ProtoLens.Tag 4, path__field_descriptor),
                    (Data.ProtoLens.Tag 5, content__field_descriptor),
                    (Data.ProtoLens.Tag 6, level__field_descriptor),
                    (Data.ProtoLens.Tag 7, stackTracePretty__field_descriptor)])
                (Data.Map.fromList
                   [("computation", computation__field_descriptor),
                    ("session", session__field_descriptor),
                    ("relevant_id", relevantId__field_descriptor),
                    ("path", path__field_descriptor),
                    ("content", content__field_descriptor),
                    ("level", level__field_descriptor),
                    ("stack_trace_pretty", stackTracePretty__field_descriptor)])

data AnalyzeResourceResponse = AnalyzeResourceResponse{_AnalyzeResourceResponse'successes
                                                       :: ![ResourceStatus],
                                                       _AnalyzeResourceResponse'failures ::
                                                       ![AnalyzeResourceResponse'FailedStatus]}
                             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [ResourceStatus], b ~ [ResourceStatus],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "successes" f AnalyzeResourceResponse
         AnalyzeResourceResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalyzeResourceResponse'successes
                 (\ x__ y__ -> x__{_AnalyzeResourceResponse'successes = y__}))
              Prelude.id

instance (a ~ [AnalyzeResourceResponse'FailedStatus],
          b ~ [AnalyzeResourceResponse'FailedStatus], Prelude.Functor f) =>
         Lens.Labels.HasLens "failures" f AnalyzeResourceResponse
         AnalyzeResourceResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalyzeResourceResponse'failures
                 (\ x__ y__ -> x__{_AnalyzeResourceResponse'failures = y__}))
              Prelude.id

instance Data.Default.Class.Default AnalyzeResourceResponse where
        def
          = AnalyzeResourceResponse{_AnalyzeResourceResponse'successes = [],
                                    _AnalyzeResourceResponse'failures = []}

instance Data.ProtoLens.Message AnalyzeResourceResponse where
        descriptor
          = let successes__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "successes"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResourceStatus)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked successes)
                      :: Data.ProtoLens.FieldDescriptor AnalyzeResourceResponse
                failures__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "failures"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           AnalyzeResourceResponse'FailedStatus)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked failures)
                      :: Data.ProtoLens.FieldDescriptor AnalyzeResourceResponse
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.AnalyzeResourceResponse")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, successes__field_descriptor),
                    (Data.ProtoLens.Tag 2, failures__field_descriptor)])
                (Data.Map.fromList
                   [("successes", successes__field_descriptor),
                    ("failures", failures__field_descriptor)])

data AnalyzeResourceResponse'FailedStatus = AnalyzeResourceResponse'FailedStatus{_AnalyzeResourceResponse'FailedStatus'resource
                                                                                 ::
                                                                                 !(Prelude.Maybe
                                                                                     Proto.Karps.Proto.Io.ResourcePath),
                                                                                 _AnalyzeResourceResponse'FailedStatus'error
                                                                                 :: !Data.Text.Text}
                                          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Io.ResourcePath,
          b ~ Proto.Karps.Proto.Io.ResourcePath, Prelude.Functor f) =>
         Lens.Labels.HasLens "resource" f
         AnalyzeResourceResponse'FailedStatus
         AnalyzeResourceResponse'FailedStatus a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _AnalyzeResourceResponse'FailedStatus'resource
                 (\ x__ y__ ->
                    x__{_AnalyzeResourceResponse'FailedStatus'resource = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Io.ResourcePath,
          b ~ Prelude.Maybe Proto.Karps.Proto.Io.ResourcePath,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'resource" f
         AnalyzeResourceResponse'FailedStatus
         AnalyzeResourceResponse'FailedStatus a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _AnalyzeResourceResponse'FailedStatus'resource
                 (\ x__ y__ ->
                    x__{_AnalyzeResourceResponse'FailedStatus'resource = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "error" f AnalyzeResourceResponse'FailedStatus
         AnalyzeResourceResponse'FailedStatus a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _AnalyzeResourceResponse'FailedStatus'error
                 (\ x__ y__ ->
                    x__{_AnalyzeResourceResponse'FailedStatus'error = y__}))
              Prelude.id

instance Data.Default.Class.Default
         AnalyzeResourceResponse'FailedStatus where
        def
          = AnalyzeResourceResponse'FailedStatus{_AnalyzeResourceResponse'FailedStatus'resource
                                                   = Prelude.Nothing,
                                                 _AnalyzeResourceResponse'FailedStatus'error =
                                                   Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message
         AnalyzeResourceResponse'FailedStatus where
        descriptor
          = let resource__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "resource"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Io.ResourcePath)
                      (Data.ProtoLens.OptionalField maybe'resource)
                      ::
                      Data.ProtoLens.FieldDescriptor AnalyzeResourceResponse'FailedStatus
                error__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "error"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional error)
                      ::
                      Data.ProtoLens.FieldDescriptor AnalyzeResourceResponse'FailedStatus
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.AnalyzeResourceResponse.FailedStatus")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, resource__field_descriptor),
                    (Data.ProtoLens.Tag 2, error__field_descriptor)])
                (Data.Map.fromList
                   [("resource", resource__field_descriptor),
                    ("error", error__field_descriptor)])

data AnalyzeResourcesRequest = AnalyzeResourcesRequest{_AnalyzeResourcesRequest'resources
                                                       :: ![Proto.Karps.Proto.Io.ResourcePath],
                                                       _AnalyzeResourcesRequest'session ::
                                                       !(Prelude.Maybe
                                                           Proto.Karps.Proto.Computation.SessionId)}
                             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [Proto.Karps.Proto.Io.ResourcePath],
          b ~ [Proto.Karps.Proto.Io.ResourcePath], Prelude.Functor f) =>
         Lens.Labels.HasLens "resources" f AnalyzeResourcesRequest
         AnalyzeResourcesRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalyzeResourcesRequest'resources
                 (\ x__ y__ -> x__{_AnalyzeResourcesRequest'resources = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Computation.SessionId,
          b ~ Proto.Karps.Proto.Computation.SessionId, Prelude.Functor f) =>
         Lens.Labels.HasLens "session" f AnalyzeResourcesRequest
         AnalyzeResourcesRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalyzeResourcesRequest'session
                 (\ x__ y__ -> x__{_AnalyzeResourcesRequest'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'session" f AnalyzeResourcesRequest
         AnalyzeResourcesRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AnalyzeResourcesRequest'session
                 (\ x__ y__ -> x__{_AnalyzeResourcesRequest'session = y__}))
              Prelude.id

instance Data.Default.Class.Default AnalyzeResourcesRequest where
        def
          = AnalyzeResourcesRequest{_AnalyzeResourcesRequest'resources = [],
                                    _AnalyzeResourcesRequest'session = Prelude.Nothing}

instance Data.ProtoLens.Message AnalyzeResourcesRequest where
        descriptor
          = let resources__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "resources"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Io.ResourcePath)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked resources)
                      :: Data.ProtoLens.FieldDescriptor AnalyzeResourcesRequest
                session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField maybe'session)
                      :: Data.ProtoLens.FieldDescriptor AnalyzeResourcesRequest
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.AnalyzeResourcesRequest")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, resources__field_descriptor),
                    (Data.ProtoLens.Tag 2, session__field_descriptor)])
                (Data.Map.fromList
                   [("resources", resources__field_descriptor),
                    ("session", session__field_descriptor)])

data CompilerStep = CompilerStep{_CompilerStep'phase ::
                                 !CompilingPhase,
                                 _CompilerStep'graph ::
                                 !(Prelude.Maybe Proto.Karps.Proto.Graph.Graph),
                                 _CompilerStep'graphDef ::
                                 !(Prelude.Maybe Proto.Tensorflow.Core.Framework.Graph.GraphDef)}
                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ CompilingPhase, b ~ CompilingPhase,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "phase" f CompilerStep CompilerStep a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilerStep'phase
                 (\ x__ y__ -> x__{_CompilerStep'phase = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Graph.Graph,
          b ~ Proto.Karps.Proto.Graph.Graph, Prelude.Functor f) =>
         Lens.Labels.HasLens "graph" f CompilerStep CompilerStep a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilerStep'graph
                 (\ x__ y__ -> x__{_CompilerStep'graph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'graph" f CompilerStep CompilerStep a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilerStep'graph
                 (\ x__ y__ -> x__{_CompilerStep'graph = y__}))
              Prelude.id

instance (a ~ Proto.Tensorflow.Core.Framework.Graph.GraphDef,
          b ~ Proto.Tensorflow.Core.Framework.Graph.GraphDef,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "graphDef" f CompilerStep CompilerStep a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilerStep'graphDef
                 (\ x__ y__ -> x__{_CompilerStep'graphDef = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Tensorflow.Core.Framework.Graph.GraphDef,
          b ~ Prelude.Maybe Proto.Tensorflow.Core.Framework.Graph.GraphDef,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'graphDef" f CompilerStep CompilerStep a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilerStep'graphDef
                 (\ x__ y__ -> x__{_CompilerStep'graphDef = y__}))
              Prelude.id

instance Data.Default.Class.Default CompilerStep where
        def
          = CompilerStep{_CompilerStep'phase = Data.Default.Class.def,
                         _CompilerStep'graph = Prelude.Nothing,
                         _CompilerStep'graphDef = Prelude.Nothing}

instance Data.ProtoLens.Message CompilerStep where
        descriptor
          = let phase__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "phase"
                      (Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor CompilingPhase)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional phase)
                      :: Data.ProtoLens.FieldDescriptor CompilerStep
                graph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField maybe'graph)
                      :: Data.ProtoLens.FieldDescriptor CompilerStep
                graphDef__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph_def"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Tensorflow.Core.Framework.Graph.GraphDef)
                      (Data.ProtoLens.OptionalField maybe'graphDef)
                      :: Data.ProtoLens.FieldDescriptor CompilerStep
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.CompilerStep")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, phase__field_descriptor),
                    (Data.ProtoLens.Tag 2, graph__field_descriptor),
                    (Data.ProtoLens.Tag 3, graphDef__field_descriptor)])
                (Data.Map.fromList
                   [("phase", phase__field_descriptor),
                    ("graph", graph__field_descriptor),
                    ("graph_def", graphDef__field_descriptor)])

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
                    deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance Data.Default.Class.Default CompilingPhase where
        def = INITIAL

instance Data.ProtoLens.FieldDefault CompilingPhase where
        fieldDefault = INITIAL

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
        maybeToEnum _ = Prelude.Nothing
        showEnum INITIAL = "INITIAL"
        showEnum REMOVE_UNREACHABLE = "REMOVE_UNREACHABLE"
        showEnum DATA_SOURCE_INSERTION = "DATA_SOURCE_INSERTION"
        showEnum POINTER_SWAP_1 = "POINTER_SWAP_1"
        showEnum FUNCTIONAL_FLATTENING = "FUNCTIONAL_FLATTENING"
        showEnum AUTOCACHE_FULLFILL = "AUTOCACHE_FULLFILL"
        showEnum CACHE_CHECK = "CACHE_CHECK"
        showEnum MERGE_AGGREGATIONS = "MERGE_AGGREGATIONS"
        showEnum MERGE_TRANSFORMS = "MERGE_TRANSFORMS"
        showEnum MERGE_AGGREGATIONS_2 = "MERGE_AGGREGATIONS_2"
        showEnum REMOVE_OBSERVABLE_BROADCASTS
          = "REMOVE_OBSERVABLE_BROADCASTS"
        showEnum MERGE_PREAGG_AGGREGATIONS = "MERGE_PREAGG_AGGREGATIONS"
        showEnum FINAL = "FINAL"
        readEnum "INITIAL" = Prelude.Just INITIAL
        readEnum "REMOVE_UNREACHABLE" = Prelude.Just REMOVE_UNREACHABLE
        readEnum "DATA_SOURCE_INSERTION"
          = Prelude.Just DATA_SOURCE_INSERTION
        readEnum "POINTER_SWAP_1" = Prelude.Just POINTER_SWAP_1
        readEnum "FUNCTIONAL_FLATTENING"
          = Prelude.Just FUNCTIONAL_FLATTENING
        readEnum "AUTOCACHE_FULLFILL" = Prelude.Just AUTOCACHE_FULLFILL
        readEnum "CACHE_CHECK" = Prelude.Just CACHE_CHECK
        readEnum "MERGE_AGGREGATIONS" = Prelude.Just MERGE_AGGREGATIONS
        readEnum "MERGE_TRANSFORMS" = Prelude.Just MERGE_TRANSFORMS
        readEnum "MERGE_AGGREGATIONS_2" = Prelude.Just MERGE_AGGREGATIONS_2
        readEnum "REMOVE_OBSERVABLE_BROADCASTS"
          = Prelude.Just REMOVE_OBSERVABLE_BROADCASTS
        readEnum "MERGE_PREAGG_AGGREGATIONS"
          = Prelude.Just MERGE_PREAGG_AGGREGATIONS
        readEnum "FINAL" = Prelude.Just FINAL
        readEnum _ = Prelude.Nothing

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
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo

instance Prelude.Bounded CompilingPhase where
        minBound = INITIAL
        maxBound = FINAL

data GraphTransformResponse = GraphTransformResponse{_GraphTransformResponse'pinnedGraph
                                                     ::
                                                     !(Prelude.Maybe Proto.Karps.Proto.Graph.Graph),
                                                     _GraphTransformResponse'nodeMap ::
                                                     ![NodeMapItem],
                                                     _GraphTransformResponse'messages ::
                                                     ![AnalysisMessage],
                                                     _GraphTransformResponse'steps ::
                                                     ![CompilerStep]}
                            deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Graph.Graph,
          b ~ Proto.Karps.Proto.Graph.Graph, Prelude.Functor f) =>
         Lens.Labels.HasLens "pinnedGraph" f GraphTransformResponse
         GraphTransformResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'pinnedGraph
                 (\ x__ y__ -> x__{_GraphTransformResponse'pinnedGraph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'pinnedGraph" f GraphTransformResponse
         GraphTransformResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'pinnedGraph
                 (\ x__ y__ -> x__{_GraphTransformResponse'pinnedGraph = y__}))
              Prelude.id

instance (a ~ [NodeMapItem], b ~ [NodeMapItem],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "nodeMap" f GraphTransformResponse
         GraphTransformResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'nodeMap
                 (\ x__ y__ -> x__{_GraphTransformResponse'nodeMap = y__}))
              Prelude.id

instance (a ~ [AnalysisMessage], b ~ [AnalysisMessage],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "messages" f GraphTransformResponse
         GraphTransformResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'messages
                 (\ x__ y__ -> x__{_GraphTransformResponse'messages = y__}))
              Prelude.id

instance (a ~ [CompilerStep], b ~ [CompilerStep],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "steps" f GraphTransformResponse
         GraphTransformResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphTransformResponse'steps
                 (\ x__ y__ -> x__{_GraphTransformResponse'steps = y__}))
              Prelude.id

instance Data.Default.Class.Default GraphTransformResponse where
        def
          = GraphTransformResponse{_GraphTransformResponse'pinnedGraph =
                                     Prelude.Nothing,
                                   _GraphTransformResponse'nodeMap = [],
                                   _GraphTransformResponse'messages = [],
                                   _GraphTransformResponse'steps = []}

instance Data.ProtoLens.Message GraphTransformResponse where
        descriptor
          = let pinnedGraph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "pinned_graph"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField maybe'pinnedGraph)
                      :: Data.ProtoLens.FieldDescriptor GraphTransformResponse
                nodeMap__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "node_map"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor NodeMapItem)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked nodeMap)
                      :: Data.ProtoLens.FieldDescriptor GraphTransformResponse
                messages__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "messages"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor AnalysisMessage)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked messages)
                      :: Data.ProtoLens.FieldDescriptor GraphTransformResponse
                steps__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "steps"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor CompilerStep)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked steps)
                      :: Data.ProtoLens.FieldDescriptor GraphTransformResponse
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.GraphTransformResponse")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, pinnedGraph__field_descriptor),
                    (Data.ProtoLens.Tag 2, nodeMap__field_descriptor),
                    (Data.ProtoLens.Tag 3, messages__field_descriptor),
                    (Data.ProtoLens.Tag 4, steps__field_descriptor)])
                (Data.Map.fromList
                   [("pinned_graph", pinnedGraph__field_descriptor),
                    ("node_map", nodeMap__field_descriptor),
                    ("messages", messages__field_descriptor),
                    ("steps", steps__field_descriptor)])

data MessageSeverity = INFO
                     | WARNING
                     | FATAL
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance Data.Default.Class.Default MessageSeverity where
        def = INFO

instance Data.ProtoLens.FieldDefault MessageSeverity where
        fieldDefault = INFO

instance Data.ProtoLens.MessageEnum MessageSeverity where
        maybeToEnum 0 = Prelude.Just INFO
        maybeToEnum 1 = Prelude.Just WARNING
        maybeToEnum 2 = Prelude.Just FATAL
        maybeToEnum _ = Prelude.Nothing
        showEnum INFO = "INFO"
        showEnum WARNING = "WARNING"
        showEnum FATAL = "FATAL"
        readEnum "INFO" = Prelude.Just INFO
        readEnum "WARNING" = Prelude.Just WARNING
        readEnum "FATAL" = Prelude.Just FATAL
        readEnum _ = Prelude.Nothing

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
        succ FATAL
          = Prelude.error
              "MessageSeverity.succ: bad argument FATAL. This value would be out of bounds."
        succ INFO = WARNING
        succ WARNING = FATAL
        pred INFO
          = Prelude.error
              "MessageSeverity.pred: bad argument INFO. This value would be out of bounds."
        pred WARNING = INFO
        pred FATAL = WARNING
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo

instance Prelude.Bounded MessageSeverity where
        minBound = INFO
        maxBound = FATAL

data NodeId = NodeId{_NodeId'value :: !Data.Text.Text}
            deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "value" f NodeId NodeId a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeId'value
                 (\ x__ y__ -> x__{_NodeId'value = y__}))
              Prelude.id

instance Data.Default.Class.Default NodeId where
        def = NodeId{_NodeId'value = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message NodeId where
        descriptor
          = let value__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "value"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional value)
                      :: Data.ProtoLens.FieldDescriptor NodeId
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.NodeId")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, value__field_descriptor)])
                (Data.Map.fromList [("value", value__field_descriptor)])

data NodeMapItem = NodeMapItem{_NodeMapItem'node ::
                               !(Prelude.Maybe NodeId),
                               _NodeMapItem'path :: !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                               _NodeMapItem'computation ::
                               !(Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId),
                               _NodeMapItem'session ::
                               !(Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)}
                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ NodeId, b ~ NodeId, Prelude.Functor f) =>
         Lens.Labels.HasLens "node" f NodeMapItem NodeMapItem a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'node
                 (\ x__ y__ -> x__{_NodeMapItem'node = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe NodeId, b ~ Prelude.Maybe NodeId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'node" f NodeMapItem NodeMapItem a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'node
                 (\ x__ y__ -> x__{_NodeMapItem'node = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Graph.Path,
          b ~ Proto.Karps.Proto.Graph.Path, Prelude.Functor f) =>
         Lens.Labels.HasLens "path" f NodeMapItem NodeMapItem a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'path
                 (\ x__ y__ -> x__{_NodeMapItem'path = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'path" f NodeMapItem NodeMapItem a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'path
                 (\ x__ y__ -> x__{_NodeMapItem'path = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Computation.ComputationId,
          b ~ Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "computation" f NodeMapItem NodeMapItem a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'computation
                 (\ x__ y__ -> x__{_NodeMapItem'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'computation" f NodeMapItem NodeMapItem a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'computation
                 (\ x__ y__ -> x__{_NodeMapItem'computation = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Computation.SessionId,
          b ~ Proto.Karps.Proto.Computation.SessionId, Prelude.Functor f) =>
         Lens.Labels.HasLens "session" f NodeMapItem NodeMapItem a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'session
                 (\ x__ y__ -> x__{_NodeMapItem'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'session" f NodeMapItem NodeMapItem a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeMapItem'session
                 (\ x__ y__ -> x__{_NodeMapItem'session = y__}))
              Prelude.id

instance Data.Default.Class.Default NodeMapItem where
        def
          = NodeMapItem{_NodeMapItem'node = Prelude.Nothing,
                        _NodeMapItem'path = Prelude.Nothing,
                        _NodeMapItem'computation = Prelude.Nothing,
                        _NodeMapItem'session = Prelude.Nothing}

instance Data.ProtoLens.Message NodeMapItem where
        descriptor
          = let node__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "node"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor NodeId)
                      (Data.ProtoLens.OptionalField maybe'node)
                      :: Data.ProtoLens.FieldDescriptor NodeMapItem
                path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField maybe'path)
                      :: Data.ProtoLens.FieldDescriptor NodeMapItem
                computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField maybe'computation)
                      :: Data.ProtoLens.FieldDescriptor NodeMapItem
                session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField maybe'session)
                      :: Data.ProtoLens.FieldDescriptor NodeMapItem
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.NodeMapItem")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, node__field_descriptor),
                    (Data.ProtoLens.Tag 2, path__field_descriptor),
                    (Data.ProtoLens.Tag 3, computation__field_descriptor),
                    (Data.ProtoLens.Tag 4, session__field_descriptor)])
                (Data.Map.fromList
                   [("node", node__field_descriptor),
                    ("path", path__field_descriptor),
                    ("computation", computation__field_descriptor),
                    ("session", session__field_descriptor)])

data PerformGraphTransform = PerformGraphTransform{_PerformGraphTransform'session
                                                   ::
                                                   !(Prelude.Maybe
                                                       Proto.Karps.Proto.Computation.SessionId),
                                                   _PerformGraphTransform'computation ::
                                                   !(Prelude.Maybe
                                                       Proto.Karps.Proto.Computation.ComputationId),
                                                   _PerformGraphTransform'functionalGraph ::
                                                   !(Prelude.Maybe Proto.Karps.Proto.Graph.Graph),
                                                   _PerformGraphTransform'availableNodes ::
                                                   ![NodeMapItem],
                                                   _PerformGraphTransform'requestedPaths ::
                                                   ![Proto.Karps.Proto.Graph.Path],
                                                   _PerformGraphTransform'knownResources ::
                                                   ![ResourceStatus]}
                           deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Computation.SessionId,
          b ~ Proto.Karps.Proto.Computation.SessionId, Prelude.Functor f) =>
         Lens.Labels.HasLens "session" f PerformGraphTransform
         PerformGraphTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PerformGraphTransform'session
                 (\ x__ y__ -> x__{_PerformGraphTransform'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'session" f PerformGraphTransform
         PerformGraphTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PerformGraphTransform'session
                 (\ x__ y__ -> x__{_PerformGraphTransform'session = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Computation.ComputationId,
          b ~ Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "computation" f PerformGraphTransform
         PerformGraphTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PerformGraphTransform'computation
                 (\ x__ y__ -> x__{_PerformGraphTransform'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'computation" f PerformGraphTransform
         PerformGraphTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PerformGraphTransform'computation
                 (\ x__ y__ -> x__{_PerformGraphTransform'computation = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Graph.Graph,
          b ~ Proto.Karps.Proto.Graph.Graph, Prelude.Functor f) =>
         Lens.Labels.HasLens "functionalGraph" f PerformGraphTransform
         PerformGraphTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PerformGraphTransform'functionalGraph
                 (\ x__ y__ -> x__{_PerformGraphTransform'functionalGraph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'functionalGraph" f PerformGraphTransform
         PerformGraphTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PerformGraphTransform'functionalGraph
                 (\ x__ y__ -> x__{_PerformGraphTransform'functionalGraph = y__}))
              Prelude.id

instance (a ~ [NodeMapItem], b ~ [NodeMapItem],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "availableNodes" f PerformGraphTransform
         PerformGraphTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PerformGraphTransform'availableNodes
                 (\ x__ y__ -> x__{_PerformGraphTransform'availableNodes = y__}))
              Prelude.id

instance (a ~ [Proto.Karps.Proto.Graph.Path],
          b ~ [Proto.Karps.Proto.Graph.Path], Prelude.Functor f) =>
         Lens.Labels.HasLens "requestedPaths" f PerformGraphTransform
         PerformGraphTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PerformGraphTransform'requestedPaths
                 (\ x__ y__ -> x__{_PerformGraphTransform'requestedPaths = y__}))
              Prelude.id

instance (a ~ [ResourceStatus], b ~ [ResourceStatus],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "knownResources" f PerformGraphTransform
         PerformGraphTransform a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PerformGraphTransform'knownResources
                 (\ x__ y__ -> x__{_PerformGraphTransform'knownResources = y__}))
              Prelude.id

instance Data.Default.Class.Default PerformGraphTransform where
        def
          = PerformGraphTransform{_PerformGraphTransform'session =
                                    Prelude.Nothing,
                                  _PerformGraphTransform'computation = Prelude.Nothing,
                                  _PerformGraphTransform'functionalGraph = Prelude.Nothing,
                                  _PerformGraphTransform'availableNodes = [],
                                  _PerformGraphTransform'requestedPaths = [],
                                  _PerformGraphTransform'knownResources = []}

instance Data.ProtoLens.Message PerformGraphTransform where
        descriptor
          = let session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField maybe'session)
                      :: Data.ProtoLens.FieldDescriptor PerformGraphTransform
                computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField maybe'computation)
                      :: Data.ProtoLens.FieldDescriptor PerformGraphTransform
                functionalGraph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "functional_graph"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField maybe'functionalGraph)
                      :: Data.ProtoLens.FieldDescriptor PerformGraphTransform
                availableNodes__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "available_nodes"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor NodeMapItem)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         availableNodes)
                      :: Data.ProtoLens.FieldDescriptor PerformGraphTransform
                requestedPaths__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "requested_paths"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         requestedPaths)
                      :: Data.ProtoLens.FieldDescriptor PerformGraphTransform
                knownResources__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "known_resources"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResourceStatus)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         knownResources)
                      :: Data.ProtoLens.FieldDescriptor PerformGraphTransform
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.PerformGraphTransform")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, session__field_descriptor),
                    (Data.ProtoLens.Tag 2, computation__field_descriptor),
                    (Data.ProtoLens.Tag 3, functionalGraph__field_descriptor),
                    (Data.ProtoLens.Tag 4, availableNodes__field_descriptor),
                    (Data.ProtoLens.Tag 5, requestedPaths__field_descriptor),
                    (Data.ProtoLens.Tag 6, knownResources__field_descriptor)])
                (Data.Map.fromList
                   [("session", session__field_descriptor),
                    ("computation", computation__field_descriptor),
                    ("functional_graph", functionalGraph__field_descriptor),
                    ("available_nodes", availableNodes__field_descriptor),
                    ("requested_paths", requestedPaths__field_descriptor),
                    ("known_resources", knownResources__field_descriptor)])

data ResourceStatus = ResourceStatus{_ResourceStatus'resource ::
                                     !(Prelude.Maybe Proto.Karps.Proto.Io.ResourcePath),
                                     _ResourceStatus'stamp ::
                                     !(Prelude.Maybe Proto.Karps.Proto.Io.ResourceStamp)}
                    deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Io.ResourcePath,
          b ~ Proto.Karps.Proto.Io.ResourcePath, Prelude.Functor f) =>
         Lens.Labels.HasLens "resource" f ResourceStatus ResourceStatus a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ResourceStatus'resource
                 (\ x__ y__ -> x__{_ResourceStatus'resource = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Io.ResourcePath,
          b ~ Prelude.Maybe Proto.Karps.Proto.Io.ResourcePath,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'resource" f ResourceStatus
         ResourceStatus a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ResourceStatus'resource
                 (\ x__ y__ -> x__{_ResourceStatus'resource = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Io.ResourceStamp,
          b ~ Proto.Karps.Proto.Io.ResourceStamp, Prelude.Functor f) =>
         Lens.Labels.HasLens "stamp" f ResourceStatus ResourceStatus a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ResourceStatus'stamp
                 (\ x__ y__ -> x__{_ResourceStatus'stamp = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Io.ResourceStamp,
          b ~ Prelude.Maybe Proto.Karps.Proto.Io.ResourceStamp,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'stamp" f ResourceStatus ResourceStatus a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ResourceStatus'stamp
                 (\ x__ y__ -> x__{_ResourceStatus'stamp = y__}))
              Prelude.id

instance Data.Default.Class.Default ResourceStatus where
        def
          = ResourceStatus{_ResourceStatus'resource = Prelude.Nothing,
                           _ResourceStatus'stamp = Prelude.Nothing}

instance Data.ProtoLens.Message ResourceStatus where
        descriptor
          = let resource__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "resource"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Io.ResourcePath)
                      (Data.ProtoLens.OptionalField maybe'resource)
                      :: Data.ProtoLens.FieldDescriptor ResourceStatus
                stamp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "stamp"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Io.ResourceStamp)
                      (Data.ProtoLens.OptionalField maybe'stamp)
                      :: Data.ProtoLens.FieldDescriptor ResourceStatus
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ResourceStatus")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, resource__field_descriptor),
                    (Data.ProtoLens.Tag 2, stamp__field_descriptor)])
                (Data.Map.fromList
                   [("resource", resource__field_descriptor),
                    ("stamp", stamp__field_descriptor)])

availableNodes ::
               forall f s t a b .
                 Lens.Labels.HasLens "availableNodes" f s t a b =>
                 Lens.Family2.LensLike f s t a b
availableNodes
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "availableNodes")

computation ::
            forall f s t a b . Lens.Labels.HasLens "computation" f s t a b =>
              Lens.Family2.LensLike f s t a b
computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "computation")

content ::
        forall f s t a b . Lens.Labels.HasLens "content" f s t a b =>
          Lens.Family2.LensLike f s t a b
content
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "content")

error ::
      forall f s t a b . Lens.Labels.HasLens "error" f s t a b =>
        Lens.Family2.LensLike f s t a b
error
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "error")

failures ::
         forall f s t a b . Lens.Labels.HasLens "failures" f s t a b =>
           Lens.Family2.LensLike f s t a b
failures
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "failures")

functionalGraph ::
                forall f s t a b .
                  Lens.Labels.HasLens "functionalGraph" f s t a b =>
                  Lens.Family2.LensLike f s t a b
functionalGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "functionalGraph")

graph ::
      forall f s t a b . Lens.Labels.HasLens "graph" f s t a b =>
        Lens.Family2.LensLike f s t a b
graph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "graph")

graphDef ::
         forall f s t a b . Lens.Labels.HasLens "graphDef" f s t a b =>
           Lens.Family2.LensLike f s t a b
graphDef
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "graphDef")

knownResources ::
               forall f s t a b .
                 Lens.Labels.HasLens "knownResources" f s t a b =>
                 Lens.Family2.LensLike f s t a b
knownResources
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "knownResources")

level ::
      forall f s t a b . Lens.Labels.HasLens "level" f s t a b =>
        Lens.Family2.LensLike f s t a b
level
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "level")

maybe'computation ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'computation" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'computation")

maybe'functionalGraph ::
                      forall f s t a b .
                        Lens.Labels.HasLens "maybe'functionalGraph" f s t a b =>
                        Lens.Family2.LensLike f s t a b
maybe'functionalGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'functionalGraph")

maybe'graph ::
            forall f s t a b . Lens.Labels.HasLens "maybe'graph" f s t a b =>
              Lens.Family2.LensLike f s t a b
maybe'graph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graph")

maybe'graphDef ::
               forall f s t a b .
                 Lens.Labels.HasLens "maybe'graphDef" f s t a b =>
                 Lens.Family2.LensLike f s t a b
maybe'graphDef
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graphDef")

maybe'node ::
           forall f s t a b . Lens.Labels.HasLens "maybe'node" f s t a b =>
             Lens.Family2.LensLike f s t a b
maybe'node
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'node")

maybe'path ::
           forall f s t a b . Lens.Labels.HasLens "maybe'path" f s t a b =>
             Lens.Family2.LensLike f s t a b
maybe'path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'path")

maybe'pinnedGraph ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'pinnedGraph" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'pinnedGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'pinnedGraph")

maybe'relevantId ::
                 forall f s t a b .
                   Lens.Labels.HasLens "maybe'relevantId" f s t a b =>
                   Lens.Family2.LensLike f s t a b
maybe'relevantId
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'relevantId")

maybe'resource ::
               forall f s t a b .
                 Lens.Labels.HasLens "maybe'resource" f s t a b =>
                 Lens.Family2.LensLike f s t a b
maybe'resource
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'resource")

maybe'session ::
              forall f s t a b . Lens.Labels.HasLens "maybe'session" f s t a b =>
                Lens.Family2.LensLike f s t a b
maybe'session
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'session")

maybe'stamp ::
            forall f s t a b . Lens.Labels.HasLens "maybe'stamp" f s t a b =>
              Lens.Family2.LensLike f s t a b
maybe'stamp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'stamp")

messages ::
         forall f s t a b . Lens.Labels.HasLens "messages" f s t a b =>
           Lens.Family2.LensLike f s t a b
messages
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "messages")

node ::
     forall f s t a b . Lens.Labels.HasLens "node" f s t a b =>
       Lens.Family2.LensLike f s t a b
node
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "node")

nodeMap ::
        forall f s t a b . Lens.Labels.HasLens "nodeMap" f s t a b =>
          Lens.Family2.LensLike f s t a b
nodeMap
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "nodeMap")

path ::
     forall f s t a b . Lens.Labels.HasLens "path" f s t a b =>
       Lens.Family2.LensLike f s t a b
path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")

phase ::
      forall f s t a b . Lens.Labels.HasLens "phase" f s t a b =>
        Lens.Family2.LensLike f s t a b
phase
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "phase")

pinnedGraph ::
            forall f s t a b . Lens.Labels.HasLens "pinnedGraph" f s t a b =>
              Lens.Family2.LensLike f s t a b
pinnedGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "pinnedGraph")

relevantId ::
           forall f s t a b . Lens.Labels.HasLens "relevantId" f s t a b =>
             Lens.Family2.LensLike f s t a b
relevantId
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "relevantId")

requestedPaths ::
               forall f s t a b .
                 Lens.Labels.HasLens "requestedPaths" f s t a b =>
                 Lens.Family2.LensLike f s t a b
requestedPaths
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "requestedPaths")

resource ::
         forall f s t a b . Lens.Labels.HasLens "resource" f s t a b =>
           Lens.Family2.LensLike f s t a b
resource
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "resource")

resources ::
          forall f s t a b . Lens.Labels.HasLens "resources" f s t a b =>
            Lens.Family2.LensLike f s t a b
resources
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "resources")

session ::
        forall f s t a b . Lens.Labels.HasLens "session" f s t a b =>
          Lens.Family2.LensLike f s t a b
session
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "session")

stackTracePretty ::
                 forall f s t a b .
                   Lens.Labels.HasLens "stackTracePretty" f s t a b =>
                   Lens.Family2.LensLike f s t a b
stackTracePretty
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "stackTracePretty")

stamp ::
      forall f s t a b . Lens.Labels.HasLens "stamp" f s t a b =>
        Lens.Family2.LensLike f s t a b
stamp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "stamp")

steps ::
      forall f s t a b . Lens.Labels.HasLens "steps" f s t a b =>
        Lens.Family2.LensLike f s t a b
steps
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "steps")

successes ::
          forall f s t a b . Lens.Labels.HasLens "successes" f s t a b =>
            Lens.Family2.LensLike f s t a b
successes
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "successes")

value ::
      forall f s t a b . Lens.Labels.HasLens "value" f s t a b =>
        Lens.Family2.LensLike f s t a b
value
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "value")