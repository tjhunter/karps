{- This file was auto-generated from karps/proto/profiling.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Karps.Proto.Profiling where
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
import qualified Proto.Karps.Proto.Graph

data ChromeTraceEvent = ChromeTraceEvent{_ChromeTraceEvent'name ::
                                         !Data.Text.Text,
                                         _ChromeTraceEvent'ph :: !Data.Text.Text,
                                         _ChromeTraceEvent'ts :: !Data.Int.Int64,
                                         _ChromeTraceEvent'pid :: !Data.Text.Text,
                                         _ChromeTraceEvent'tid :: !Data.Text.Text}
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "name" f ChromeTraceEvent ChromeTraceEvent a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ChromeTraceEvent'name
                 (\ x__ y__ -> x__{_ChromeTraceEvent'name = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "ph" f ChromeTraceEvent ChromeTraceEvent a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ChromeTraceEvent'ph
                 (\ x__ y__ -> x__{_ChromeTraceEvent'ph = y__}))
              Prelude.id

instance (a ~ Data.Int.Int64, b ~ Data.Int.Int64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "ts" f ChromeTraceEvent ChromeTraceEvent a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ChromeTraceEvent'ts
                 (\ x__ y__ -> x__{_ChromeTraceEvent'ts = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "pid" f ChromeTraceEvent ChromeTraceEvent a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ChromeTraceEvent'pid
                 (\ x__ y__ -> x__{_ChromeTraceEvent'pid = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "tid" f ChromeTraceEvent ChromeTraceEvent a b
         where
        lensOf _
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
                             _ChromeTraceEvent'tid = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ChromeTraceEvent where
        descriptor
          = let name__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "name"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional name)
                      :: Data.ProtoLens.FieldDescriptor ChromeTraceEvent
                ph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "ph"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional ph)
                      :: Data.ProtoLens.FieldDescriptor ChromeTraceEvent
                ts__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "ts"
                      (Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional ts)
                      :: Data.ProtoLens.FieldDescriptor ChromeTraceEvent
                pid__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "pid"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional pid)
                      :: Data.ProtoLens.FieldDescriptor ChromeTraceEvent
                tid__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "tid"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional tid)
                      :: Data.ProtoLens.FieldDescriptor ChromeTraceEvent
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ChromeTraceEvent")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, name__field_descriptor),
                    (Data.ProtoLens.Tag 2, ph__field_descriptor),
                    (Data.ProtoLens.Tag 3, ts__field_descriptor),
                    (Data.ProtoLens.Tag 4, pid__field_descriptor),
                    (Data.ProtoLens.Tag 5, tid__field_descriptor)])
                (Data.Map.fromList
                   [("name", name__field_descriptor), ("ph", ph__field_descriptor),
                    ("ts", ts__field_descriptor), ("pid", pid__field_descriptor),
                    ("tid", tid__field_descriptor)])

data ComputationTrace = ComputationTrace{_ComputationTrace'chromeEvents
                                         :: ![ChromeTraceEvent],
                                         _ComputationTrace'computationEvents ::
                                         ![NodeComputationEvent]}
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [ChromeTraceEvent], b ~ [ChromeTraceEvent],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "chromeEvents" f ComputationTrace
         ComputationTrace a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationTrace'chromeEvents
                 (\ x__ y__ -> x__{_ComputationTrace'chromeEvents = y__}))
              Prelude.id

instance (a ~ [NodeComputationEvent], b ~ [NodeComputationEvent],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "computationEvents" f ComputationTrace
         ComputationTrace a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationTrace'computationEvents
                 (\ x__ y__ -> x__{_ComputationTrace'computationEvents = y__}))
              Prelude.id

instance Data.Default.Class.Default ComputationTrace where
        def
          = ComputationTrace{_ComputationTrace'chromeEvents = [],
                             _ComputationTrace'computationEvents = []}

instance Data.ProtoLens.Message ComputationTrace where
        descriptor
          = let chromeEvents__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "chrome_events"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ChromeTraceEvent)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked chromeEvents)
                      :: Data.ProtoLens.FieldDescriptor ComputationTrace
                computationEvents__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation_events"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor NodeComputationEvent)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         computationEvents)
                      :: Data.ProtoLens.FieldDescriptor ComputationTrace
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ComputationTrace")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, chromeEvents__field_descriptor),
                    (Data.ProtoLens.Tag 2, computationEvents__field_descriptor)])
                (Data.Map.fromList
                   [("chrome_events", chromeEvents__field_descriptor),
                    ("computation_events", computationEvents__field_descriptor)])

data NodeComputationBeginEvent = NodeComputationBeginEvent{}
                               deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance Data.Default.Class.Default NodeComputationBeginEvent where
        def = NodeComputationBeginEvent{}

instance Data.ProtoLens.Message NodeComputationBeginEvent where
        descriptor
          = let in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.NodeComputationBeginEvent")
                (Data.Map.fromList [])
                (Data.Map.fromList [])

data NodeComputationEndEvent = NodeComputationEndEvent{}
                             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance Data.Default.Class.Default NodeComputationEndEvent where
        def = NodeComputationEndEvent{}

instance Data.ProtoLens.Message NodeComputationEndEvent where
        descriptor
          = let in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.NodeComputationEndEvent")
                (Data.Map.fromList [])
                (Data.Map.fromList [])

data NodeComputationEvent = NodeComputationEvent{_NodeComputationEvent'localPath
                                                 :: !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                                                 _NodeComputationEvent'timestamp :: !Data.Int.Int64,
                                                 _NodeComputationEvent'event ::
                                                 !(Prelude.Maybe NodeComputationEvent'Event)}
                          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

data NodeComputationEvent'Event = NodeComputationEvent'BeginComputation !NodeComputationBeginEvent
                                | NodeComputationEvent'EndComputation !NodeComputationEndEvent
                                deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Graph.Path,
          b ~ Proto.Karps.Proto.Graph.Path, Prelude.Functor f) =>
         Lens.Labels.HasLens "localPath" f NodeComputationEvent
         NodeComputationEvent a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'localPath
                 (\ x__ y__ -> x__{_NodeComputationEvent'localPath = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'localPath" f NodeComputationEvent
         NodeComputationEvent a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'localPath
                 (\ x__ y__ -> x__{_NodeComputationEvent'localPath = y__}))
              Prelude.id

instance (a ~ Data.Int.Int64, b ~ Data.Int.Int64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "timestamp" f NodeComputationEvent
         NodeComputationEvent a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'timestamp
                 (\ x__ y__ -> x__{_NodeComputationEvent'timestamp = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe NodeComputationEvent'Event,
          b ~ Prelude.Maybe NodeComputationEvent'Event, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'event" f NodeComputationEvent
         NodeComputationEvent a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeComputationEvent'event
                 (\ x__ y__ -> x__{_NodeComputationEvent'event = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe NodeComputationBeginEvent,
          b ~ Prelude.Maybe NodeComputationBeginEvent, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'beginComputation" f NodeComputationEvent
         NodeComputationEvent a b where
        lensOf _
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

instance (a ~ NodeComputationBeginEvent,
          b ~ NodeComputationBeginEvent, Prelude.Functor f) =>
         Lens.Labels.HasLens "beginComputation" f NodeComputationEvent
         NodeComputationEvent a b where
        lensOf _
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

instance (a ~ Prelude.Maybe NodeComputationEndEvent,
          b ~ Prelude.Maybe NodeComputationEndEvent, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'endComputation" f NodeComputationEvent
         NodeComputationEvent a b where
        lensOf _
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

instance (a ~ NodeComputationEndEvent, b ~ NodeComputationEndEvent,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "endComputation" f NodeComputationEvent
         NodeComputationEvent a b where
        lensOf _
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
                                 _NodeComputationEvent'event = Prelude.Nothing}

instance Data.ProtoLens.Message NodeComputationEvent where
        descriptor
          = let localPath__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "local_path"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField maybe'localPath)
                      :: Data.ProtoLens.FieldDescriptor NodeComputationEvent
                timestamp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "timestamp"
                      (Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional timestamp)
                      :: Data.ProtoLens.FieldDescriptor NodeComputationEvent
                beginComputation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "begin_computation"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor NodeComputationBeginEvent)
                      (Data.ProtoLens.OptionalField maybe'beginComputation)
                      :: Data.ProtoLens.FieldDescriptor NodeComputationEvent
                endComputation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "end_computation"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor NodeComputationEndEvent)
                      (Data.ProtoLens.OptionalField maybe'endComputation)
                      :: Data.ProtoLens.FieldDescriptor NodeComputationEvent
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.NodeComputationEvent")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, localPath__field_descriptor),
                    (Data.ProtoLens.Tag 2, timestamp__field_descriptor),
                    (Data.ProtoLens.Tag 3, beginComputation__field_descriptor),
                    (Data.ProtoLens.Tag 4, endComputation__field_descriptor)])
                (Data.Map.fromList
                   [("local_path", localPath__field_descriptor),
                    ("timestamp", timestamp__field_descriptor),
                    ("begin_computation", beginComputation__field_descriptor),
                    ("end_computation", endComputation__field_descriptor)])

beginComputation ::
                 forall f s t a b .
                   Lens.Labels.HasLens "beginComputation" f s t a b =>
                   Lens.Family2.LensLike f s t a b
beginComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "beginComputation")

chromeEvents ::
             forall f s t a b . Lens.Labels.HasLens "chromeEvents" f s t a b =>
               Lens.Family2.LensLike f s t a b
chromeEvents
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "chromeEvents")

computationEvents ::
                  forall f s t a b .
                    Lens.Labels.HasLens "computationEvents" f s t a b =>
                    Lens.Family2.LensLike f s t a b
computationEvents
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "computationEvents")

endComputation ::
               forall f s t a b .
                 Lens.Labels.HasLens "endComputation" f s t a b =>
                 Lens.Family2.LensLike f s t a b
endComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "endComputation")

localPath ::
          forall f s t a b . Lens.Labels.HasLens "localPath" f s t a b =>
            Lens.Family2.LensLike f s t a b
localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "localPath")

maybe'beginComputation ::
                       forall f s t a b .
                         Lens.Labels.HasLens "maybe'beginComputation" f s t a b =>
                         Lens.Family2.LensLike f s t a b
maybe'beginComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'beginComputation")

maybe'endComputation ::
                     forall f s t a b .
                       Lens.Labels.HasLens "maybe'endComputation" f s t a b =>
                       Lens.Family2.LensLike f s t a b
maybe'endComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'endComputation")

maybe'event ::
            forall f s t a b . Lens.Labels.HasLens "maybe'event" f s t a b =>
              Lens.Family2.LensLike f s t a b
maybe'event
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'event")

maybe'localPath ::
                forall f s t a b .
                  Lens.Labels.HasLens "maybe'localPath" f s t a b =>
                  Lens.Family2.LensLike f s t a b
maybe'localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'localPath")

name ::
     forall f s t a b . Lens.Labels.HasLens "name" f s t a b =>
       Lens.Family2.LensLike f s t a b
name
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "name")

ph ::
   forall f s t a b . Lens.Labels.HasLens "ph" f s t a b =>
     Lens.Family2.LensLike f s t a b
ph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "ph")

pid ::
    forall f s t a b . Lens.Labels.HasLens "pid" f s t a b =>
      Lens.Family2.LensLike f s t a b
pid
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "pid")

tid ::
    forall f s t a b . Lens.Labels.HasLens "tid" f s t a b =>
      Lens.Family2.LensLike f s t a b
tid
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "tid")

timestamp ::
          forall f s t a b . Lens.Labels.HasLens "timestamp" f s t a b =>
            Lens.Family2.LensLike f s t a b
timestamp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "timestamp")

ts ::
   forall f s t a b . Lens.Labels.HasLens "ts" f s t a b =>
     Lens.Family2.LensLike f s t a b
ts
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "ts")