{- This file was auto-generated from karps/proto/computation.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Computation
       (BatchComputationResult(..), ComputationId(..),
        ComputationResult(..), PointerPath(..), RDDInfo(..),
        ResultStatus(..), ResultStatus(), ResultStatus'UnrecognizedValue,
        SQLTreeInfo(..), SessionId(..), SparkStats(..))
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
import qualified Proto.Karps.Proto.Row
import qualified Proto.Tensorflow.Core.Framework.NodeDef

{- | Fields :

    * 'Proto.Karps.Proto.Computation_Fields.targetPath' @:: Lens' BatchComputationResult Proto.Karps.Proto.Graph.Path@
    * 'Proto.Karps.Proto.Computation_Fields.maybe'targetPath' @:: Lens' BatchComputationResult
  (Prelude.Maybe Proto.Karps.Proto.Graph.Path)@
    * 'Proto.Karps.Proto.Computation_Fields.results' @:: Lens' BatchComputationResult [ComputationResult]@
 -}
data BatchComputationResult = BatchComputationResult{_BatchComputationResult'targetPath
                                                     ::
                                                     !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                                                     _BatchComputationResult'results ::
                                                     ![ComputationResult],
                                                     _BatchComputationResult'_unknownFields ::
                                                     !Data.ProtoLens.FieldSet}
                                deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f BatchComputationResult x a,
          a ~ b) =>
         Lens.Labels.HasLens f BatchComputationResult BatchComputationResult
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f BatchComputationResult "targetPath"
           (Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _BatchComputationResult'targetPath
                 (\ x__ y__ -> x__{_BatchComputationResult'targetPath = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f BatchComputationResult "maybe'targetPath"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _BatchComputationResult'targetPath
                 (\ x__ y__ -> x__{_BatchComputationResult'targetPath = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f BatchComputationResult "results"
           ([ComputationResult])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _BatchComputationResult'results
                 (\ x__ y__ -> x__{_BatchComputationResult'results = y__}))
              Prelude.id
instance Data.Default.Class.Default BatchComputationResult where
        def
          = BatchComputationResult{_BatchComputationResult'targetPath =
                                     Prelude.Nothing,
                                   _BatchComputationResult'results = [],
                                   _BatchComputationResult'_unknownFields = ([])}
instance Data.ProtoLens.Message BatchComputationResult where
        messageName _ = Data.Text.pack "karps.core.BatchComputationResult"
        fieldsByTag
          = let targetPath__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "target_path"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'targetPath")))
                      :: Data.ProtoLens.FieldDescriptor BatchComputationResult
                results__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "results"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ComputationResult)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "results")))
                      :: Data.ProtoLens.FieldDescriptor BatchComputationResult
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, targetPath__field_descriptor),
                 (Data.ProtoLens.Tag 2, results__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _BatchComputationResult'_unknownFields
              (\ x__ y__ -> x__{_BatchComputationResult'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Computation_Fields.id' @:: Lens' ComputationId Data.Text.Text@
 -}
data ComputationId = ComputationId{_ComputationId'id ::
                                   !Data.Text.Text,
                                   _ComputationId'_unknownFields :: !Data.ProtoLens.FieldSet}
                       deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ComputationId x a, a ~ b) =>
         Lens.Labels.HasLens f ComputationId ComputationId x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationId "id" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationId'id
                 (\ x__ y__ -> x__{_ComputationId'id = y__}))
              Prelude.id
instance Data.Default.Class.Default ComputationId where
        def
          = ComputationId{_ComputationId'id = Data.ProtoLens.fieldDefault,
                          _ComputationId'_unknownFields = ([])}
instance Data.ProtoLens.Message ComputationId where
        messageName _ = Data.Text.pack "karps.core.ComputationId"
        fieldsByTag
          = let id__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "id"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "id")))
                      :: Data.ProtoLens.FieldDescriptor ComputationId
              in Data.Map.fromList [(Data.ProtoLens.Tag 1, id__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ComputationId'_unknownFields
              (\ x__ y__ -> x__{_ComputationId'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Computation_Fields.localPath' @:: Lens' ComputationResult Proto.Karps.Proto.Graph.Path@
    * 'Proto.Karps.Proto.Computation_Fields.maybe'localPath' @:: Lens' ComputationResult
  (Prelude.Maybe Proto.Karps.Proto.Graph.Path)@
    * 'Proto.Karps.Proto.Computation_Fields.status' @:: Lens' ComputationResult ResultStatus@
    * 'Proto.Karps.Proto.Computation_Fields.finalError' @:: Lens' ComputationResult Data.Text.Text@
    * 'Proto.Karps.Proto.Computation_Fields.finalResult' @:: Lens' ComputationResult Proto.Karps.Proto.Row.CellWithType@
    * 'Proto.Karps.Proto.Computation_Fields.maybe'finalResult' @:: Lens' ComputationResult
  (Prelude.Maybe Proto.Karps.Proto.Row.CellWithType)@
    * 'Proto.Karps.Proto.Computation_Fields.sparkStats' @:: Lens' ComputationResult SparkStats@
    * 'Proto.Karps.Proto.Computation_Fields.maybe'sparkStats' @:: Lens' ComputationResult (Prelude.Maybe SparkStats)@
    * 'Proto.Karps.Proto.Computation_Fields.dependencies' @:: Lens' ComputationResult [Proto.Karps.Proto.Graph.Path]@
 -}
data ComputationResult = ComputationResult{_ComputationResult'localPath
                                           :: !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                                           _ComputationResult'status :: !ResultStatus,
                                           _ComputationResult'finalError :: !Data.Text.Text,
                                           _ComputationResult'finalResult ::
                                           !(Prelude.Maybe Proto.Karps.Proto.Row.CellWithType),
                                           _ComputationResult'sparkStats ::
                                           !(Prelude.Maybe SparkStats),
                                           _ComputationResult'dependencies ::
                                           ![Proto.Karps.Proto.Graph.Path],
                                           _ComputationResult'_unknownFields ::
                                           !Data.ProtoLens.FieldSet}
                           deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ComputationResult x a, a ~ b) =>
         Lens.Labels.HasLens f ComputationResult ComputationResult x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationResult "localPath"
           (Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'localPath
                 (\ x__ y__ -> x__{_ComputationResult'localPath = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationResult "maybe'localPath"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'localPath
                 (\ x__ y__ -> x__{_ComputationResult'localPath = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationResult "status" (ResultStatus)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'status
                 (\ x__ y__ -> x__{_ComputationResult'status = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationResult "finalError"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'finalError
                 (\ x__ y__ -> x__{_ComputationResult'finalError = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationResult "finalResult"
           (Proto.Karps.Proto.Row.CellWithType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'finalResult
                 (\ x__ y__ -> x__{_ComputationResult'finalResult = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationResult "maybe'finalResult"
           (Prelude.Maybe Proto.Karps.Proto.Row.CellWithType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'finalResult
                 (\ x__ y__ -> x__{_ComputationResult'finalResult = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationResult "sparkStats" (SparkStats)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'sparkStats
                 (\ x__ y__ -> x__{_ComputationResult'sparkStats = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationResult "maybe'sparkStats"
           (Prelude.Maybe SparkStats)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ComputationResult'sparkStats
                 (\ x__ y__ -> x__{_ComputationResult'sparkStats = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ComputationResult "dependencies"
           ([Proto.Karps.Proto.Graph.Path])
         where
        lensOf' _
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
                              _ComputationResult'dependencies = [],
                              _ComputationResult'_unknownFields = ([])}
instance Data.ProtoLens.Message ComputationResult where
        messageName _ = Data.Text.pack "karps.core.ComputationResult"
        fieldsByTag
          = let localPath__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "local_path"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'localPath")))
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
                status__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "status"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor ResultStatus)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "status")))
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
                finalError__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "final_error"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "finalError")))
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
                finalResult__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "final_result"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Row.CellWithType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'finalResult")))
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
                sparkStats__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "spark_stats"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SparkStats)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'sparkStats")))
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
                dependencies__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "dependencies"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "dependencies")))
                      :: Data.ProtoLens.FieldDescriptor ComputationResult
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, localPath__field_descriptor),
                 (Data.ProtoLens.Tag 2, status__field_descriptor),
                 (Data.ProtoLens.Tag 3, finalError__field_descriptor),
                 (Data.ProtoLens.Tag 4, finalResult__field_descriptor),
                 (Data.ProtoLens.Tag 5, sparkStats__field_descriptor),
                 (Data.ProtoLens.Tag 6, dependencies__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ComputationResult'_unknownFields
              (\ x__ y__ -> x__{_ComputationResult'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Computation_Fields.computation' @:: Lens' PointerPath ComputationId@
    * 'Proto.Karps.Proto.Computation_Fields.maybe'computation' @:: Lens' PointerPath (Prelude.Maybe ComputationId)@
    * 'Proto.Karps.Proto.Computation_Fields.localPath' @:: Lens' PointerPath Proto.Karps.Proto.Graph.Path@
    * 'Proto.Karps.Proto.Computation_Fields.maybe'localPath' @:: Lens' PointerPath (Prelude.Maybe Proto.Karps.Proto.Graph.Path)@
 -}
data PointerPath = PointerPath{_PointerPath'computation ::
                               !(Prelude.Maybe ComputationId),
                               _PointerPath'localPath ::
                               !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                               _PointerPath'_unknownFields :: !Data.ProtoLens.FieldSet}
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f PointerPath x a, a ~ b) =>
         Lens.Labels.HasLens f PointerPath PointerPath x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f PointerPath "computation" (ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PointerPath'computation
                 (\ x__ y__ -> x__{_PointerPath'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f PointerPath "maybe'computation"
           (Prelude.Maybe ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PointerPath'computation
                 (\ x__ y__ -> x__{_PointerPath'computation = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f PointerPath "localPath"
           (Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PointerPath'localPath
                 (\ x__ y__ -> x__{_PointerPath'localPath = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f PointerPath "maybe'localPath"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _PointerPath'localPath
                 (\ x__ y__ -> x__{_PointerPath'localPath = y__}))
              Prelude.id
instance Data.Default.Class.Default PointerPath where
        def
          = PointerPath{_PointerPath'computation = Prelude.Nothing,
                        _PointerPath'localPath = Prelude.Nothing,
                        _PointerPath'_unknownFields = ([])}
instance Data.ProtoLens.Message PointerPath where
        messageName _ = Data.Text.pack "karps.core.PointerPath"
        fieldsByTag
          = let computation__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "computation"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ComputationId)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'computation")))
                      :: Data.ProtoLens.FieldDescriptor PointerPath
                localPath__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "local_path"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'localPath")))
                      :: Data.ProtoLens.FieldDescriptor PointerPath
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, computation__field_descriptor),
                 (Data.ProtoLens.Tag 2, localPath__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _PointerPath'_unknownFields
              (\ x__ y__ -> x__{_PointerPath'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Computation_Fields.rddId' @:: Lens' RDDInfo Data.Int.Int64@
    * 'Proto.Karps.Proto.Computation_Fields.className' @:: Lens' RDDInfo Data.Text.Text@
    * 'Proto.Karps.Proto.Computation_Fields.repr' @:: Lens' RDDInfo Data.Text.Text@
    * 'Proto.Karps.Proto.Computation_Fields.parents' @:: Lens' RDDInfo [Data.Int.Int64]@
    * 'Proto.Karps.Proto.Computation_Fields.proto' @:: Lens' RDDInfo Proto.Tensorflow.Core.Framework.NodeDef.NodeDef@
    * 'Proto.Karps.Proto.Computation_Fields.maybe'proto' @:: Lens' RDDInfo
  (Prelude.Maybe Proto.Tensorflow.Core.Framework.NodeDef.NodeDef)@
 -}
data RDDInfo = RDDInfo{_RDDInfo'rddId :: !Data.Int.Int64,
                       _RDDInfo'className :: !Data.Text.Text,
                       _RDDInfo'repr :: !Data.Text.Text,
                       _RDDInfo'parents :: ![Data.Int.Int64],
                       _RDDInfo'proto ::
                       !(Prelude.Maybe Proto.Tensorflow.Core.Framework.NodeDef.NodeDef),
                       _RDDInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f RDDInfo x a, a ~ b) =>
         Lens.Labels.HasLens f RDDInfo RDDInfo x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f RDDInfo "rddId" (Data.Int.Int64)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _RDDInfo'rddId
                 (\ x__ y__ -> x__{_RDDInfo'rddId = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f RDDInfo "className" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _RDDInfo'className
                 (\ x__ y__ -> x__{_RDDInfo'className = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f RDDInfo "repr" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _RDDInfo'repr
                 (\ x__ y__ -> x__{_RDDInfo'repr = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f RDDInfo "parents" ([Data.Int.Int64])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _RDDInfo'parents
                 (\ x__ y__ -> x__{_RDDInfo'parents = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f RDDInfo "proto"
           (Proto.Tensorflow.Core.Framework.NodeDef.NodeDef)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _RDDInfo'proto
                 (\ x__ y__ -> x__{_RDDInfo'proto = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f RDDInfo "maybe'proto"
           (Prelude.Maybe Proto.Tensorflow.Core.Framework.NodeDef.NodeDef)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _RDDInfo'proto
                 (\ x__ y__ -> x__{_RDDInfo'proto = y__}))
              Prelude.id
instance Data.Default.Class.Default RDDInfo where
        def
          = RDDInfo{_RDDInfo'rddId = Data.ProtoLens.fieldDefault,
                    _RDDInfo'className = Data.ProtoLens.fieldDefault,
                    _RDDInfo'repr = Data.ProtoLens.fieldDefault, _RDDInfo'parents = [],
                    _RDDInfo'proto = Prelude.Nothing, _RDDInfo'_unknownFields = ([])}
instance Data.ProtoLens.Message RDDInfo where
        messageName _ = Data.Text.pack "karps.core.RDDInfo"
        fieldsByTag
          = let rddId__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "rdd_id"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "rddId")))
                      :: Data.ProtoLens.FieldDescriptor RDDInfo
                className__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "class_name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "className")))
                      :: Data.ProtoLens.FieldDescriptor RDDInfo
                repr__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "repr"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "repr")))
                      :: Data.ProtoLens.FieldDescriptor RDDInfo
                parents__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "parents"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Packed
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parents")))
                      :: Data.ProtoLens.FieldDescriptor RDDInfo
                proto__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "proto"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Tensorflow.Core.Framework.NodeDef.NodeDef)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'proto")))
                      :: Data.ProtoLens.FieldDescriptor RDDInfo
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, rddId__field_descriptor),
                 (Data.ProtoLens.Tag 2, className__field_descriptor),
                 (Data.ProtoLens.Tag 3, repr__field_descriptor),
                 (Data.ProtoLens.Tag 4, parents__field_descriptor),
                 (Data.ProtoLens.Tag 5, proto__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _RDDInfo'_unknownFields
              (\ x__ y__ -> x__{_RDDInfo'_unknownFields = y__})
data ResultStatus = UNUSED
                  | RUNNING
                  | FINISHED_SUCCESS
                  | FINISHED_FAILURE
                  | SCHEDULED
                  | ResultStatus'Unrecognized !ResultStatus'UnrecognizedValue
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
newtype ResultStatus'UnrecognizedValue = ResultStatus'UnrecognizedValue Data.Int.Int32
                                           deriving (Prelude.Eq, Prelude.Ord, Prelude.Show)
instance Data.ProtoLens.MessageEnum ResultStatus where
        maybeToEnum 0 = Prelude.Just UNUSED
        maybeToEnum 1 = Prelude.Just RUNNING
        maybeToEnum 2 = Prelude.Just FINISHED_SUCCESS
        maybeToEnum 3 = Prelude.Just FINISHED_FAILURE
        maybeToEnum 4 = Prelude.Just SCHEDULED
        maybeToEnum k
          = Prelude.Just
              (ResultStatus'Unrecognized
                 (ResultStatus'UnrecognizedValue (Prelude.fromIntegral k)))
        showEnum UNUSED = "UNUSED"
        showEnum RUNNING = "RUNNING"
        showEnum FINISHED_SUCCESS = "FINISHED_SUCCESS"
        showEnum FINISHED_FAILURE = "FINISHED_FAILURE"
        showEnum SCHEDULED = "SCHEDULED"
        showEnum
          (ResultStatus'Unrecognized (ResultStatus'UnrecognizedValue k))
          = Prelude.show k
        readEnum "UNUSED" = Prelude.Just UNUSED
        readEnum "RUNNING" = Prelude.Just RUNNING
        readEnum "FINISHED_SUCCESS" = Prelude.Just FINISHED_SUCCESS
        readEnum "FINISHED_FAILURE" = Prelude.Just FINISHED_FAILURE
        readEnum "SCHEDULED" = Prelude.Just SCHEDULED
        readEnum k
          = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded ResultStatus where
        minBound = UNUSED
        maxBound = SCHEDULED
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
        fromEnum
          (ResultStatus'Unrecognized (ResultStatus'UnrecognizedValue k))
          = Prelude.fromIntegral k
        succ SCHEDULED
          = Prelude.error
              "ResultStatus.succ: bad argument SCHEDULED. This value would be out of bounds."
        succ UNUSED = RUNNING
        succ RUNNING = FINISHED_SUCCESS
        succ FINISHED_SUCCESS = FINISHED_FAILURE
        succ FINISHED_FAILURE = SCHEDULED
        succ _
          = Prelude.error
              "ResultStatus.succ: bad argument: unrecognized value"
        pred UNUSED
          = Prelude.error
              "ResultStatus.pred: bad argument UNUSED. This value would be out of bounds."
        pred RUNNING = UNUSED
        pred FINISHED_SUCCESS = RUNNING
        pred FINISHED_FAILURE = FINISHED_SUCCESS
        pred SCHEDULED = FINISHED_FAILURE
        pred _
          = Prelude.error
              "ResultStatus.pred: bad argument: unrecognized value"
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.Default.Class.Default ResultStatus where
        def = UNUSED
instance Data.ProtoLens.FieldDefault ResultStatus where
        fieldDefault = UNUSED
{- | Fields :

    * 'Proto.Karps.Proto.Computation_Fields.nodeId' @:: Lens' SQLTreeInfo Data.Text.Text@
    * 'Proto.Karps.Proto.Computation_Fields.fullName' @:: Lens' SQLTreeInfo Data.Text.Text@
    * 'Proto.Karps.Proto.Computation_Fields.parentNodes' @:: Lens' SQLTreeInfo [Data.Text.Text]@
    * 'Proto.Karps.Proto.Computation_Fields.proto' @:: Lens' SQLTreeInfo Proto.Tensorflow.Core.Framework.NodeDef.NodeDef@
    * 'Proto.Karps.Proto.Computation_Fields.maybe'proto' @:: Lens' SQLTreeInfo
  (Prelude.Maybe Proto.Tensorflow.Core.Framework.NodeDef.NodeDef)@
 -}
data SQLTreeInfo = SQLTreeInfo{_SQLTreeInfo'nodeId ::
                               !Data.Text.Text,
                               _SQLTreeInfo'fullName :: !Data.Text.Text,
                               _SQLTreeInfo'parentNodes :: ![Data.Text.Text],
                               _SQLTreeInfo'proto ::
                               !(Prelude.Maybe Proto.Tensorflow.Core.Framework.NodeDef.NodeDef),
                               _SQLTreeInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f SQLTreeInfo x a, a ~ b) =>
         Lens.Labels.HasLens f SQLTreeInfo SQLTreeInfo x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLTreeInfo "nodeId" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLTreeInfo'nodeId
                 (\ x__ y__ -> x__{_SQLTreeInfo'nodeId = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLTreeInfo "fullName" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLTreeInfo'fullName
                 (\ x__ y__ -> x__{_SQLTreeInfo'fullName = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLTreeInfo "parentNodes" ([Data.Text.Text])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLTreeInfo'parentNodes
                 (\ x__ y__ -> x__{_SQLTreeInfo'parentNodes = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLTreeInfo "proto"
           (Proto.Tensorflow.Core.Framework.NodeDef.NodeDef)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLTreeInfo'proto
                 (\ x__ y__ -> x__{_SQLTreeInfo'proto = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLTreeInfo "maybe'proto"
           (Prelude.Maybe Proto.Tensorflow.Core.Framework.NodeDef.NodeDef)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLTreeInfo'proto
                 (\ x__ y__ -> x__{_SQLTreeInfo'proto = y__}))
              Prelude.id
instance Data.Default.Class.Default SQLTreeInfo where
        def
          = SQLTreeInfo{_SQLTreeInfo'nodeId = Data.ProtoLens.fieldDefault,
                        _SQLTreeInfo'fullName = Data.ProtoLens.fieldDefault,
                        _SQLTreeInfo'parentNodes = [],
                        _SQLTreeInfo'proto = Prelude.Nothing,
                        _SQLTreeInfo'_unknownFields = ([])}
instance Data.ProtoLens.Message SQLTreeInfo where
        messageName _ = Data.Text.pack "karps.core.SQLTreeInfo"
        fieldsByTag
          = let nodeId__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "node_id"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "nodeId")))
                      :: Data.ProtoLens.FieldDescriptor SQLTreeInfo
                fullName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "full_name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fullName")))
                      :: Data.ProtoLens.FieldDescriptor SQLTreeInfo
                parentNodes__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "parent_nodes"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parentNodes")))
                      :: Data.ProtoLens.FieldDescriptor SQLTreeInfo
                proto__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "proto"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Tensorflow.Core.Framework.NodeDef.NodeDef)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'proto")))
                      :: Data.ProtoLens.FieldDescriptor SQLTreeInfo
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, nodeId__field_descriptor),
                 (Data.ProtoLens.Tag 2, fullName__field_descriptor),
                 (Data.ProtoLens.Tag 3, parentNodes__field_descriptor),
                 (Data.ProtoLens.Tag 4, proto__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _SQLTreeInfo'_unknownFields
              (\ x__ y__ -> x__{_SQLTreeInfo'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Computation_Fields.id' @:: Lens' SessionId Data.Text.Text@
 -}
data SessionId = SessionId{_SessionId'id :: !Data.Text.Text,
                           _SessionId'_unknownFields :: !Data.ProtoLens.FieldSet}
                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f SessionId x a, a ~ b) =>
         Lens.Labels.HasLens f SessionId SessionId x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SessionId "id" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SessionId'id
                 (\ x__ y__ -> x__{_SessionId'id = y__}))
              Prelude.id
instance Data.Default.Class.Default SessionId where
        def
          = SessionId{_SessionId'id = Data.ProtoLens.fieldDefault,
                      _SessionId'_unknownFields = ([])}
instance Data.ProtoLens.Message SessionId where
        messageName _ = Data.Text.pack "karps.core.SessionId"
        fieldsByTag
          = let id__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "id"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "id")))
                      :: Data.ProtoLens.FieldDescriptor SessionId
              in Data.Map.fromList [(Data.ProtoLens.Tag 1, id__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _SessionId'_unknownFields
              (\ x__ y__ -> x__{_SessionId'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Computation_Fields.rddInfo' @:: Lens' SparkStats [RDDInfo]@
    * 'Proto.Karps.Proto.Computation_Fields.parsed' @:: Lens' SparkStats [SQLTreeInfo]@
    * 'Proto.Karps.Proto.Computation_Fields.analyzed' @:: Lens' SparkStats [SQLTreeInfo]@
    * 'Proto.Karps.Proto.Computation_Fields.optimized' @:: Lens' SparkStats [SQLTreeInfo]@
    * 'Proto.Karps.Proto.Computation_Fields.physical' @:: Lens' SparkStats [SQLTreeInfo]@
 -}
data SparkStats = SparkStats{_SparkStats'rddInfo :: ![RDDInfo],
                             _SparkStats'parsed :: ![SQLTreeInfo],
                             _SparkStats'analyzed :: ![SQLTreeInfo],
                             _SparkStats'optimized :: ![SQLTreeInfo],
                             _SparkStats'physical :: ![SQLTreeInfo],
                             _SparkStats'_unknownFields :: !Data.ProtoLens.FieldSet}
                    deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f SparkStats x a, a ~ b) =>
         Lens.Labels.HasLens f SparkStats SparkStats x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkStats "rddInfo" ([RDDInfo])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkStats'rddInfo
                 (\ x__ y__ -> x__{_SparkStats'rddInfo = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkStats "parsed" ([SQLTreeInfo])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkStats'parsed
                 (\ x__ y__ -> x__{_SparkStats'parsed = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkStats "analyzed" ([SQLTreeInfo])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkStats'analyzed
                 (\ x__ y__ -> x__{_SparkStats'analyzed = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkStats "optimized" ([SQLTreeInfo])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkStats'optimized
                 (\ x__ y__ -> x__{_SparkStats'optimized = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkStats "physical" ([SQLTreeInfo])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkStats'physical
                 (\ x__ y__ -> x__{_SparkStats'physical = y__}))
              Prelude.id
instance Data.Default.Class.Default SparkStats where
        def
          = SparkStats{_SparkStats'rddInfo = [], _SparkStats'parsed = [],
                       _SparkStats'analyzed = [], _SparkStats'optimized = [],
                       _SparkStats'physical = [], _SparkStats'_unknownFields = ([])}
instance Data.ProtoLens.Message SparkStats where
        messageName _ = Data.Text.pack "karps.core.SparkStats"
        fieldsByTag
          = let rddInfo__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "rdd_info"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor RDDInfo)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "rddInfo")))
                      :: Data.ProtoLens.FieldDescriptor SparkStats
                parsed__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "parsed"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SQLTreeInfo)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parsed")))
                      :: Data.ProtoLens.FieldDescriptor SparkStats
                analyzed__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "analyzed"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SQLTreeInfo)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "analyzed")))
                      :: Data.ProtoLens.FieldDescriptor SparkStats
                optimized__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "optimized"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SQLTreeInfo)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "optimized")))
                      :: Data.ProtoLens.FieldDescriptor SparkStats
                physical__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "physical"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SQLTreeInfo)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "physical")))
                      :: Data.ProtoLens.FieldDescriptor SparkStats
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, rddInfo__field_descriptor),
                 (Data.ProtoLens.Tag 2, parsed__field_descriptor),
                 (Data.ProtoLens.Tag 3, analyzed__field_descriptor),
                 (Data.ProtoLens.Tag 4, optimized__field_descriptor),
                 (Data.ProtoLens.Tag 5, physical__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _SparkStats'_unknownFields
              (\ x__ y__ -> x__{_SparkStats'_unknownFields = y__})