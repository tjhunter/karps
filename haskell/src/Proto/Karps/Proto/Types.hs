{- This file was auto-generated from karps/proto/types.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Types
       (SQLType(..), SQLType'StrictType(..), _SQLType'BasicType,
        _SQLType'ArrayType, _SQLType'StructType, SQLType'BasicType(..),
        SQLType'BasicType(), SQLType'BasicType'UnrecognizedValue,
        StructField(..), StructType(..))
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

{- | Fields :

    * 'Proto.Karps.Proto.Types_Fields.nullable' @:: Lens' SQLType Prelude.Bool@
    * 'Proto.Karps.Proto.Types_Fields.maybe'strictType' @:: Lens' SQLType (Prelude.Maybe SQLType'StrictType)@
    * 'Proto.Karps.Proto.Types_Fields.maybe'basicType' @:: Lens' SQLType (Prelude.Maybe SQLType'BasicType)@
    * 'Proto.Karps.Proto.Types_Fields.basicType' @:: Lens' SQLType SQLType'BasicType@
    * 'Proto.Karps.Proto.Types_Fields.maybe'arrayType' @:: Lens' SQLType (Prelude.Maybe SQLType)@
    * 'Proto.Karps.Proto.Types_Fields.arrayType' @:: Lens' SQLType SQLType@
    * 'Proto.Karps.Proto.Types_Fields.maybe'structType' @:: Lens' SQLType (Prelude.Maybe StructType)@
    * 'Proto.Karps.Proto.Types_Fields.structType' @:: Lens' SQLType StructType@
 -}
data SQLType = SQLType{_SQLType'nullable :: !Prelude.Bool,
                       _SQLType'strictType :: !(Prelude.Maybe SQLType'StrictType),
                       _SQLType'_unknownFields :: !Data.ProtoLens.FieldSet}
                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
data SQLType'StrictType = SQLType'BasicType !SQLType'BasicType
                        | SQLType'ArrayType !SQLType
                        | SQLType'StructType !StructType
                            deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f SQLType x a, a ~ b) =>
         Lens.Labels.HasLens f SQLType SQLType x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLType "nullable" (Prelude.Bool)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'nullable
                 (\ x__ y__ -> x__{_SQLType'nullable = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLType "maybe'strictType"
           (Prelude.Maybe SQLType'StrictType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'strictType
                 (\ x__ y__ -> x__{_SQLType'strictType = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLType "maybe'basicType"
           (Prelude.Maybe SQLType'BasicType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'strictType
                 (\ x__ y__ -> x__{_SQLType'strictType = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (SQLType'BasicType x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap SQLType'BasicType y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLType "basicType" (SQLType'BasicType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'strictType
                 (\ x__ y__ -> x__{_SQLType'strictType = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (SQLType'BasicType x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap SQLType'BasicType y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLType "maybe'arrayType"
           (Prelude.Maybe SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'strictType
                 (\ x__ y__ -> x__{_SQLType'strictType = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (SQLType'ArrayType x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap SQLType'ArrayType y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLType "arrayType" (SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'strictType
                 (\ x__ y__ -> x__{_SQLType'strictType = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (SQLType'ArrayType x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap SQLType'ArrayType y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLType "maybe'structType"
           (Prelude.Maybe StructType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'strictType
                 (\ x__ y__ -> x__{_SQLType'strictType = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (SQLType'StructType x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap SQLType'StructType y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SQLType "structType" (StructType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'strictType
                 (\ x__ y__ -> x__{_SQLType'strictType = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (SQLType'StructType x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap SQLType'StructType y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))
instance Data.Default.Class.Default SQLType where
        def
          = SQLType{_SQLType'nullable = Data.ProtoLens.fieldDefault,
                    _SQLType'strictType = Prelude.Nothing,
                    _SQLType'_unknownFields = ([])}
instance Data.ProtoLens.Message SQLType where
        messageName _ = Data.Text.pack "karps.core.SQLType"
        fieldsByTag
          = let nullable__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "nullable"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "nullable")))
                      :: Data.ProtoLens.FieldDescriptor SQLType
                basicType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "basic_type"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor SQLType'BasicType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'basicType")))
                      :: Data.ProtoLens.FieldDescriptor SQLType
                arrayType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "array_type"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SQLType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'arrayType")))
                      :: Data.ProtoLens.FieldDescriptor SQLType
                structType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "struct_type"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor StructType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'structType")))
                      :: Data.ProtoLens.FieldDescriptor SQLType
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 4, nullable__field_descriptor),
                 (Data.ProtoLens.Tag 1, basicType__field_descriptor),
                 (Data.ProtoLens.Tag 2, arrayType__field_descriptor),
                 (Data.ProtoLens.Tag 3, structType__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _SQLType'_unknownFields
              (\ x__ y__ -> x__{_SQLType'_unknownFields = y__})
_SQLType'BasicType ::
                   Lens.Labels.Prism.Prism' SQLType'StrictType SQLType'BasicType
_SQLType'BasicType
  = Lens.Labels.Prism.prism' SQLType'BasicType
      (\ p__ ->
         case p__ of
             SQLType'BasicType p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_SQLType'ArrayType ::
                   Lens.Labels.Prism.Prism' SQLType'StrictType SQLType
_SQLType'ArrayType
  = Lens.Labels.Prism.prism' SQLType'ArrayType
      (\ p__ ->
         case p__ of
             SQLType'ArrayType p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_SQLType'StructType ::
                    Lens.Labels.Prism.Prism' SQLType'StrictType StructType
_SQLType'StructType
  = Lens.Labels.Prism.prism' SQLType'StructType
      (\ p__ ->
         case p__ of
             SQLType'StructType p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
data SQLType'BasicType = SQLType'UNUSED
                       | SQLType'INT
                       | SQLType'DOUBLE
                       | SQLType'STRING
                       | SQLType'BOOL
                       | SQLType'BasicType'Unrecognized !SQLType'BasicType'UnrecognizedValue
                           deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
newtype SQLType'BasicType'UnrecognizedValue = SQLType'BasicType'UnrecognizedValue Data.Int.Int32
                                                deriving (Prelude.Eq, Prelude.Ord, Prelude.Show)
instance Data.ProtoLens.MessageEnum SQLType'BasicType where
        maybeToEnum 0 = Prelude.Just SQLType'UNUSED
        maybeToEnum 1 = Prelude.Just SQLType'INT
        maybeToEnum 2 = Prelude.Just SQLType'DOUBLE
        maybeToEnum 3 = Prelude.Just SQLType'STRING
        maybeToEnum 4 = Prelude.Just SQLType'BOOL
        maybeToEnum k
          = Prelude.Just
              (SQLType'BasicType'Unrecognized
                 (SQLType'BasicType'UnrecognizedValue (Prelude.fromIntegral k)))
        showEnum SQLType'UNUSED = "UNUSED"
        showEnum SQLType'INT = "INT"
        showEnum SQLType'DOUBLE = "DOUBLE"
        showEnum SQLType'STRING = "STRING"
        showEnum SQLType'BOOL = "BOOL"
        showEnum
          (SQLType'BasicType'Unrecognized
             (SQLType'BasicType'UnrecognizedValue k))
          = Prelude.show k
        readEnum "UNUSED" = Prelude.Just SQLType'UNUSED
        readEnum "INT" = Prelude.Just SQLType'INT
        readEnum "DOUBLE" = Prelude.Just SQLType'DOUBLE
        readEnum "STRING" = Prelude.Just SQLType'STRING
        readEnum "BOOL" = Prelude.Just SQLType'BOOL
        readEnum k
          = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded SQLType'BasicType where
        minBound = SQLType'UNUSED
        maxBound = SQLType'BOOL
instance Prelude.Enum SQLType'BasicType where
        toEnum k__
          = Prelude.maybe
              (Prelude.error
                 ((Prelude.++) "toEnum: unknown value for enum BasicType: "
                    (Prelude.show k__)))
              Prelude.id
              (Data.ProtoLens.maybeToEnum k__)
        fromEnum SQLType'UNUSED = 0
        fromEnum SQLType'INT = 1
        fromEnum SQLType'DOUBLE = 2
        fromEnum SQLType'STRING = 3
        fromEnum SQLType'BOOL = 4
        fromEnum
          (SQLType'BasicType'Unrecognized
             (SQLType'BasicType'UnrecognizedValue k))
          = Prelude.fromIntegral k
        succ SQLType'BOOL
          = Prelude.error
              "SQLType'BasicType.succ: bad argument SQLType'BOOL. This value would be out of bounds."
        succ SQLType'UNUSED = SQLType'INT
        succ SQLType'INT = SQLType'DOUBLE
        succ SQLType'DOUBLE = SQLType'STRING
        succ SQLType'STRING = SQLType'BOOL
        succ _
          = Prelude.error
              "SQLType'BasicType.succ: bad argument: unrecognized value"
        pred SQLType'UNUSED
          = Prelude.error
              "SQLType'BasicType.pred: bad argument SQLType'UNUSED. This value would be out of bounds."
        pred SQLType'INT = SQLType'UNUSED
        pred SQLType'DOUBLE = SQLType'INT
        pred SQLType'STRING = SQLType'DOUBLE
        pred SQLType'BOOL = SQLType'STRING
        pred _
          = Prelude.error
              "SQLType'BasicType.pred: bad argument: unrecognized value"
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.Default.Class.Default SQLType'BasicType where
        def = SQLType'UNUSED
instance Data.ProtoLens.FieldDefault SQLType'BasicType where
        fieldDefault = SQLType'UNUSED
{- | Fields :

    * 'Proto.Karps.Proto.Types_Fields.fieldName' @:: Lens' StructField Data.Text.Text@
    * 'Proto.Karps.Proto.Types_Fields.fieldType' @:: Lens' StructField SQLType@
    * 'Proto.Karps.Proto.Types_Fields.maybe'fieldType' @:: Lens' StructField (Prelude.Maybe SQLType)@
 -}
data StructField = StructField{_StructField'fieldName ::
                               !Data.Text.Text,
                               _StructField'fieldType :: !(Prelude.Maybe SQLType),
                               _StructField'_unknownFields :: !Data.ProtoLens.FieldSet}
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f StructField x a, a ~ b) =>
         Lens.Labels.HasLens f StructField StructField x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f StructField "fieldName" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructField'fieldName
                 (\ x__ y__ -> x__{_StructField'fieldName = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f StructField "fieldType" (SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructField'fieldType
                 (\ x__ y__ -> x__{_StructField'fieldType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f StructField "maybe'fieldType"
           (Prelude.Maybe SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructField'fieldType
                 (\ x__ y__ -> x__{_StructField'fieldType = y__}))
              Prelude.id
instance Data.Default.Class.Default StructField where
        def
          = StructField{_StructField'fieldName = Data.ProtoLens.fieldDefault,
                        _StructField'fieldType = Prelude.Nothing,
                        _StructField'_unknownFields = ([])}
instance Data.ProtoLens.Message StructField where
        messageName _ = Data.Text.pack "karps.core.StructField"
        fieldsByTag
          = let fieldName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "field_name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fieldName")))
                      :: Data.ProtoLens.FieldDescriptor StructField
                fieldType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "field_type"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SQLType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'fieldType")))
                      :: Data.ProtoLens.FieldDescriptor StructField
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, fieldName__field_descriptor),
                 (Data.ProtoLens.Tag 2, fieldType__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _StructField'_unknownFields
              (\ x__ y__ -> x__{_StructField'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Types_Fields.fields' @:: Lens' StructType [StructField]@
 -}
data StructType = StructType{_StructType'fields :: ![StructField],
                             _StructType'_unknownFields :: !Data.ProtoLens.FieldSet}
                    deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f StructType x a, a ~ b) =>
         Lens.Labels.HasLens f StructType StructType x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f StructType "fields" ([StructField])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructType'fields
                 (\ x__ y__ -> x__{_StructType'fields = y__}))
              Prelude.id
instance Data.Default.Class.Default StructType where
        def
          = StructType{_StructType'fields = [],
                       _StructType'_unknownFields = ([])}
instance Data.ProtoLens.Message StructType where
        messageName _ = Data.Text.pack "karps.core.StructType"
        fieldsByTag
          = let fields__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "fields"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor StructField)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fields")))
                      :: Data.ProtoLens.FieldDescriptor StructType
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, fields__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _StructType'_unknownFields
              (\ x__ y__ -> x__{_StructType'_unknownFields = y__})