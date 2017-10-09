{- This file was auto-generated from karps/proto/types.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Karps.Proto.Types where
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

data SQLType = SQLType{_SQLType'nullable :: !Prelude.Bool,
                       _SQLType'strictType :: !(Prelude.Maybe SQLType'StrictType)}
             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

data SQLType'StrictType = SQLType'BasicType !SQLType'BasicType
                        | SQLType'ArrayType !SQLType
                        | SQLType'StructType !StructType
                        deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Prelude.Bool, b ~ Prelude.Bool, Prelude.Functor f) =>
         Lens.Labels.HasLens "nullable" f SQLType SQLType a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'nullable
                 (\ x__ y__ -> x__{_SQLType'nullable = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe SQLType'StrictType,
          b ~ Prelude.Maybe SQLType'StrictType, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'strictType" f SQLType SQLType a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'strictType
                 (\ x__ y__ -> x__{_SQLType'strictType = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe SQLType'BasicType,
          b ~ Prelude.Maybe SQLType'BasicType, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'basicType" f SQLType SQLType a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'strictType
                 (\ x__ y__ -> x__{_SQLType'strictType = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (SQLType'BasicType x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap SQLType'BasicType y__))

instance (a ~ SQLType'BasicType, b ~ SQLType'BasicType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "basicType" f SQLType SQLType a b where
        lensOf _
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

instance (a ~ Prelude.Maybe SQLType, b ~ Prelude.Maybe SQLType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'arrayType" f SQLType SQLType a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'strictType
                 (\ x__ y__ -> x__{_SQLType'strictType = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (SQLType'ArrayType x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap SQLType'ArrayType y__))

instance (a ~ SQLType, b ~ SQLType, Prelude.Functor f) =>
         Lens.Labels.HasLens "arrayType" f SQLType SQLType a b where
        lensOf _
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

instance (a ~ Prelude.Maybe StructType,
          b ~ Prelude.Maybe StructType, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'structType" f SQLType SQLType a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SQLType'strictType
                 (\ x__ y__ -> x__{_SQLType'strictType = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (SQLType'StructType x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap SQLType'StructType y__))

instance (a ~ StructType, b ~ StructType, Prelude.Functor f) =>
         Lens.Labels.HasLens "structType" f SQLType SQLType a b where
        lensOf _
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
                    _SQLType'strictType = Prelude.Nothing}

instance Data.ProtoLens.Message SQLType where
        descriptor
          = let nullable__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "nullable"
                      (Data.ProtoLens.BoolField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional nullable)
                      :: Data.ProtoLens.FieldDescriptor SQLType
                basicType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "basic_type"
                      (Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor SQLType'BasicType)
                      (Data.ProtoLens.OptionalField maybe'basicType)
                      :: Data.ProtoLens.FieldDescriptor SQLType
                arrayType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "array_type"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor SQLType)
                      (Data.ProtoLens.OptionalField maybe'arrayType)
                      :: Data.ProtoLens.FieldDescriptor SQLType
                structType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "struct_type"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor StructType)
                      (Data.ProtoLens.OptionalField maybe'structType)
                      :: Data.ProtoLens.FieldDescriptor SQLType
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.SQLType")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 4, nullable__field_descriptor),
                    (Data.ProtoLens.Tag 1, basicType__field_descriptor),
                    (Data.ProtoLens.Tag 2, arrayType__field_descriptor),
                    (Data.ProtoLens.Tag 3, structType__field_descriptor)])
                (Data.Map.fromList
                   [("nullable", nullable__field_descriptor),
                    ("basic_type", basicType__field_descriptor),
                    ("array_type", arrayType__field_descriptor),
                    ("struct_type", structType__field_descriptor)])

data SQLType'BasicType = SQLType'UNUSED
                       | SQLType'INT
                       | SQLType'DOUBLE
                       | SQLType'STRING
                       | SQLType'BOOL
                       deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance Data.Default.Class.Default SQLType'BasicType where
        def = SQLType'UNUSED

instance Data.ProtoLens.FieldDefault SQLType'BasicType where
        fieldDefault = SQLType'UNUSED

instance Data.ProtoLens.MessageEnum SQLType'BasicType where
        maybeToEnum 0 = Prelude.Just SQLType'UNUSED
        maybeToEnum 1 = Prelude.Just SQLType'INT
        maybeToEnum 2 = Prelude.Just SQLType'DOUBLE
        maybeToEnum 3 = Prelude.Just SQLType'STRING
        maybeToEnum 4 = Prelude.Just SQLType'BOOL
        maybeToEnum _ = Prelude.Nothing
        showEnum SQLType'UNUSED = "UNUSED"
        showEnum SQLType'INT = "INT"
        showEnum SQLType'DOUBLE = "DOUBLE"
        showEnum SQLType'STRING = "STRING"
        showEnum SQLType'BOOL = "BOOL"
        readEnum "UNUSED" = Prelude.Just SQLType'UNUSED
        readEnum "INT" = Prelude.Just SQLType'INT
        readEnum "DOUBLE" = Prelude.Just SQLType'DOUBLE
        readEnum "STRING" = Prelude.Just SQLType'STRING
        readEnum "BOOL" = Prelude.Just SQLType'BOOL
        readEnum _ = Prelude.Nothing

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
        succ SQLType'BOOL
          = Prelude.error
              "SQLType'BasicType.succ: bad argument SQLType'BOOL. This value would be out of bounds."
        succ SQLType'UNUSED = SQLType'INT
        succ SQLType'INT = SQLType'DOUBLE
        succ SQLType'DOUBLE = SQLType'STRING
        succ SQLType'STRING = SQLType'BOOL
        pred SQLType'UNUSED
          = Prelude.error
              "SQLType'BasicType.pred: bad argument SQLType'UNUSED. This value would be out of bounds."
        pred SQLType'INT = SQLType'UNUSED
        pred SQLType'DOUBLE = SQLType'INT
        pred SQLType'STRING = SQLType'DOUBLE
        pred SQLType'BOOL = SQLType'STRING
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo

instance Prelude.Bounded SQLType'BasicType where
        minBound = SQLType'UNUSED
        maxBound = SQLType'BOOL

data StructField = StructField{_StructField'fieldName ::
                               !Data.Text.Text,
                               _StructField'fieldType :: !(Prelude.Maybe SQLType)}
                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "fieldName" f StructField StructField a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructField'fieldName
                 (\ x__ y__ -> x__{_StructField'fieldName = y__}))
              Prelude.id

instance (a ~ SQLType, b ~ SQLType, Prelude.Functor f) =>
         Lens.Labels.HasLens "fieldType" f StructField StructField a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructField'fieldType
                 (\ x__ y__ -> x__{_StructField'fieldType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe SQLType, b ~ Prelude.Maybe SQLType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'fieldType" f StructField StructField a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructField'fieldType
                 (\ x__ y__ -> x__{_StructField'fieldType = y__}))
              Prelude.id

instance Data.Default.Class.Default StructField where
        def
          = StructField{_StructField'fieldName = Data.ProtoLens.fieldDefault,
                        _StructField'fieldType = Prelude.Nothing}

instance Data.ProtoLens.Message StructField where
        descriptor
          = let fieldName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "field_name"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional fieldName)
                      :: Data.ProtoLens.FieldDescriptor StructField
                fieldType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "field_type"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor SQLType)
                      (Data.ProtoLens.OptionalField maybe'fieldType)
                      :: Data.ProtoLens.FieldDescriptor StructField
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.StructField")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, fieldName__field_descriptor),
                    (Data.ProtoLens.Tag 2, fieldType__field_descriptor)])
                (Data.Map.fromList
                   [("field_name", fieldName__field_descriptor),
                    ("field_type", fieldType__field_descriptor)])

data StructType = StructType{_StructType'fields :: ![StructField]}
                deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [StructField], b ~ [StructField],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "fields" f StructType StructType a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _StructType'fields
                 (\ x__ y__ -> x__{_StructType'fields = y__}))
              Prelude.id

instance Data.Default.Class.Default StructType where
        def = StructType{_StructType'fields = []}

instance Data.ProtoLens.Message StructType where
        descriptor
          = let fields__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "fields"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor StructField)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked fields)
                      :: Data.ProtoLens.FieldDescriptor StructType
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.StructType")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, fields__field_descriptor)])
                (Data.Map.fromList [("fields", fields__field_descriptor)])

arrayType ::
          forall f s t a b . Lens.Labels.HasLens "arrayType" f s t a b =>
            Lens.Family2.LensLike f s t a b
arrayType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "arrayType")

basicType ::
          forall f s t a b . Lens.Labels.HasLens "basicType" f s t a b =>
            Lens.Family2.LensLike f s t a b
basicType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "basicType")

fieldName ::
          forall f s t a b . Lens.Labels.HasLens "fieldName" f s t a b =>
            Lens.Family2.LensLike f s t a b
fieldName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fieldName")

fieldType ::
          forall f s t a b . Lens.Labels.HasLens "fieldType" f s t a b =>
            Lens.Family2.LensLike f s t a b
fieldType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fieldType")

fields ::
       forall f s t a b . Lens.Labels.HasLens "fields" f s t a b =>
         Lens.Family2.LensLike f s t a b
fields
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fields")

maybe'arrayType ::
                forall f s t a b .
                  Lens.Labels.HasLens "maybe'arrayType" f s t a b =>
                  Lens.Family2.LensLike f s t a b
maybe'arrayType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'arrayType")

maybe'basicType ::
                forall f s t a b .
                  Lens.Labels.HasLens "maybe'basicType" f s t a b =>
                  Lens.Family2.LensLike f s t a b
maybe'basicType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'basicType")

maybe'fieldType ::
                forall f s t a b .
                  Lens.Labels.HasLens "maybe'fieldType" f s t a b =>
                  Lens.Family2.LensLike f s t a b
maybe'fieldType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'fieldType")

maybe'strictType ::
                 forall f s t a b .
                   Lens.Labels.HasLens "maybe'strictType" f s t a b =>
                   Lens.Family2.LensLike f s t a b
maybe'strictType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'strictType")

maybe'structType ::
                 forall f s t a b .
                   Lens.Labels.HasLens "maybe'structType" f s t a b =>
                   Lens.Family2.LensLike f s t a b
maybe'structType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'structType")

nullable ::
         forall f s t a b . Lens.Labels.HasLens "nullable" f s t a b =>
           Lens.Family2.LensLike f s t a b
nullable
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "nullable")

structType ::
           forall f s t a b . Lens.Labels.HasLens "structType" f s t a b =>
             Lens.Family2.LensLike f s t a b
structType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "structType")