{- This file was auto-generated from karps/proto/computation.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Karps.Proto.Computation where
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
import qualified Proto.Karps.Proto.Row

data BatchComputationResult = BatchComputationResult{_BatchComputationResult'targetPath
                                                     ::
                                                     !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                                                     _BatchComputationResult'results ::
                                                     ![ComputationResult]}
                            deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Graph.Path,
          b ~ Proto.Karps.Proto.Graph.Path, Prelude.Functor f) =>
         Lens.Labels.HasLens "targetPath" f BatchComputationResult
         BatchComputationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _BatchComputationResult'targetPath
                 (\ x__ y__ -> x__{_BatchComputationResult'targetPath = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'targetPath" f BatchComputationResult
         BatchComputationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _BatchComputationResult'targetPath
                 (\ x__ y__ -> x__{_BatchComputationResult'targetPath = y__}))
              Prelude.id

instance (a ~ [ComputationResult], b ~ [ComputationResult],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "results" f BatchComputationResult
         BatchComputationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _BatchComputationResult'results
                 (\ x__ y__ -> x__{_BatchComputationResult'results = y__}))
              Prelude.id

instance Data.Default.Class.Default BatchComputationResult where
        def
          = BatchComputationResult{_BatchComputationResult'targetPath =
                                     Prelude.Nothing,
                                   _BatchComputationResult'results = []}

instance Data.ProtoLens.Message BatchComputationResult where
        descriptor
          = let targetPath__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "target_path"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField maybe'targetPath)
                      :: Data.ProtoLens.FieldDescriptor BatchComputationResult
                results__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "results"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ComputationResult)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked results)
                      :: Data.ProtoLens.FieldDescriptor BatchComputationResult
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.BatchComputationResult")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, targetPath__field_descriptor),
                    (Data.ProtoLens.Tag 2, results__field_descriptor)])
                (Data.Map.fromList
                   [("target_path", targetPath__field_descriptor),
                    ("results", results__field_descriptor)])

data ComputationId = ComputationId{_ComputationId'id ::
                                   !Data.Text.Text}
                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "id" f ComputationId ComputationId a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationId'id
                 (\ x__ y__ -> x__{_ComputationId'id = y__}))
              Prelude.id

instance Data.Default.Class.Default ComputationId where
        def
          = ComputationId{_ComputationId'id = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ComputationId where
        descriptor
          = let id__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "id"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional id)
                      :: Data.ProtoLens.FieldDescriptor ComputationId
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ComputationId")
                (Data.Map.fromList [(Data.ProtoLens.Tag 1, id__field_descriptor)])
                (Data.Map.fromList [("id", id__field_descriptor)])

data ComputationResult = ComputationResult{_ComputationResult'localPath
                                           :: !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                                           _ComputationResult'status :: !ResultStatus,
                                           _ComputationResult'finalError :: !Data.Text.Text,
                                           _ComputationResult'finalResult ::
                                           !(Prelude.Maybe Proto.Karps.Proto.Row.CellWithType),
                                           _ComputationResult'sparkStats ::
                                           !(Prelude.Maybe SparkStats),
                                           _ComputationResult'dependencies ::
                                           ![Proto.Karps.Proto.Graph.Path]}
                       deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Graph.Path,
          b ~ Proto.Karps.Proto.Graph.Path, Prelude.Functor f) =>
         Lens.Labels.HasLens "localPath" f ComputationResult
         ComputationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'localPath
                 (\ x__ y__ -> x__{_ComputationResult'localPath = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'localPath" f ComputationResult
         ComputationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'localPath
                 (\ x__ y__ -> x__{_ComputationResult'localPath = y__}))
              Prelude.id

instance (a ~ ResultStatus, b ~ ResultStatus, Prelude.Functor f) =>
         Lens.Labels.HasLens "status" f ComputationResult ComputationResult
         a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'status
                 (\ x__ y__ -> x__{_ComputationResult'status = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "finalError" f ComputationResult
         ComputationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'finalError
                 (\ x__ y__ -> x__{_ComputationResult'finalError = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Row.CellWithType,
          b ~ Proto.Karps.Proto.Row.CellWithType, Prelude.Functor f) =>
         Lens.Labels.HasLens "finalResult" f ComputationResult
         ComputationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'finalResult
                 (\ x__ y__ -> x__{_ComputationResult'finalResult = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Row.CellWithType,
          b ~ Prelude.Maybe Proto.Karps.Proto.Row.CellWithType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'finalResult" f ComputationResult
         ComputationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'finalResult
                 (\ x__ y__ -> x__{_ComputationResult'finalResult = y__}))
              Prelude.id

instance (a ~ SparkStats, b ~ SparkStats, Prelude.Functor f) =>
         Lens.Labels.HasLens "sparkStats" f ComputationResult
         ComputationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'sparkStats
                 (\ x__ y__ -> x__{_ComputationResult'sparkStats = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe SparkStats,
          b ~ Prelude.Maybe SparkStats, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'sparkStats" f ComputationResult
         ComputationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'sparkStats
                 (\ x__ y__ -> x__{_ComputationResult'sparkStats = y__}))
              Prelude.id

instance (a ~ [Proto.Karps.Proto.Graph.Path],
          b ~ [Proto.Karps.Proto.Graph.Path], Prelude.Functor f) =>
         Lens.Labels.HasLens "dependencies" f ComputationResult
         ComputationResult a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'dependencies
                 (\ x__ y__ -> x__{_ComputationResult'dependencies = y__}))
              Prelude.id

instance Data.Default.Class.Default ComputationResult where
        def
          = ComputationResult{_ComputationResult'localPath = Prelude.Nothing,
                              _ComputationResult'status = Data.Default.Class.def,
                              _ComputationResult'finalError = Data.ProtoLens.fieldDefault,
                              _ComputationResult'finalResult = Prelude.Nothing,
                              _ComputationResult'sparkStats = Prelude.Nothing,
                              _ComputationResult'dependencies = []}

instance Data.ProtoLens.Message ComputationResult where
        descriptor
          = let localPath__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "local_path"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField maybe'localPath)
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
                status__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "status"
                      (Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor ResultStatus)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional status)
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
                finalError__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "final_error"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional finalError)
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
                finalResult__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "final_result"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Row.CellWithType)
                      (Data.ProtoLens.OptionalField maybe'finalResult)
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
                sparkStats__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "spark_stats"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor SparkStats)
                      (Data.ProtoLens.OptionalField maybe'sparkStats)
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
                dependencies__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "dependencies"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked dependencies)
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ComputationResult")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, localPath__field_descriptor),
                    (Data.ProtoLens.Tag 2, status__field_descriptor),
                    (Data.ProtoLens.Tag 3, finalError__field_descriptor),
                    (Data.ProtoLens.Tag 4, finalResult__field_descriptor),
                    (Data.ProtoLens.Tag 5, sparkStats__field_descriptor),
                    (Data.ProtoLens.Tag 6, dependencies__field_descriptor)])
                (Data.Map.fromList
                   [("local_path", localPath__field_descriptor),
                    ("status", status__field_descriptor),
                    ("final_error", finalError__field_descriptor),
                    ("final_result", finalResult__field_descriptor),
                    ("spark_stats", sparkStats__field_descriptor),
                    ("dependencies", dependencies__field_descriptor)])

data PointerPath = PointerPath{_PointerPath'computation ::
                               !(Prelude.Maybe ComputationId),
                               _PointerPath'localPath ::
                               !(Prelude.Maybe Proto.Karps.Proto.Graph.Path)}
                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ ComputationId, b ~ ComputationId,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "computation" f PointerPath PointerPath a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PointerPath'computation
                 (\ x__ y__ -> x__{_PointerPath'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ComputationId,
          b ~ Prelude.Maybe ComputationId, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'computation" f PointerPath PointerPath a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PointerPath'computation
                 (\ x__ y__ -> x__{_PointerPath'computation = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Graph.Path,
          b ~ Proto.Karps.Proto.Graph.Path, Prelude.Functor f) =>
         Lens.Labels.HasLens "localPath" f PointerPath PointerPath a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PointerPath'localPath
                 (\ x__ y__ -> x__{_PointerPath'localPath = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          b ~ Prelude.Maybe Proto.Karps.Proto.Graph.Path,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'localPath" f PointerPath PointerPath a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PointerPath'localPath
                 (\ x__ y__ -> x__{_PointerPath'localPath = y__}))
              Prelude.id

instance Data.Default.Class.Default PointerPath where
        def
          = PointerPath{_PointerPath'computation = Prelude.Nothing,
                        _PointerPath'localPath = Prelude.Nothing}

instance Data.ProtoLens.Message PointerPath where
        descriptor
          = let computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ComputationId)
                      (Data.ProtoLens.OptionalField maybe'computation)
                      :: Data.ProtoLens.FieldDescriptor PointerPath
                localPath__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "local_path"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField maybe'localPath)
                      :: Data.ProtoLens.FieldDescriptor PointerPath
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.PointerPath")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, computation__field_descriptor),
                    (Data.ProtoLens.Tag 2, localPath__field_descriptor)])
                (Data.Map.fromList
                   [("computation", computation__field_descriptor),
                    ("local_path", localPath__field_descriptor)])

data RDDInfo = RDDInfo{_RDDInfo'rddId :: !Data.Int.Int64,
                       _RDDInfo'className :: !Data.Text.Text,
                       _RDDInfo'repr :: !Data.Text.Text,
                       _RDDInfo'parents :: ![Data.Int.Int64]}
             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Int.Int64, b ~ Data.Int.Int64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "rddId" f RDDInfo RDDInfo a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _RDDInfo'rddId
                 (\ x__ y__ -> x__{_RDDInfo'rddId = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "className" f RDDInfo RDDInfo a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _RDDInfo'className
                 (\ x__ y__ -> x__{_RDDInfo'className = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "repr" f RDDInfo RDDInfo a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _RDDInfo'repr
                 (\ x__ y__ -> x__{_RDDInfo'repr = y__}))
              Prelude.id

instance (a ~ [Data.Int.Int64], b ~ [Data.Int.Int64],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "parents" f RDDInfo RDDInfo a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _RDDInfo'parents
                 (\ x__ y__ -> x__{_RDDInfo'parents = y__}))
              Prelude.id

instance Data.Default.Class.Default RDDInfo where
        def
          = RDDInfo{_RDDInfo'rddId = Data.ProtoLens.fieldDefault,
                    _RDDInfo'className = Data.ProtoLens.fieldDefault,
                    _RDDInfo'repr = Data.ProtoLens.fieldDefault, _RDDInfo'parents = []}

instance Data.ProtoLens.Message RDDInfo where
        descriptor
          = let rddId__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "rdd_id"
                      (Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional rddId)
                      :: Data.ProtoLens.FieldDescriptor RDDInfo
                className__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "class_name"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional className)
                      :: Data.ProtoLens.FieldDescriptor RDDInfo
                repr__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "repr"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional repr)
                      :: Data.ProtoLens.FieldDescriptor RDDInfo
                parents__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "parents"
                      (Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Packed parents)
                      :: Data.ProtoLens.FieldDescriptor RDDInfo
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.RDDInfo")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, rddId__field_descriptor),
                    (Data.ProtoLens.Tag 2, className__field_descriptor),
                    (Data.ProtoLens.Tag 3, repr__field_descriptor),
                    (Data.ProtoLens.Tag 4, parents__field_descriptor)])
                (Data.Map.fromList
                   [("rdd_id", rddId__field_descriptor),
                    ("class_name", className__field_descriptor),
                    ("repr", repr__field_descriptor),
                    ("parents", parents__field_descriptor)])

data ResultStatus = UNUSED
                  | RUNNING
                  | FINISHED_SUCCESS
                  | FINISHED_FAILURE
                  | SCHEDULED
                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance Data.Default.Class.Default ResultStatus where
        def = UNUSED

instance Data.ProtoLens.FieldDefault ResultStatus where
        fieldDefault = UNUSED

instance Data.ProtoLens.MessageEnum ResultStatus where
        maybeToEnum 0 = Prelude.Just UNUSED
        maybeToEnum 1 = Prelude.Just RUNNING
        maybeToEnum 2 = Prelude.Just FINISHED_SUCCESS
        maybeToEnum 3 = Prelude.Just FINISHED_FAILURE
        maybeToEnum 4 = Prelude.Just SCHEDULED
        maybeToEnum _ = Prelude.Nothing
        showEnum UNUSED = "UNUSED"
        showEnum RUNNING = "RUNNING"
        showEnum FINISHED_SUCCESS = "FINISHED_SUCCESS"
        showEnum FINISHED_FAILURE = "FINISHED_FAILURE"
        showEnum SCHEDULED = "SCHEDULED"
        readEnum "UNUSED" = Prelude.Just UNUSED
        readEnum "RUNNING" = Prelude.Just RUNNING
        readEnum "FINISHED_SUCCESS" = Prelude.Just FINISHED_SUCCESS
        readEnum "FINISHED_FAILURE" = Prelude.Just FINISHED_FAILURE
        readEnum "SCHEDULED" = Prelude.Just SCHEDULED
        readEnum _ = Prelude.Nothing

instance Prelude.Enum ResultStatus where
        toEnum k__
          = Prelude.maybe
              (Prelude.error
                 ((Prelude.++) "toEnum: unknown value for enum ResultStatus: "
                    (Prelude.show k__)))
              Prelude.id
              (Data.ProtoLens.maybeToEnum k__)
        fromEnum UNUSED = 0
        fromEnum RUNNING = 1
        fromEnum FINISHED_SUCCESS = 2
        fromEnum FINISHED_FAILURE = 3
        fromEnum SCHEDULED = 4
        succ SCHEDULED
          = Prelude.error
              "ResultStatus.succ: bad argument SCHEDULED. This value would be out of bounds."
        succ UNUSED = RUNNING
        succ RUNNING = FINISHED_SUCCESS
        succ FINISHED_SUCCESS = FINISHED_FAILURE
        succ FINISHED_FAILURE = SCHEDULED
        pred UNUSED
          = Prelude.error
              "ResultStatus.pred: bad argument UNUSED. This value would be out of bounds."
        pred RUNNING = UNUSED
        pred FINISHED_SUCCESS = RUNNING
        pred FINISHED_FAILURE = FINISHED_SUCCESS
        pred SCHEDULED = FINISHED_FAILURE
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo

instance Prelude.Bounded ResultStatus where
        minBound = UNUSED
        maxBound = SCHEDULED

data SessionId = SessionId{_SessionId'id :: !Data.Text.Text}
               deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "id" f SessionId SessionId a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SessionId'id
                 (\ x__ y__ -> x__{_SessionId'id = y__}))
              Prelude.id

instance Data.Default.Class.Default SessionId where
        def = SessionId{_SessionId'id = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message SessionId where
        descriptor
          = let id__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "id"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional id)
                      :: Data.ProtoLens.FieldDescriptor SessionId
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.SessionId")
                (Data.Map.fromList [(Data.ProtoLens.Tag 1, id__field_descriptor)])
                (Data.Map.fromList [("id", id__field_descriptor)])

data SparkStats = SparkStats{_SparkStats'rddInfo :: ![RDDInfo]}
                deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [RDDInfo], b ~ [RDDInfo], Prelude.Functor f) =>
         Lens.Labels.HasLens "rddInfo" f SparkStats SparkStats a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkStats'rddInfo
                 (\ x__ y__ -> x__{_SparkStats'rddInfo = y__}))
              Prelude.id

instance Data.Default.Class.Default SparkStats where
        def = SparkStats{_SparkStats'rddInfo = []}

instance Data.ProtoLens.Message SparkStats where
        descriptor
          = let rddInfo__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "rdd_info"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RDDInfo)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked rddInfo)
                      :: Data.ProtoLens.FieldDescriptor SparkStats
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.SparkStats")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, rddInfo__field_descriptor)])
                (Data.Map.fromList [("rdd_info", rddInfo__field_descriptor)])

className ::
          forall f s t a b . Lens.Labels.HasLens "className" f s t a b =>
            Lens.Family2.LensLike f s t a b
className
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "className")

computation ::
            forall f s t a b . Lens.Labels.HasLens "computation" f s t a b =>
              Lens.Family2.LensLike f s t a b
computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "computation")

dependencies ::
             forall f s t a b . Lens.Labels.HasLens "dependencies" f s t a b =>
               Lens.Family2.LensLike f s t a b
dependencies
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "dependencies")

finalError ::
           forall f s t a b . Lens.Labels.HasLens "finalError" f s t a b =>
             Lens.Family2.LensLike f s t a b
finalError
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "finalError")

finalResult ::
            forall f s t a b . Lens.Labels.HasLens "finalResult" f s t a b =>
              Lens.Family2.LensLike f s t a b
finalResult
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "finalResult")

id ::
   forall f s t a b . Lens.Labels.HasLens "id" f s t a b =>
     Lens.Family2.LensLike f s t a b
id
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "id")

localPath ::
          forall f s t a b . Lens.Labels.HasLens "localPath" f s t a b =>
            Lens.Family2.LensLike f s t a b
localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "localPath")

maybe'computation ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'computation" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'computation")

maybe'finalResult ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'finalResult" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'finalResult
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'finalResult")

maybe'localPath ::
                forall f s t a b .
                  Lens.Labels.HasLens "maybe'localPath" f s t a b =>
                  Lens.Family2.LensLike f s t a b
maybe'localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'localPath")

maybe'sparkStats ::
                 forall f s t a b .
                   Lens.Labels.HasLens "maybe'sparkStats" f s t a b =>
                   Lens.Family2.LensLike f s t a b
maybe'sparkStats
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'sparkStats")

maybe'targetPath ::
                 forall f s t a b .
                   Lens.Labels.HasLens "maybe'targetPath" f s t a b =>
                   Lens.Family2.LensLike f s t a b
maybe'targetPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'targetPath")

parents ::
        forall f s t a b . Lens.Labels.HasLens "parents" f s t a b =>
          Lens.Family2.LensLike f s t a b
parents
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parents")

rddId ::
      forall f s t a b . Lens.Labels.HasLens "rddId" f s t a b =>
        Lens.Family2.LensLike f s t a b
rddId
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "rddId")

rddInfo ::
        forall f s t a b . Lens.Labels.HasLens "rddInfo" f s t a b =>
          Lens.Family2.LensLike f s t a b
rddInfo
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "rddInfo")

repr ::
     forall f s t a b . Lens.Labels.HasLens "repr" f s t a b =>
       Lens.Family2.LensLike f s t a b
repr
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "repr")

results ::
        forall f s t a b . Lens.Labels.HasLens "results" f s t a b =>
          Lens.Family2.LensLike f s t a b
results
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "results")

sparkStats ::
           forall f s t a b . Lens.Labels.HasLens "sparkStats" f s t a b =>
             Lens.Family2.LensLike f s t a b
sparkStats
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "sparkStats")

status ::
       forall f s t a b . Lens.Labels.HasLens "status" f s t a b =>
         Lens.Family2.LensLike f s t a b
status
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "status")

targetPath ::
           forall f s t a b . Lens.Labels.HasLens "targetPath" f s t a b =>
             Lens.Family2.LensLike f s t a b
targetPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "targetPath")