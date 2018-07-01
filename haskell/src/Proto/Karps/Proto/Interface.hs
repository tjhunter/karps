{- This file was auto-generated from karps/proto/interface.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Interface
       (KarpsMain(..), CompilationResult(..),
        ComputationStatusRequest(..), ComputationStreamResponse(..),
        CreateComputationRequest(..), CreateComputationResponse(..),
        CreateSessionRequest(..), CreateSessionResponse(..))
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
import qualified Proto.Karps.Proto.Io
import qualified Proto.Karps.Proto.Profiling

{- | Fields :

    * 'Proto.Karps.Proto.Interface_Fields.error' @:: Lens' CompilationResult Data.Text.Text@
    * 'Proto.Karps.Proto.Interface_Fields.compilationGraph' @:: Lens' CompilationResult
  [Proto.Karps.Proto.Graph.CompilationPhaseGraph]@
 -}
data CompilationResult = CompilationResult{_CompilationResult'error
                                           :: !Data.Text.Text,
                                           _CompilationResult'compilationGraph ::
                                           ![Proto.Karps.Proto.Graph.CompilationPhaseGraph],
                                           _CompilationResult'_unknownFields ::
                                           !Data.ProtoLens.FieldSet}
                           deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f CompilationResult x a, a ~ b) =>
         Lens.Labels.HasLens f CompilationResult CompilationResult x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilationResult "error" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationResult'error
                 (\ x__ y__ -> x__{_CompilationResult'error = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CompilationResult "compilationGraph"
           ([Proto.Karps.Proto.Graph.CompilationPhaseGraph])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationResult'compilationGraph
                 (\ x__ y__ -> x__{_CompilationResult'compilationGraph = y__}))
              Prelude.id
instance Data.Default.Class.Default CompilationResult where
        def
          = CompilationResult{_CompilationResult'error =
                                Data.ProtoLens.fieldDefault,
                              _CompilationResult'compilationGraph = [],
                              _CompilationResult'_unknownFields = ([])}
instance Data.ProtoLens.Message CompilationResult where
        messageName _ = Data.Text.pack "karps.core.CompilationResult"
        fieldsByTag
          = let error__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "error"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "error")))
                      :: Data.ProtoLens.FieldDescriptor CompilationResult
                compilationGraph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "compilation_graph"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Graph.CompilationPhaseGraph)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "compilationGraph")))
                      :: Data.ProtoLens.FieldDescriptor CompilationResult
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, error__field_descriptor),
                 (Data.ProtoLens.Tag 2, compilationGraph__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _CompilationResult'_unknownFields
              (\ x__ y__ -> x__{_CompilationResult'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Interface_Fields.session' @:: Lens' ComputationStatusRequest
  Proto.Karps.Proto.Computation.SessionId@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'session' @:: Lens' ComputationStatusRequest
  (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)@
    * 'Proto.Karps.Proto.Interface_Fields.computation' @:: Lens' ComputationStatusRequest
  Proto.Karps.Proto.Computation.ComputationId@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'computation' @:: Lens' ComputationStatusRequest
  (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)@
    * 'Proto.Karps.Proto.Interface_Fields.requestedPaths' @:: Lens' ComputationStatusRequest [Proto.Karps.Proto.Graph.Path]@
 -}
data ComputationStatusRequest = ComputationStatusRequest{_ComputationStatusRequest'session
                                                         ::
                                                         !(Prelude.Maybe
                                                             Proto.Karps.Proto.Computation.SessionId),
                                                         _ComputationStatusRequest'computation ::
                                                         !(Prelude.Maybe
                                                             Proto.Karps.Proto.Computation.ComputationId),
                                                         _ComputationStatusRequest'requestedPaths ::
                                                         ![Proto.Karps.Proto.Graph.Path],
                                                         _ComputationStatusRequest'_unknownFields ::
                                                         !Data.ProtoLens.FieldSet}
                                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ComputationStatusRequest x a,
          a ~ b) =>
         Lens.Labels.HasLens f ComputationStatusRequest
           ComputationStatusRequest
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStatusRequest "session"
           (Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStatusRequest'session
                 (\ x__ y__ -> x__{_ComputationStatusRequest'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStatusRequest "maybe'session"
           (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStatusRequest'session
                 (\ x__ y__ -> x__{_ComputationStatusRequest'session = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStatusRequest "computation"
           (Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStatusRequest'computation
                 (\ x__ y__ -> x__{_ComputationStatusRequest'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStatusRequest "maybe'computation"
           (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStatusRequest'computation
                 (\ x__ y__ -> x__{_ComputationStatusRequest'computation = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStatusRequest "requestedPaths"
           ([Proto.Karps.Proto.Graph.Path])
         where
        lensOf' _
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
                                     _ComputationStatusRequest'requestedPaths = [],
                                     _ComputationStatusRequest'_unknownFields = ([])}
instance Data.ProtoLens.Message ComputationStatusRequest where
        messageName _
          = Data.Text.pack "karps.core.ComputationStatusRequest"
        fieldsByTag
          = let session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'session")))
                      :: Data.ProtoLens.FieldDescriptor ComputationStatusRequest
                computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'computation")))
                      :: Data.ProtoLens.FieldDescriptor ComputationStatusRequest
                requestedPaths__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "requested_paths"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "requestedPaths")))
                      :: Data.ProtoLens.FieldDescriptor ComputationStatusRequest
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, session__field_descriptor),
                 (Data.ProtoLens.Tag 2, computation__field_descriptor),
                 (Data.ProtoLens.Tag 3, requestedPaths__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _ComputationStatusRequest'_unknownFields
              (\ x__ y__ -> x__{_ComputationStatusRequest'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Interface_Fields.session' @:: Lens' ComputationStreamResponse
  Proto.Karps.Proto.Computation.SessionId@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'session' @:: Lens' ComputationStreamResponse
  (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)@
    * 'Proto.Karps.Proto.Interface_Fields.computation' @:: Lens' ComputationStreamResponse
  Proto.Karps.Proto.Computation.ComputationId@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'computation' @:: Lens' ComputationStreamResponse
  (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)@
    * 'Proto.Karps.Proto.Interface_Fields.startGraph' @:: Lens' ComputationStreamResponse Proto.Karps.Proto.Graph.Graph@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'startGraph' @:: Lens' ComputationStreamResponse
  (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)@
    * 'Proto.Karps.Proto.Interface_Fields.pinnedGraph' @:: Lens' ComputationStreamResponse Proto.Karps.Proto.Graph.Graph@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'pinnedGraph' @:: Lens' ComputationStreamResponse
  (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)@
    * 'Proto.Karps.Proto.Interface_Fields.results' @:: Lens' ComputationStreamResponse
  Proto.Karps.Proto.Computation.BatchComputationResult@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'results' @:: Lens' ComputationStreamResponse
  (Prelude.Maybe
     Proto.Karps.Proto.Computation.BatchComputationResult)@
    * 'Proto.Karps.Proto.Interface_Fields.compilationResult' @:: Lens' ComputationStreamResponse CompilationResult@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'compilationResult' @:: Lens' ComputationStreamResponse (Prelude.Maybe CompilationResult)@
    * 'Proto.Karps.Proto.Interface_Fields.computationTrace' @:: Lens' ComputationStreamResponse
  Proto.Karps.Proto.Profiling.ComputationTrace@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'computationTrace' @:: Lens' ComputationStreamResponse
  (Prelude.Maybe Proto.Karps.Proto.Profiling.ComputationTrace)@
 -}
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
                                                           :: !(Prelude.Maybe CompilationResult),
                                                           _ComputationStreamResponse'computationTrace
                                                           ::
                                                           !(Prelude.Maybe
                                                               Proto.Karps.Proto.Profiling.ComputationTrace),
                                                           _ComputationStreamResponse'_unknownFields
                                                           :: !Data.ProtoLens.FieldSet}
                                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ComputationStreamResponse x a,
          a ~ b) =>
         Lens.Labels.HasLens f ComputationStreamResponse
           ComputationStreamResponse
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse "session"
           (Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'session
                 (\ x__ y__ -> x__{_ComputationStreamResponse'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse "maybe'session"
           (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'session
                 (\ x__ y__ -> x__{_ComputationStreamResponse'session = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse "computation"
           (Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'computation
                 (\ x__ y__ -> x__{_ComputationStreamResponse'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse
           "maybe'computation"
           (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'computation
                 (\ x__ y__ -> x__{_ComputationStreamResponse'computation = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse "startGraph"
           (Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'startGraph
                 (\ x__ y__ -> x__{_ComputationStreamResponse'startGraph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse "maybe'startGraph"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'startGraph
                 (\ x__ y__ -> x__{_ComputationStreamResponse'startGraph = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse "pinnedGraph"
           (Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'pinnedGraph
                 (\ x__ y__ -> x__{_ComputationStreamResponse'pinnedGraph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse
           "maybe'pinnedGraph"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'pinnedGraph
                 (\ x__ y__ -> x__{_ComputationStreamResponse'pinnedGraph = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse "results"
           (Proto.Karps.Proto.Computation.BatchComputationResult)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'results
                 (\ x__ y__ -> x__{_ComputationStreamResponse'results = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse "maybe'results"
           (Prelude.Maybe
              Proto.Karps.Proto.Computation.BatchComputationResult)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationStreamResponse'results
                 (\ x__ y__ -> x__{_ComputationStreamResponse'results = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse
           "compilationResult"
           (CompilationResult)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _ComputationStreamResponse'compilationResult
                 (\ x__ y__ ->
                    x__{_ComputationStreamResponse'compilationResult = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse
           "maybe'compilationResult"
           (Prelude.Maybe CompilationResult)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _ComputationStreamResponse'compilationResult
                 (\ x__ y__ ->
                    x__{_ComputationStreamResponse'compilationResult = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse "computationTrace"
           (Proto.Karps.Proto.Profiling.ComputationTrace)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _ComputationStreamResponse'computationTrace
                 (\ x__ y__ ->
                    x__{_ComputationStreamResponse'computationTrace = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationStreamResponse
           "maybe'computationTrace"
           (Prelude.Maybe Proto.Karps.Proto.Profiling.ComputationTrace)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _ComputationStreamResponse'computationTrace
                 (\ x__ y__ ->
                    x__{_ComputationStreamResponse'computationTrace = y__}))
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
                                        Prelude.Nothing,
                                      _ComputationStreamResponse'computationTrace = Prelude.Nothing,
                                      _ComputationStreamResponse'_unknownFields = ([])}
instance Data.ProtoLens.Message ComputationStreamResponse where
        messageName _
          = Data.Text.pack "karps.core.ComputationStreamResponse"
        fieldsByTag
          = let session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'session")))
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
                computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'computation")))
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
                startGraph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "start_graph"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'startGraph")))
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
                pinnedGraph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "pinned_graph"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'pinnedGraph")))
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
                results__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "results"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.BatchComputationResult)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'results")))
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
                compilationResult__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "compilation_result"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor CompilationResult)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'compilationResult")))
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
                computationTrace__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation_trace"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Profiling.ComputationTrace)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'computationTrace")))
                      :: Data.ProtoLens.FieldDescriptor ComputationStreamResponse
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, session__field_descriptor),
                 (Data.ProtoLens.Tag 2, computation__field_descriptor),
                 (Data.ProtoLens.Tag 3, startGraph__field_descriptor),
                 (Data.ProtoLens.Tag 4, pinnedGraph__field_descriptor),
                 (Data.ProtoLens.Tag 5, results__field_descriptor),
                 (Data.ProtoLens.Tag 6, compilationResult__field_descriptor),
                 (Data.ProtoLens.Tag 7, computationTrace__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _ComputationStreamResponse'_unknownFields
              (\ x__ y__ -> x__{_ComputationStreamResponse'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Interface_Fields.session' @:: Lens' CreateComputationRequest
  Proto.Karps.Proto.Computation.SessionId@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'session' @:: Lens' CreateComputationRequest
  (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)@
    * 'Proto.Karps.Proto.Interface_Fields.graph' @:: Lens' CreateComputationRequest Proto.Karps.Proto.Graph.Graph@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'graph' @:: Lens' CreateComputationRequest
  (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)@
    * 'Proto.Karps.Proto.Interface_Fields.requestedComputation' @:: Lens' CreateComputationRequest
  Proto.Karps.Proto.Computation.ComputationId@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'requestedComputation' @:: Lens' CreateComputationRequest
  (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)@
    * 'Proto.Karps.Proto.Interface_Fields.requestedPaths' @:: Lens' CreateComputationRequest [Proto.Karps.Proto.Graph.Path]@
 -}
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
                                                         ![Proto.Karps.Proto.Graph.Path],
                                                         _CreateComputationRequest'_unknownFields ::
                                                         !Data.ProtoLens.FieldSet}
                                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f CreateComputationRequest x a,
          a ~ b) =>
         Lens.Labels.HasLens f CreateComputationRequest
           CreateComputationRequest
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CreateComputationRequest "session"
           (Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateComputationRequest'session
                 (\ x__ y__ -> x__{_CreateComputationRequest'session = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CreateComputationRequest "maybe'session"
           (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateComputationRequest'session
                 (\ x__ y__ -> x__{_CreateComputationRequest'session = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CreateComputationRequest "graph"
           (Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateComputationRequest'graph
                 (\ x__ y__ -> x__{_CreateComputationRequest'graph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CreateComputationRequest "maybe'graph"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Graph)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateComputationRequest'graph
                 (\ x__ y__ -> x__{_CreateComputationRequest'graph = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CreateComputationRequest
           "requestedComputation"
           (Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _CreateComputationRequest'requestedComputation
                 (\ x__ y__ ->
                    x__{_CreateComputationRequest'requestedComputation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CreateComputationRequest
           "maybe'requestedComputation"
           (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _CreateComputationRequest'requestedComputation
                 (\ x__ y__ ->
                    x__{_CreateComputationRequest'requestedComputation = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CreateComputationRequest "requestedPaths"
           ([Proto.Karps.Proto.Graph.Path])
         where
        lensOf' _
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
                                     _CreateComputationRequest'requestedPaths = [],
                                     _CreateComputationRequest'_unknownFields = ([])}
instance Data.ProtoLens.Message CreateComputationRequest where
        messageName _
          = Data.Text.pack "karps.core.CreateComputationRequest"
        fieldsByTag
          = let session__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "session"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'session")))
                      :: Data.ProtoLens.FieldDescriptor CreateComputationRequest
                graph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Graph)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graph")))
                      :: Data.ProtoLens.FieldDescriptor CreateComputationRequest
                requestedComputation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "requested_computation"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.ComputationId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'requestedComputation")))
                      :: Data.ProtoLens.FieldDescriptor CreateComputationRequest
                requestedPaths__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "requested_paths"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "requestedPaths")))
                      :: Data.ProtoLens.FieldDescriptor CreateComputationRequest
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, session__field_descriptor),
                 (Data.ProtoLens.Tag 3, graph__field_descriptor),
                 (Data.ProtoLens.Tag 4, requestedComputation__field_descriptor),
                 (Data.ProtoLens.Tag 5, requestedPaths__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _CreateComputationRequest'_unknownFields
              (\ x__ y__ -> x__{_CreateComputationRequest'_unknownFields = y__})
{- | Fields :

 -}
data CreateComputationResponse = CreateComputationResponse{_CreateComputationResponse'_unknownFields
                                                           :: !Data.ProtoLens.FieldSet}
                                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f CreateComputationResponse x a,
          a ~ b) =>
         Lens.Labels.HasLens f CreateComputationResponse
           CreateComputationResponse
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Data.Default.Class.Default CreateComputationResponse where
        def
          = CreateComputationResponse{_CreateComputationResponse'_unknownFields
                                        = ([])}
instance Data.ProtoLens.Message CreateComputationResponse where
        messageName _
          = Data.Text.pack "karps.core.CreateComputationResponse"
        fieldsByTag = let in Data.Map.fromList []
        unknownFields
          = Lens.Family2.Unchecked.lens
              _CreateComputationResponse'_unknownFields
              (\ x__ y__ -> x__{_CreateComputationResponse'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Interface_Fields.requestedSession' @:: Lens' CreateSessionRequest Proto.Karps.Proto.Computation.SessionId@
    * 'Proto.Karps.Proto.Interface_Fields.maybe'requestedSession' @:: Lens' CreateSessionRequest
  (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)@
 -}
data CreateSessionRequest = CreateSessionRequest{_CreateSessionRequest'requestedSession
                                                 ::
                                                 !(Prelude.Maybe
                                                     Proto.Karps.Proto.Computation.SessionId),
                                                 _CreateSessionRequest'_unknownFields ::
                                                 !Data.ProtoLens.FieldSet}
                              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f CreateSessionRequest x a,
          a ~ b) =>
         Lens.Labels.HasLens f CreateSessionRequest CreateSessionRequest x a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CreateSessionRequest "requestedSession"
           (Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateSessionRequest'requestedSession
                 (\ x__ y__ -> x__{_CreateSessionRequest'requestedSession = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CreateSessionRequest
           "maybe'requestedSession"
           (Prelude.Maybe Proto.Karps.Proto.Computation.SessionId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CreateSessionRequest'requestedSession
                 (\ x__ y__ -> x__{_CreateSessionRequest'requestedSession = y__}))
              Prelude.id
instance Data.Default.Class.Default CreateSessionRequest where
        def
          = CreateSessionRequest{_CreateSessionRequest'requestedSession =
                                   Prelude.Nothing,
                                 _CreateSessionRequest'_unknownFields = ([])}
instance Data.ProtoLens.Message CreateSessionRequest where
        messageName _ = Data.Text.pack "karps.core.CreateSessionRequest"
        fieldsByTag
          = let requestedSession__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "requested_session"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Computation.SessionId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'requestedSession")))
                      :: Data.ProtoLens.FieldDescriptor CreateSessionRequest
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, requestedSession__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _CreateSessionRequest'_unknownFields
              (\ x__ y__ -> x__{_CreateSessionRequest'_unknownFields = y__})
{- | Fields :

 -}
data CreateSessionResponse = CreateSessionResponse{_CreateSessionResponse'_unknownFields
                                                   :: !Data.ProtoLens.FieldSet}
                               deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f CreateSessionResponse x a,
          a ~ b) =>
         Lens.Labels.HasLens f CreateSessionResponse CreateSessionResponse x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Data.Default.Class.Default CreateSessionResponse where
        def
          = CreateSessionResponse{_CreateSessionResponse'_unknownFields =
                                    ([])}
instance Data.ProtoLens.Message CreateSessionResponse where
        messageName _ = Data.Text.pack "karps.core.CreateSessionResponse"
        fieldsByTag = let in Data.Map.fromList []
        unknownFields
          = Lens.Family2.Unchecked.lens _CreateSessionResponse'_unknownFields
              (\ x__ y__ -> x__{_CreateSessionResponse'_unknownFields = y__})
data KarpsMain = KarpsMain{}
                   deriving ()
instance Data.ProtoLens.Service.Types.Service KarpsMain where
        type ServiceName KarpsMain = "KarpsMain"
        type ServicePackage KarpsMain = "karps.core"
        type ServiceMethods KarpsMain =
             '["createSession", "streamCreateComputation"]
instance Data.ProtoLens.Service.Types.HasMethodImpl KarpsMain
           "createSession"
         where
        type MethodName KarpsMain "createSession" = "CreateSession"
        type MethodInput KarpsMain "createSession" = CreateSessionRequest
        type MethodOutput KarpsMain "createSession" = CreateSessionResponse
        type MethodStreamingType KarpsMain "createSession" =
             'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl KarpsMain
           "streamCreateComputation"
         where
        type MethodName KarpsMain "streamCreateComputation" =
             "StreamCreateComputation"
        type MethodInput KarpsMain "streamCreateComputation" =
             CreateComputationRequest
        type MethodOutput KarpsMain "streamCreateComputation" =
             ComputationStreamResponse
        type MethodStreamingType KarpsMain "streamCreateComputation" =
             'Data.ProtoLens.Service.Types.ServerStreaming