{- This file was auto-generated from karps/proto/interface.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Karps.Proto.Interface where
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
import qualified Proto.Karps.Proto.Io

data CompilationResult = CompilationResult{_CompilationResult'error
                                           :: !Data.Text.Text,
                                           _CompilationResult'compilationGraph ::
                                           ![Proto.Karps.Proto.Graph.CompilationPhaseGraph]}
                       deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "error" f CompilationResult CompilationResult a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationResult'error
                 (\ x__ y__ -> x__{_CompilationResult'error = y__}))
              Prelude.id

instance (a ~ [Proto.Karps.Proto.Graph.CompilationPhaseGraph],
          b ~ [Proto.Karps.Proto.Graph.CompilationPhaseGraph],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "compilationGraph" f CompilationResult
         CompilationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationResult'compilationGraph
                 (\ x__ y__ -> x__{_CompilationResult'compilationGraph = y__}))
              Prelude.id

instance Data.Default.Class.Default CompilationResult where
        def
          = CompilationResult{_CompilationResult'error =
                                Data.ProtoLens.fieldDefault,
                              _CompilationResult'compilationGraph = []}

instance Data.ProtoLens.Message CompilationResult where
        descriptor
          = let error__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "error"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional error)
                      :: Data.ProtoLens.FieldDescriptor CompilationResult
                compilationGraph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "compilation_graph"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Graph.CompilationPhaseGraph)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         compilationGraph)
                      :: Data.ProtoLens.FieldDescriptor CompilationResult
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.CompilationResult")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, error__field_descriptor),
                    (Data.ProtoLens.Tag 2, compilationGraph__field_descriptor)])
                (Data.Map.fromList
                   [("error", error__field_descriptor),
                    ("compilation_graph", compilationGraph__field_descriptor)])

data ComputationStatusRequest = ComputationStatusRequest{_ComputationStatusRequest'session
                                                         ::
                                                         !(Prelude.Maybe
                                                             Proto.Karps.Proto.Computation.SessionId),
                                                         _ComputationStatusRequest'computation ::
                                                         !(Prelude.Maybe
                                                             Proto.Karps.Proto.Computation.ComputationId),
                                                         _ComputationStatusRequest'requestedPaths ::
                                                         ![Proto.Karps.Proto.Graph.Path]}
                              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Computation.SessionId,
          b ~ Proto.Karps.Proto.Computation.SessionId, Prelude.Functor f) =>
         Lens.Labels.HasLens "session" f ComputationStatusRequest
         ComputationStatusRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStatusRequest'session
                 (\ x__ y__ -> x__{_ComputationStatusRequest'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'session" f ComputationStatusRequest
         ComputationStatusRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStatusRequest'session
                 (\ x__ y__ -> x__{_ComputationStatusRequest'session = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Computation.ComputationId,
          b ~ Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "computation" f ComputationStatusRequest
         ComputationStatusRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStatusRequest'computation
                 (\ x__ y__ -> x__{_ComputationStatusRequest'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'computation" f ComputationStatusRequest
         ComputationStatusRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStatusRequest'computation
                 (\ x__ y__ -> x__{_ComputationStatusRequest'computation = y__}))
              Prelude.id

instance (a ~ [Proto.Karps.Proto.Graph.Path],
          b ~ [Proto.Karps.Proto.Graph.Path], Prelude.Functor f) =>
         Lens.Labels.HasLens "requestedPaths" f ComputationStatusRequest
         ComputationStatusRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _ComputationStatusRequest'requestedPaths
                 (\ x__ y__ -> x__{_ComputationStatusRequest'requestedPaths = y__}))
              Prelude.id

instance Data.Default.Class.Default ComputationStatusRequest where
        def
          = ComputationStatusRequest{_ComputationStatusRequest'session =
                                       Prelude.Nothing,
                                     _ComputationStatusRequest'computation = Prelude.Nothing,
                                     _ComputationStatusRequest'requestedPaths = []}

instance Data.ProtoLens.Message ComputationStatusRequest where
        descriptor
          = let session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField maybe'session)
                      :: Data.ProtoLens.FieldDescriptor ComputationStatusRequest
                computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField maybe'computation)
                      :: Data.ProtoLens.FieldDescriptor ComputationStatusRequest
                requestedPaths__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "requested_paths"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         requestedPaths)
                      :: Data.ProtoLens.FieldDescriptor ComputationStatusRequest
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ComputationStatusRequest")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, session__field_descriptor),
                    (Data.ProtoLens.Tag 2, computation__field_descriptor),
                    (Data.ProtoLens.Tag 3, requestedPaths__field_descriptor)])
                (Data.Map.fromList
                   [("session", session__field_descriptor),
                    ("computation", computation__field_descriptor),
                    ("requested_paths", requestedPaths__field_descriptor)])

data ComputationStreamResponse = ComputationStreamResponse{_ComputationStreamResponse'session
                                                           ::
                                                           !(Prelude.Maybe
                                                               Proto.Karps.Proto.Computation.SessionId),
                                                           _ComputationStreamResponse'computation ::
                                                           !(Prelude.Maybe
                                                               Proto.Karps.Proto.Computation.ComputationId),
                                                           _ComputationStreamResponse'startGraph ::
                                                           !(Prelude.Maybe
                                                               Proto.Karps.Proto.Graph.Graph),
                                                           _ComputationStreamResponse'pinnedGraph ::
                                                           !(Prelude.Maybe
                                                               Proto.Karps.Proto.Graph.Graph),
                                                           _ComputationStreamResponse'results ::
                                                           !(Prelude.Maybe
                                                               Proto.Karps.Proto.Computation.BatchComputationResult),
                                                           _ComputationStreamResponse'compilationResult
                                                           :: !(Prelude.Maybe CompilationResult)}
                               deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Computation.SessionId,
          b ~ Proto.Karps.Proto.Computation.SessionId, Prelude.Functor f) =>
         Lens.Labels.HasLens "session" f ComputationStreamResponse
         ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'session
                 (\ x__ y__ -> x__{_ComputationStreamResponse'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'session" f ComputationStreamResponse
         ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'session
                 (\ x__ y__ -> x__{_ComputationStreamResponse'session = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Computation.ComputationId,
          b ~ Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "computation" f ComputationStreamResponse
         ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'computation
                 (\ x__ y__ -> x__{_ComputationStreamResponse'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'computation" f ComputationStreamResponse
         ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'computation
                 (\ x__ y__ -> x__{_ComputationStreamResponse'computation = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Graph.Graph,
          b ~ Proto.Karps.Proto.Graph.Graph, Prelude.Functor f) =>
         Lens.Labels.HasLens "startGraph" f ComputationStreamResponse
         ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'startGraph
                 (\ x__ y__ -> x__{_ComputationStreamResponse'startGraph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'startGraph" f ComputationStreamResponse
         ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'startGraph
                 (\ x__ y__ -> x__{_ComputationStreamResponse'startGraph = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Graph.Graph,
          b ~ Proto.Karps.Proto.Graph.Graph, Prelude.Functor f) =>
         Lens.Labels.HasLens "pinnedGraph" f ComputationStreamResponse
         ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'pinnedGraph
                 (\ x__ y__ -> x__{_ComputationStreamResponse'pinnedGraph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'pinnedGraph" f ComputationStreamResponse
         ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'pinnedGraph
                 (\ x__ y__ -> x__{_ComputationStreamResponse'pinnedGraph = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Computation.BatchComputationResult,
          b ~ Proto.Karps.Proto.Computation.BatchComputationResult,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "results" f ComputationStreamResponse
         ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'results
                 (\ x__ y__ -> x__{_ComputationStreamResponse'results = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.BatchComputationResult,
          b ~
            Prelude.Maybe Proto.Karps.Proto.Computation.BatchComputationResult,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'results" f ComputationStreamResponse
         ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'results
                 (\ x__ y__ -> x__{_ComputationStreamResponse'results = y__}))
              Prelude.id

instance (a ~ CompilationResult, b ~ CompilationResult,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "compilationResult" f ComputationStreamResponse
         ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _ComputationStreamResponse'compilationResult
                 (\ x__ y__ ->
                    x__{_ComputationStreamResponse'compilationResult = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe CompilationResult,
          b ~ Prelude.Maybe CompilationResult, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'compilationResult" f
         ComputationStreamResponse ComputationStreamResponse a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _ComputationStreamResponse'compilationResult
                 (\ x__ y__ ->
                    x__{_ComputationStreamResponse'compilationResult = y__}))
              Prelude.id

instance Data.Default.Class.Default ComputationStreamResponse where
        def
          = ComputationStreamResponse{_ComputationStreamResponse'session =
                                        Prelude.Nothing,
                                      _ComputationStreamResponse'computation = Prelude.Nothing,
                                      _ComputationStreamResponse'startGraph = Prelude.Nothing,
                                      _ComputationStreamResponse'pinnedGraph = Prelude.Nothing,
                                      _ComputationStreamResponse'results = Prelude.Nothing,
                                      _ComputationStreamResponse'compilationResult =
                                        Prelude.Nothing}

instance Data.ProtoLens.Message ComputationStreamResponse where
        descriptor
          = let session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField maybe'session)
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
                computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField maybe'computation)
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
                startGraph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "start_graph"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField maybe'startGraph)
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
                pinnedGraph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "pinned_graph"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField maybe'pinnedGraph)
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
                results__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "results"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.BatchComputationResult)
                      (Data.ProtoLens.OptionalField maybe'results)
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
                compilationResult__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "compilation_result"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor CompilationResult)
                      (Data.ProtoLens.OptionalField maybe'compilationResult)
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ComputationStreamResponse")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, session__field_descriptor),
                    (Data.ProtoLens.Tag 2, computation__field_descriptor),
                    (Data.ProtoLens.Tag 3, startGraph__field_descriptor),
                    (Data.ProtoLens.Tag 4, pinnedGraph__field_descriptor),
                    (Data.ProtoLens.Tag 5, results__field_descriptor),
                    (Data.ProtoLens.Tag 6, compilationResult__field_descriptor)])
                (Data.Map.fromList
                   [("session", session__field_descriptor),
                    ("computation", computation__field_descriptor),
                    ("start_graph", startGraph__field_descriptor),
                    ("pinned_graph", pinnedGraph__field_descriptor),
                    ("results", results__field_descriptor),
                    ("compilation_result", compilationResult__field_descriptor)])

data CreateComputationRequest = CreateComputationRequest{_CreateComputationRequest'session
                                                         ::
                                                         !(Prelude.Maybe
                                                             Proto.Karps.Proto.Computation.SessionId),
                                                         _CreateComputationRequest'graph ::
                                                         !(Prelude.Maybe
                                                             Proto.Karps.Proto.Graph.Graph),
                                                         _CreateComputationRequest'requestedComputation
                                                         ::
                                                         !(Prelude.Maybe
                                                             Proto.Karps.Proto.Computation.ComputationId),
                                                         _CreateComputationRequest'requestedPaths ::
                                                         ![Proto.Karps.Proto.Graph.Path]}
                              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Computation.SessionId,
          b ~ Proto.Karps.Proto.Computation.SessionId, Prelude.Functor f) =>
         Lens.Labels.HasLens "session" f CreateComputationRequest
         CreateComputationRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateComputationRequest'session
                 (\ x__ y__ -> x__{_CreateComputationRequest'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'session" f CreateComputationRequest
         CreateComputationRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateComputationRequest'session
                 (\ x__ y__ -> x__{_CreateComputationRequest'session = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Graph.Graph,
          b ~ Proto.Karps.Proto.Graph.Graph, Prelude.Functor f) =>
         Lens.Labels.HasLens "graph" f CreateComputationRequest
         CreateComputationRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateComputationRequest'graph
                 (\ x__ y__ -> x__{_CreateComputationRequest'graph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Graph,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'graph" f CreateComputationRequest
         CreateComputationRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateComputationRequest'graph
                 (\ x__ y__ -> x__{_CreateComputationRequest'graph = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Computation.ComputationId,
          b ~ Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "requestedComputation" f
         CreateComputationRequest CreateComputationRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _CreateComputationRequest'requestedComputation
                 (\ x__ y__ ->
                    x__{_CreateComputationRequest'requestedComputation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'requestedComputation" f
         CreateComputationRequest CreateComputationRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _CreateComputationRequest'requestedComputation
                 (\ x__ y__ ->
                    x__{_CreateComputationRequest'requestedComputation = y__}))
              Prelude.id

instance (a ~ [Proto.Karps.Proto.Graph.Path],
          b ~ [Proto.Karps.Proto.Graph.Path], Prelude.Functor f) =>
         Lens.Labels.HasLens "requestedPaths" f CreateComputationRequest
         CreateComputationRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _CreateComputationRequest'requestedPaths
                 (\ x__ y__ -> x__{_CreateComputationRequest'requestedPaths = y__}))
              Prelude.id

instance Data.Default.Class.Default CreateComputationRequest where
        def
          = CreateComputationRequest{_CreateComputationRequest'session =
                                       Prelude.Nothing,
                                     _CreateComputationRequest'graph = Prelude.Nothing,
                                     _CreateComputationRequest'requestedComputation =
                                       Prelude.Nothing,
                                     _CreateComputationRequest'requestedPaths = []}

instance Data.ProtoLens.Message CreateComputationRequest where
        descriptor
          = let session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField maybe'session)
                      :: Data.ProtoLens.FieldDescriptor CreateComputationRequest
                graph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField maybe'graph)
                      :: Data.ProtoLens.FieldDescriptor CreateComputationRequest
                requestedComputation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "requested_computation"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField maybe'requestedComputation)
                      :: Data.ProtoLens.FieldDescriptor CreateComputationRequest
                requestedPaths__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "requested_paths"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         requestedPaths)
                      :: Data.ProtoLens.FieldDescriptor CreateComputationRequest
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.CreateComputationRequest")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, session__field_descriptor),
                    (Data.ProtoLens.Tag 3, graph__field_descriptor),
                    (Data.ProtoLens.Tag 4, requestedComputation__field_descriptor),
                    (Data.ProtoLens.Tag 5, requestedPaths__field_descriptor)])
                (Data.Map.fromList
                   [("session", session__field_descriptor),
                    ("graph", graph__field_descriptor),
                    ("requested_computation", requestedComputation__field_descriptor),
                    ("requested_paths", requestedPaths__field_descriptor)])

data CreateComputationResponse = CreateComputationResponse{}
                               deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance Data.Default.Class.Default CreateComputationResponse where
        def = CreateComputationResponse{}

instance Data.ProtoLens.Message CreateComputationResponse where
        descriptor
          = let in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.CreateComputationResponse")
                (Data.Map.fromList [])
                (Data.Map.fromList [])

data CreateSessionRequest = CreateSessionRequest{_CreateSessionRequest'requestedSession
                                                 ::
                                                 !(Prelude.Maybe
                                                     Proto.Karps.Proto.Computation.SessionId)}
                          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Computation.SessionId,
          b ~ Proto.Karps.Proto.Computation.SessionId, Prelude.Functor f) =>
         Lens.Labels.HasLens "requestedSession" f CreateSessionRequest
         CreateSessionRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateSessionRequest'requestedSession
                 (\ x__ y__ -> x__{_CreateSessionRequest'requestedSession = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          b ~ Prelude.Maybe Proto.Karps.Proto.Computation.SessionId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'requestedSession" f CreateSessionRequest
         CreateSessionRequest a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateSessionRequest'requestedSession
                 (\ x__ y__ -> x__{_CreateSessionRequest'requestedSession = y__}))
              Prelude.id

instance Data.Default.Class.Default CreateSessionRequest where
        def
          = CreateSessionRequest{_CreateSessionRequest'requestedSession =
                                   Prelude.Nothing}

instance Data.ProtoLens.Message CreateSessionRequest where
        descriptor
          = let requestedSession__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "requested_session"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField maybe'requestedSession)
                      :: Data.ProtoLens.FieldDescriptor CreateSessionRequest
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.CreateSessionRequest")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, requestedSession__field_descriptor)])
                (Data.Map.fromList
                   [("requested_session", requestedSession__field_descriptor)])

data CreateSessionResponse = CreateSessionResponse{}
                           deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance Data.Default.Class.Default CreateSessionResponse where
        def = CreateSessionResponse{}

instance Data.ProtoLens.Message CreateSessionResponse where
        descriptor
          = let in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.CreateSessionResponse")
                (Data.Map.fromList [])
                (Data.Map.fromList [])

compilationGraph ::
                 forall f s t a b .
                   Lens.Labels.HasLens "compilationGraph" f s t a b =>
                   Lens.Family2.LensLike f s t a b
compilationGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "compilationGraph")

compilationResult ::
                  forall f s t a b .
                    Lens.Labels.HasLens "compilationResult" f s t a b =>
                    Lens.Family2.LensLike f s t a b
compilationResult
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "compilationResult")

computation ::
            forall f s t a b . Lens.Labels.HasLens "computation" f s t a b =>
              Lens.Family2.LensLike f s t a b
computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "computation")

error ::
      forall f s t a b . Lens.Labels.HasLens "error" f s t a b =>
        Lens.Family2.LensLike f s t a b
error
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "error")

graph ::
      forall f s t a b . Lens.Labels.HasLens "graph" f s t a b =>
        Lens.Family2.LensLike f s t a b
graph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "graph")

maybe'compilationResult ::
                        forall f s t a b .
                          Lens.Labels.HasLens "maybe'compilationResult" f s t a b =>
                          Lens.Family2.LensLike f s t a b
maybe'compilationResult
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'compilationResult")

maybe'computation ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'computation" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'computation")

maybe'graph ::
            forall f s t a b . Lens.Labels.HasLens "maybe'graph" f s t a b =>
              Lens.Family2.LensLike f s t a b
maybe'graph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graph")

maybe'pinnedGraph ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'pinnedGraph" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'pinnedGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'pinnedGraph")

maybe'requestedComputation ::
                           forall f s t a b .
                             Lens.Labels.HasLens "maybe'requestedComputation" f s t a b =>
                             Lens.Family2.LensLike f s t a b
maybe'requestedComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'requestedComputation")

maybe'requestedSession ::
                       forall f s t a b .
                         Lens.Labels.HasLens "maybe'requestedSession" f s t a b =>
                         Lens.Family2.LensLike f s t a b
maybe'requestedSession
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'requestedSession")

maybe'results ::
              forall f s t a b . Lens.Labels.HasLens "maybe'results" f s t a b =>
                Lens.Family2.LensLike f s t a b
maybe'results
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'results")

maybe'session ::
              forall f s t a b . Lens.Labels.HasLens "maybe'session" f s t a b =>
                Lens.Family2.LensLike f s t a b
maybe'session
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'session")

maybe'startGraph ::
                 forall f s t a b .
                   Lens.Labels.HasLens "maybe'startGraph" f s t a b =>
                   Lens.Family2.LensLike f s t a b
maybe'startGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'startGraph")

pinnedGraph ::
            forall f s t a b . Lens.Labels.HasLens "pinnedGraph" f s t a b =>
              Lens.Family2.LensLike f s t a b
pinnedGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "pinnedGraph")

requestedComputation ::
                     forall f s t a b .
                       Lens.Labels.HasLens "requestedComputation" f s t a b =>
                       Lens.Family2.LensLike f s t a b
requestedComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "requestedComputation")

requestedPaths ::
               forall f s t a b .
                 Lens.Labels.HasLens "requestedPaths" f s t a b =>
                 Lens.Family2.LensLike f s t a b
requestedPaths
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "requestedPaths")

requestedSession ::
                 forall f s t a b .
                   Lens.Labels.HasLens "requestedSession" f s t a b =>
                   Lens.Family2.LensLike f s t a b
requestedSession
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "requestedSession")

results ::
        forall f s t a b . Lens.Labels.HasLens "results" f s t a b =>
          Lens.Family2.LensLike f s t a b
results
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "results")

session ::
        forall f s t a b . Lens.Labels.HasLens "session" f s t a b =>
          Lens.Family2.LensLike f s t a b
session
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "session")

startGraph ::
           forall f s t a b . Lens.Labels.HasLens "startGraph" f s t a b =>
             Lens.Family2.LensLike f s t a b
startGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "startGraph")