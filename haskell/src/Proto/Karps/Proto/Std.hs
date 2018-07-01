{- This file was auto-generated from karps/proto/std.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Std
       (Join(..), Join'JoinType(..), Join'JoinType(),
        Join'JoinType'UnrecognizedValue, LocalPointer(..),
        LocalStructuredTransform(..), Placeholder(..), Shuffle(..),
        StructuredReduce(..), StructuredTransform(..))
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
import qualified Proto.Karps.Proto.StructuredTransform
import qualified Proto.Karps.Proto.Types

{- | Fields :

    * 'Proto.Karps.Proto.Std_Fields.jointType' @:: Lens' Join Join'JoinType@
 -}
data Join = Join{_Join'jointType :: !Join'JoinType,
                 _Join'_unknownFields :: !Data.ProtoLens.FieldSet}
              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f Join x a, a ~ b) =>
         Lens.Labels.HasLens f Join Join x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Join "jointType" (Join'JoinType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Join'jointType
                 (\ x__ y__ -> x__{_Join'jointType = y__}))
              Prelude.id
instance Data.Default.Class.Default Join where
        def
          = Join{_Join'jointType = Data.Default.Class.def,
                 _Join'_unknownFields = ([])}
instance Data.ProtoLens.Message Join where
        messageName _ = Data.Text.pack "karps.core.Join"
        fieldsByTag
          = let jointType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "joint_type"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor Join'JoinType)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "jointType")))
                      :: Data.ProtoLens.FieldDescriptor Join
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, jointType__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _Join'_unknownFields
              (\ x__ y__ -> x__{_Join'_unknownFields = y__})
data Join'JoinType = Join'INNER
                   | Join'JoinType'Unrecognized !Join'JoinType'UnrecognizedValue
                       deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
newtype Join'JoinType'UnrecognizedValue = Join'JoinType'UnrecognizedValue Data.Int.Int32
                                            deriving (Prelude.Eq, Prelude.Ord, Prelude.Show)
instance Data.ProtoLens.MessageEnum Join'JoinType where
        maybeToEnum 0 = Prelude.Just Join'INNER
        maybeToEnum k
          = Prelude.Just
              (Join'JoinType'Unrecognized
                 (Join'JoinType'UnrecognizedValue (Prelude.fromIntegral k)))
        showEnum Join'INNER = "INNER"
        showEnum
          (Join'JoinType'Unrecognized (Join'JoinType'UnrecognizedValue k))
          = Prelude.show k
        readEnum "INNER" = Prelude.Just Join'INNER
        readEnum k
          = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded Join'JoinType where
        minBound = Join'INNER
        maxBound = Join'INNER
instance Prelude.Enum Join'JoinType where
        toEnum k__
          = Prelude.maybe
              (Prelude.error
                 ((Prelude.++) "toEnum: unknown value for enum JoinType: "
                    (Prelude.show k__)))
              Prelude.id
              (Data.ProtoLens.maybeToEnum k__)
        fromEnum Join'INNER = 0
        fromEnum
          (Join'JoinType'Unrecognized (Join'JoinType'UnrecognizedValue k))
          = Prelude.fromIntegral k
        succ Join'INNER
          = Prelude.error
              "Join'JoinType.succ: bad argument Join'INNER. This value would be out of bounds."
        succ _
          = Prelude.error
              "Join'JoinType.succ: bad argument: unrecognized value"
        pred Join'INNER
          = Prelude.error
              "Join'JoinType.pred: bad argument Join'INNER. This value would be out of bounds."
        pred _
          = Prelude.error
              "Join'JoinType.pred: bad argument: unrecognized value"
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.Default.Class.Default Join'JoinType where
        def = Join'INNER
instance Data.ProtoLens.FieldDefault Join'JoinType where
        fieldDefault = Join'INNER
{- | Fields :

    * 'Proto.Karps.Proto.Std_Fields.computation' @:: Lens' LocalPointer Proto.Karps.Proto.Computation.ComputationId@
    * 'Proto.Karps.Proto.Std_Fields.maybe'computation' @:: Lens' LocalPointer
  (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)@
    * 'Proto.Karps.Proto.Std_Fields.localPath' @:: Lens' LocalPointer Proto.Karps.Proto.Graph.Path@
    * 'Proto.Karps.Proto.Std_Fields.maybe'localPath' @:: Lens' LocalPointer (Prelude.Maybe Proto.Karps.Proto.Graph.Path)@
    * 'Proto.Karps.Proto.Std_Fields.dataType' @:: Lens' LocalPointer Proto.Karps.Proto.Types.SQLType@
    * 'Proto.Karps.Proto.Std_Fields.maybe'dataType' @:: Lens' LocalPointer (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)@
 -}
data LocalPointer = LocalPointer{_LocalPointer'computation ::
                                 !(Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId),
                                 _LocalPointer'localPath ::
                                 !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                                 _LocalPointer'dataType ::
                                 !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType),
                                 _LocalPointer'_unknownFields :: !Data.ProtoLens.FieldSet}
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f LocalPointer x a, a ~ b) =>
         Lens.Labels.HasLens f LocalPointer LocalPointer x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f LocalPointer "computation"
           (Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'computation
                 (\ x__ y__ -> x__{_LocalPointer'computation = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f LocalPointer "maybe'computation"
           (Prelude.Maybe Proto.Karps.Proto.Computation.ComputationId)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'computation
                 (\ x__ y__ -> x__{_LocalPointer'computation = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f LocalPointer "localPath"
           (Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'localPath
                 (\ x__ y__ -> x__{_LocalPointer'localPath = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f LocalPointer "maybe'localPath"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'localPath
                 (\ x__ y__ -> x__{_LocalPointer'localPath = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f LocalPointer "dataType"
           (Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'dataType
                 (\ x__ y__ -> x__{_LocalPointer'dataType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f LocalPointer "maybe'dataType"
           (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalPointer'dataType
                 (\ x__ y__ -> x__{_LocalPointer'dataType = y__}))
              Prelude.id
instance Data.Default.Class.Default LocalPointer where
        def
          = LocalPointer{_LocalPointer'computation = Prelude.Nothing,
                         _LocalPointer'localPath = Prelude.Nothing,
                         _LocalPointer'dataType = Prelude.Nothing,
                         _LocalPointer'_unknownFields = ([])}
instance Data.ProtoLens.Message LocalPointer where
        messageName _ = Data.Text.pack "karps.core.LocalPointer"
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
                      :: Data.ProtoLens.FieldDescriptor LocalPointer
                localPath__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "local_path"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'localPath")))
                      :: Data.ProtoLens.FieldDescriptor LocalPointer
                dataType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data_type"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'dataType")))
                      :: Data.ProtoLens.FieldDescriptor LocalPointer
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, computation__field_descriptor),
                 (Data.ProtoLens.Tag 2, localPath__field_descriptor),
                 (Data.ProtoLens.Tag 4, dataType__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _LocalPointer'_unknownFields
              (\ x__ y__ -> x__{_LocalPointer'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Std_Fields.colOp' @:: Lens' LocalStructuredTransform
  Proto.Karps.Proto.StructuredTransform.Column@
    * 'Proto.Karps.Proto.Std_Fields.maybe'colOp' @:: Lens' LocalStructuredTransform
  (Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Column)@
 -}
data LocalStructuredTransform = LocalStructuredTransform{_LocalStructuredTransform'colOp
                                                         ::
                                                         !(Prelude.Maybe
                                                             Proto.Karps.Proto.StructuredTransform.Column),
                                                         _LocalStructuredTransform'_unknownFields ::
                                                         !Data.ProtoLens.FieldSet}
                                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f LocalStructuredTransform x a,
          a ~ b) =>
         Lens.Labels.HasLens f LocalStructuredTransform
           LocalStructuredTransform
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f LocalStructuredTransform "colOp"
           (Proto.Karps.Proto.StructuredTransform.Column)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalStructuredTransform'colOp
                 (\ x__ y__ -> x__{_LocalStructuredTransform'colOp = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f LocalStructuredTransform "maybe'colOp"
           (Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Column)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _LocalStructuredTransform'colOp
                 (\ x__ y__ -> x__{_LocalStructuredTransform'colOp = y__}))
              Prelude.id
instance Data.Default.Class.Default LocalStructuredTransform where
        def
          = LocalStructuredTransform{_LocalStructuredTransform'colOp =
                                       Prelude.Nothing,
                                     _LocalStructuredTransform'_unknownFields = ([])}
instance Data.ProtoLens.Message LocalStructuredTransform where
        messageName _
          = Data.Text.pack "karps.core.LocalStructuredTransform"
        fieldsByTag
          = let colOp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "col_op"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.StructuredTransform.Column)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'colOp")))
                      :: Data.ProtoLens.FieldDescriptor LocalStructuredTransform
              in
              Data.Map.fromList [(Data.ProtoLens.Tag 1, colOp__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _LocalStructuredTransform'_unknownFields
              (\ x__ y__ -> x__{_LocalStructuredTransform'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Std_Fields.locality' @:: Lens' Placeholder Proto.Karps.Proto.Graph.Locality@
    * 'Proto.Karps.Proto.Std_Fields.dataType' @:: Lens' Placeholder Proto.Karps.Proto.Types.SQLType@
    * 'Proto.Karps.Proto.Std_Fields.maybe'dataType' @:: Lens' Placeholder (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)@
 -}
data Placeholder = Placeholder{_Placeholder'locality ::
                               !Proto.Karps.Proto.Graph.Locality,
                               _Placeholder'dataType ::
                               !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType),
                               _Placeholder'_unknownFields :: !Data.ProtoLens.FieldSet}
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f Placeholder x a, a ~ b) =>
         Lens.Labels.HasLens f Placeholder Placeholder x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Placeholder "locality"
           (Proto.Karps.Proto.Graph.Locality)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Placeholder'locality
                 (\ x__ y__ -> x__{_Placeholder'locality = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Placeholder "dataType"
           (Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Placeholder'dataType
                 (\ x__ y__ -> x__{_Placeholder'dataType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Placeholder "maybe'dataType"
           (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Placeholder'dataType
                 (\ x__ y__ -> x__{_Placeholder'dataType = y__}))
              Prelude.id
instance Data.Default.Class.Default Placeholder where
        def
          = Placeholder{_Placeholder'locality = Data.Default.Class.def,
                        _Placeholder'dataType = Prelude.Nothing,
                        _Placeholder'_unknownFields = ([])}
instance Data.ProtoLens.Message Placeholder where
        messageName _ = Data.Text.pack "karps.core.Placeholder"
        fieldsByTag
          = let locality__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "locality"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Graph.Locality)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "locality")))
                      :: Data.ProtoLens.FieldDescriptor Placeholder
                dataType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data_type"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'dataType")))
                      :: Data.ProtoLens.FieldDescriptor Placeholder
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, locality__field_descriptor),
                 (Data.ProtoLens.Tag 2, dataType__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _Placeholder'_unknownFields
              (\ x__ y__ -> x__{_Placeholder'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Std_Fields.aggOp' @:: Lens' Shuffle Proto.Karps.Proto.StructuredTransform.Aggregation@
    * 'Proto.Karps.Proto.Std_Fields.maybe'aggOp' @:: Lens' Shuffle
  (Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Aggregation)@
 -}
data Shuffle = Shuffle{_Shuffle'aggOp ::
                       !(Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Aggregation),
                       _Shuffle'_unknownFields :: !Data.ProtoLens.FieldSet}
                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f Shuffle x a, a ~ b) =>
         Lens.Labels.HasLens f Shuffle Shuffle x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Shuffle "aggOp"
           (Proto.Karps.Proto.StructuredTransform.Aggregation)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Shuffle'aggOp
                 (\ x__ y__ -> x__{_Shuffle'aggOp = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Shuffle "maybe'aggOp"
           (Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Aggregation)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Shuffle'aggOp
                 (\ x__ y__ -> x__{_Shuffle'aggOp = y__}))
              Prelude.id
instance Data.Default.Class.Default Shuffle where
        def
          = Shuffle{_Shuffle'aggOp = Prelude.Nothing,
                    _Shuffle'_unknownFields = ([])}
instance Data.ProtoLens.Message Shuffle where
        messageName _ = Data.Text.pack "karps.core.Shuffle"
        fieldsByTag
          = let aggOp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "agg_op"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.StructuredTransform.Aggregation)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'aggOp")))
                      :: Data.ProtoLens.FieldDescriptor Shuffle
              in
              Data.Map.fromList [(Data.ProtoLens.Tag 1, aggOp__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _Shuffle'_unknownFields
              (\ x__ y__ -> x__{_Shuffle'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Std_Fields.aggOp' @:: Lens' StructuredReduce
  Proto.Karps.Proto.StructuredTransform.Aggregation@
    * 'Proto.Karps.Proto.Std_Fields.maybe'aggOp' @:: Lens' StructuredReduce
  (Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Aggregation)@
 -}
data StructuredReduce = StructuredReduce{_StructuredReduce'aggOp ::
                                         !(Prelude.Maybe
                                             Proto.Karps.Proto.StructuredTransform.Aggregation),
                                         _StructuredReduce'_unknownFields ::
                                         !Data.ProtoLens.FieldSet}
                          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f StructuredReduce x a, a ~ b) =>
         Lens.Labels.HasLens f StructuredReduce StructuredReduce x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f StructuredReduce "aggOp"
           (Proto.Karps.Proto.StructuredTransform.Aggregation)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructuredReduce'aggOp
                 (\ x__ y__ -> x__{_StructuredReduce'aggOp = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f StructuredReduce "maybe'aggOp"
           (Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Aggregation)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructuredReduce'aggOp
                 (\ x__ y__ -> x__{_StructuredReduce'aggOp = y__}))
              Prelude.id
instance Data.Default.Class.Default StructuredReduce where
        def
          = StructuredReduce{_StructuredReduce'aggOp = Prelude.Nothing,
                             _StructuredReduce'_unknownFields = ([])}
instance Data.ProtoLens.Message StructuredReduce where
        messageName _ = Data.Text.pack "karps.core.StructuredReduce"
        fieldsByTag
          = let aggOp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "agg_op"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.StructuredTransform.Aggregation)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'aggOp")))
                      :: Data.ProtoLens.FieldDescriptor StructuredReduce
              in
              Data.Map.fromList [(Data.ProtoLens.Tag 1, aggOp__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _StructuredReduce'_unknownFields
              (\ x__ y__ -> x__{_StructuredReduce'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Std_Fields.colOp' @:: Lens' StructuredTransform
  Proto.Karps.Proto.StructuredTransform.Column@
    * 'Proto.Karps.Proto.Std_Fields.maybe'colOp' @:: Lens' StructuredTransform
  (Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Column)@
 -}
data StructuredTransform = StructuredTransform{_StructuredTransform'colOp
                                               ::
                                               !(Prelude.Maybe
                                                   Proto.Karps.Proto.StructuredTransform.Column),
                                               _StructuredTransform'_unknownFields ::
                                               !Data.ProtoLens.FieldSet}
                             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f StructuredTransform x a, a ~ b) =>
         Lens.Labels.HasLens f StructuredTransform StructuredTransform x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f StructuredTransform "colOp"
           (Proto.Karps.Proto.StructuredTransform.Column)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructuredTransform'colOp
                 (\ x__ y__ -> x__{_StructuredTransform'colOp = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f StructuredTransform "maybe'colOp"
           (Prelude.Maybe Proto.Karps.Proto.StructuredTransform.Column)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructuredTransform'colOp
                 (\ x__ y__ -> x__{_StructuredTransform'colOp = y__}))
              Prelude.id
instance Data.Default.Class.Default StructuredTransform where
        def
          = StructuredTransform{_StructuredTransform'colOp = Prelude.Nothing,
                                _StructuredTransform'_unknownFields = ([])}
instance Data.ProtoLens.Message StructuredTransform where
        messageName _ = Data.Text.pack "karps.core.StructuredTransform"
        fieldsByTag
          = let colOp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "col_op"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.StructuredTransform.Column)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'colOp")))
                      :: Data.ProtoLens.FieldDescriptor StructuredTransform
              in
              Data.Map.fromList [(Data.ProtoLens.Tag 1, colOp__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _StructuredTransform'_unknownFields
              (\ x__ y__ -> x__{_StructuredTransform'_unknownFields = y__})