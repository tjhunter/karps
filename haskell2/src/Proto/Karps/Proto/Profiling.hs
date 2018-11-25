{- This file was auto-generated from karps/proto/profiling.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Profiling
       (ChromeTraceEvent(..), ComputationTrace(..),
        NodeComputationBeginEvent(..), NodeComputationEndEvent(..),
        NodeComputationEvent(..), NodeComputationEvent'Event(..),
        _NodeComputationEvent'BeginComputation,
        _NodeComputationEvent'EndComputation)
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
import qualified Proto.Karps.Proto.Graph

{- | Fields :

    * 'Proto.Karps.Proto.Profiling_Fields.name' @:: Lens' ChromeTraceEvent Data.Text.Text@
    * 'Proto.Karps.Proto.Profiling_Fields.ph' @:: Lens' ChromeTraceEvent Data.Text.Text@
    * 'Proto.Karps.Proto.Profiling_Fields.ts' @:: Lens' ChromeTraceEvent Data.Int.Int64@
    * 'Proto.Karps.Proto.Profiling_Fields.pid' @:: Lens' ChromeTraceEvent Data.Text.Text@
    * 'Proto.Karps.Proto.Profiling_Fields.tid' @:: Lens' ChromeTraceEvent Data.Text.Text@
 -}
data ChromeTraceEvent = ChromeTraceEvent{_ChromeTraceEvent'name ::
                                         !Data.Text.Text,
                                         _ChromeTraceEvent'ph :: !Data.Text.Text,
                                         _ChromeTraceEvent'ts :: !Data.Int.Int64,
                                         _ChromeTraceEvent'pid :: !Data.Text.Text,
                                         _ChromeTraceEvent'tid :: !Data.Text.Text,
                                         _ChromeTraceEvent'_unknownFields ::
                                         !Data.ProtoLens.FieldSet}
                          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ChromeTraceEvent x a, a ~ b) =>
         Lens.Labels.HasLens f ChromeTraceEvent ChromeTraceEvent x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ChromeTraceEvent "name" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ChromeTraceEvent'name
                 (\ x__ y__ -> x__{_ChromeTraceEvent'name = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ChromeTraceEvent "ph" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ChromeTraceEvent'ph
                 (\ x__ y__ -> x__{_ChromeTraceEvent'ph = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ChromeTraceEvent "ts" (Data.Int.Int64)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ChromeTraceEvent'ts
                 (\ x__ y__ -> x__{_ChromeTraceEvent'ts = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ChromeTraceEvent "pid" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ChromeTraceEvent'pid
                 (\ x__ y__ -> x__{_ChromeTraceEvent'pid = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ChromeTraceEvent "tid" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ChromeTraceEvent'tid
                 (\ x__ y__ -> x__{_ChromeTraceEvent'tid = y__}))
              Prelude.id
instance Data.Default.Class.Default ChromeTraceEvent where
        def
          = ChromeTraceEvent{_ChromeTraceEvent'name =
                               Data.ProtoLens.fieldDefault,
                             _ChromeTraceEvent'ph = Data.ProtoLens.fieldDefault,
                             _ChromeTraceEvent'ts = Data.ProtoLens.fieldDefault,
                             _ChromeTraceEvent'pid = Data.ProtoLens.fieldDefault,
                             _ChromeTraceEvent'tid = Data.ProtoLens.fieldDefault,
                             _ChromeTraceEvent'_unknownFields = ([])}
instance Data.ProtoLens.Message ChromeTraceEvent where
        messageName _ = Data.Text.pack "karps.core.ChromeTraceEvent"
        fieldsByTag
          = let name__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "name")))
                      :: Data.ProtoLens.FieldDescriptor ChromeTraceEvent
                ph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "ph"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "ph")))
                      :: Data.ProtoLens.FieldDescriptor ChromeTraceEvent
                ts__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "ts"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "ts")))
                      :: Data.ProtoLens.FieldDescriptor ChromeTraceEvent
                pid__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "pid"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "pid")))
                      :: Data.ProtoLens.FieldDescriptor ChromeTraceEvent
                tid__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "tid"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "tid")))
                      :: Data.ProtoLens.FieldDescriptor ChromeTraceEvent
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, name__field_descriptor),
                 (Data.ProtoLens.Tag 2, ph__field_descriptor),
                 (Data.ProtoLens.Tag 3, ts__field_descriptor),
                 (Data.ProtoLens.Tag 4, pid__field_descriptor),
                 (Data.ProtoLens.Tag 5, tid__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ChromeTraceEvent'_unknownFields
              (\ x__ y__ -> x__{_ChromeTraceEvent'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Profiling_Fields.chromeEvents' @:: Lens' ComputationTrace [ChromeTraceEvent]@
    * 'Proto.Karps.Proto.Profiling_Fields.computationEvents' @:: Lens' ComputationTrace [NodeComputationEvent]@
 -}
data ComputationTrace = ComputationTrace{_ComputationTrace'chromeEvents
                                         :: ![ChromeTraceEvent],
                                         _ComputationTrace'computationEvents ::
                                         ![NodeComputationEvent],
                                         _ComputationTrace'_unknownFields ::
                                         !Data.ProtoLens.FieldSet}
                          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ComputationTrace x a, a ~ b) =>
         Lens.Labels.HasLens f ComputationTrace ComputationTrace x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationTrace "chromeEvents"
           ([ChromeTraceEvent])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationTrace'chromeEvents
                 (\ x__ y__ -> x__{_ComputationTrace'chromeEvents = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationTrace "computationEvents"
           ([NodeComputationEvent])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationTrace'computationEvents
                 (\ x__ y__ -> x__{_ComputationTrace'computationEvents = y__}))
              Prelude.id
instance Data.Default.Class.Default ComputationTrace where
        def
          = ComputationTrace{_ComputationTrace'chromeEvents = [],
                             _ComputationTrace'computationEvents = [],
                             _ComputationTrace'_unknownFields = ([])}
instance Data.ProtoLens.Message ComputationTrace where
        messageName _ = Data.Text.pack "karps.core.ComputationTrace"
        fieldsByTag
          = let chromeEvents__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "chrome_events"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ChromeTraceEvent)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "chromeEvents")))
                      :: Data.ProtoLens.FieldDescriptor ComputationTrace
                computationEvents__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation_events"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor NodeComputationEvent)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "computationEvents")))
                      :: Data.ProtoLens.FieldDescriptor ComputationTrace
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, chromeEvents__field_descriptor),
                 (Data.ProtoLens.Tag 2, computationEvents__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ComputationTrace'_unknownFields
              (\ x__ y__ -> x__{_ComputationTrace'_unknownFields = y__})
{- | Fields :

 -}
data NodeComputationBeginEvent = NodeComputationBeginEvent{_NodeComputationBeginEvent'_unknownFields
                                                           :: !Data.ProtoLens.FieldSet}
                                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f NodeComputationBeginEvent x a,
          a ~ b) =>
         Lens.Labels.HasLens f NodeComputationBeginEvent
           NodeComputationBeginEvent
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Data.Default.Class.Default NodeComputationBeginEvent where
        def
          = NodeComputationBeginEvent{_NodeComputationBeginEvent'_unknownFields
                                        = ([])}
instance Data.ProtoLens.Message NodeComputationBeginEvent where
        messageName _
          = Data.Text.pack "karps.core.NodeComputationBeginEvent"
        fieldsByTag = let in Data.Map.fromList []
        unknownFields
          = Lens.Family2.Unchecked.lens
              _NodeComputationBeginEvent'_unknownFields
              (\ x__ y__ -> x__{_NodeComputationBeginEvent'_unknownFields = y__})
{- | Fields :

 -}
data NodeComputationEndEvent = NodeComputationEndEvent{_NodeComputationEndEvent'_unknownFields
                                                       :: !Data.ProtoLens.FieldSet}
                                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f NodeComputationEndEvent x a,
          a ~ b) =>
         Lens.Labels.HasLens f NodeComputationEndEvent
           NodeComputationEndEvent
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Data.Default.Class.Default NodeComputationEndEvent where
        def
          = NodeComputationEndEvent{_NodeComputationEndEvent'_unknownFields =
                                      ([])}
instance Data.ProtoLens.Message NodeComputationEndEvent where
        messageName _ = Data.Text.pack "karps.core.NodeComputationEndEvent"
        fieldsByTag = let in Data.Map.fromList []
        unknownFields
          = Lens.Family2.Unchecked.lens
              _NodeComputationEndEvent'_unknownFields
              (\ x__ y__ -> x__{_NodeComputationEndEvent'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Profiling_Fields.localPath' @:: Lens' NodeComputationEvent Proto.Karps.Proto.Graph.Path@
    * 'Proto.Karps.Proto.Profiling_Fields.maybe'localPath' @:: Lens' NodeComputationEvent
  (Prelude.Maybe Proto.Karps.Proto.Graph.Path)@
    * 'Proto.Karps.Proto.Profiling_Fields.timestamp' @:: Lens' NodeComputationEvent Data.Int.Int64@
    * 'Proto.Karps.Proto.Profiling_Fields.maybe'event' @:: Lens' NodeComputationEvent
  (Prelude.Maybe NodeComputationEvent'Event)@
    * 'Proto.Karps.Proto.Profiling_Fields.maybe'beginComputation' @:: Lens' NodeComputationEvent
  (Prelude.Maybe NodeComputationBeginEvent)@
    * 'Proto.Karps.Proto.Profiling_Fields.beginComputation' @:: Lens' NodeComputationEvent NodeComputationBeginEvent@
    * 'Proto.Karps.Proto.Profiling_Fields.maybe'endComputation' @:: Lens' NodeComputationEvent (Prelude.Maybe NodeComputationEndEvent)@
    * 'Proto.Karps.Proto.Profiling_Fields.endComputation' @:: Lens' NodeComputationEvent NodeComputationEndEvent@
 -}
data NodeComputationEvent = NodeComputationEvent{_NodeComputationEvent'localPath
                                                 :: !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                                                 _NodeComputationEvent'timestamp :: !Data.Int.Int64,
                                                 _NodeComputationEvent'event ::
                                                 !(Prelude.Maybe NodeComputationEvent'Event),
                                                 _NodeComputationEvent'_unknownFields ::
                                                 !Data.ProtoLens.FieldSet}
                              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
data NodeComputationEvent'Event = NodeComputationEvent'BeginComputation !NodeComputationBeginEvent
                                | NodeComputationEvent'EndComputation !NodeComputationEndEvent
                                    deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f NodeComputationEvent x a,
          a ~ b) =>
         Lens.Labels.HasLens f NodeComputationEvent NodeComputationEvent x a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeComputationEvent "localPath"
           (Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'localPath
                 (\ x__ y__ -> x__{_NodeComputationEvent'localPath = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeComputationEvent "maybe'localPath"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'localPath
                 (\ x__ y__ -> x__{_NodeComputationEvent'localPath = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeComputationEvent "timestamp"
           (Data.Int.Int64)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'timestamp
                 (\ x__ y__ -> x__{_NodeComputationEvent'timestamp = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeComputationEvent "maybe'event"
           (Prelude.Maybe NodeComputationEvent'Event)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'event
                 (\ x__ y__ -> x__{_NodeComputationEvent'event = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeComputationEvent
           "maybe'beginComputation"
           (Prelude.Maybe NodeComputationBeginEvent)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'event
                 (\ x__ y__ -> x__{_NodeComputationEvent'event = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just
                          (NodeComputationEvent'BeginComputation x__val) -> Prelude.Just
                                                                              x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ ->
                    Prelude.fmap NodeComputationEvent'BeginComputation y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeComputationEvent "beginComputation"
           (NodeComputationBeginEvent)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'event
                 (\ x__ y__ -> x__{_NodeComputationEvent'event = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just
                             (NodeComputationEvent'BeginComputation x__val) -> Prelude.Just
                                                                                 x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ ->
                       Prelude.fmap NodeComputationEvent'BeginComputation y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeComputationEvent "maybe'endComputation"
           (Prelude.Maybe NodeComputationEndEvent)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'event
                 (\ x__ y__ -> x__{_NodeComputationEvent'event = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just
                          (NodeComputationEvent'EndComputation x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap NodeComputationEvent'EndComputation y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeComputationEvent "endComputation"
           (NodeComputationEndEvent)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'event
                 (\ x__ y__ -> x__{_NodeComputationEvent'event = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just
                             (NodeComputationEvent'EndComputation x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap NodeComputationEvent'EndComputation y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))
instance Data.Default.Class.Default NodeComputationEvent where
        def
          = NodeComputationEvent{_NodeComputationEvent'localPath =
                                   Prelude.Nothing,
                                 _NodeComputationEvent'timestamp = Data.ProtoLens.fieldDefault,
                                 _NodeComputationEvent'event = Prelude.Nothing,
                                 _NodeComputationEvent'_unknownFields = ([])}
instance Data.ProtoLens.Message NodeComputationEvent where
        messageName _ = Data.Text.pack "karps.core.NodeComputationEvent"
        fieldsByTag
          = let localPath__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "local_path"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'localPath")))
                      :: Data.ProtoLens.FieldDescriptor NodeComputationEvent
                timestamp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "timestamp"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "timestamp")))
                      :: Data.ProtoLens.FieldDescriptor NodeComputationEvent
                beginComputation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "begin_computation"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor NodeComputationBeginEvent)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'beginComputation")))
                      :: Data.ProtoLens.FieldDescriptor NodeComputationEvent
                endComputation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "end_computation"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor NodeComputationEndEvent)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'endComputation")))
                      :: Data.ProtoLens.FieldDescriptor NodeComputationEvent
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, localPath__field_descriptor),
                 (Data.ProtoLens.Tag 2, timestamp__field_descriptor),
                 (Data.ProtoLens.Tag 3, beginComputation__field_descriptor),
                 (Data.ProtoLens.Tag 4, endComputation__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _NodeComputationEvent'_unknownFields
              (\ x__ y__ -> x__{_NodeComputationEvent'_unknownFields = y__})
_NodeComputationEvent'BeginComputation ::
                                       Lens.Labels.Prism.Prism' NodeComputationEvent'Event
                                         NodeComputationBeginEvent
_NodeComputationEvent'BeginComputation
  = Lens.Labels.Prism.prism' NodeComputationEvent'BeginComputation
      (\ p__ ->
         case p__ of
             NodeComputationEvent'BeginComputation p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_NodeComputationEvent'EndComputation ::
                                     Lens.Labels.Prism.Prism' NodeComputationEvent'Event
                                       NodeComputationEndEvent
_NodeComputationEvent'EndComputation
  = Lens.Labels.Prism.prism' NodeComputationEvent'EndComputation
      (\ p__ ->
         case p__ of
             NodeComputationEvent'EndComputation p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)