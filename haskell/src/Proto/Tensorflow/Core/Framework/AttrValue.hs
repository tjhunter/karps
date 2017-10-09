{- This file was auto-generated from tensorflow/core/framework/attr_value.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Tensorflow.Core.Framework.AttrValue where
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

data AttrValue = AttrValue{_AttrValue'value ::
                           !(Prelude.Maybe AttrValue'Value)}
               deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

data AttrValue'Value = AttrValue'S !Data.ByteString.ByteString
                     | AttrValue'I !Data.Int.Int64
                     | AttrValue'F !Prelude.Float
                     | AttrValue'B !Prelude.Bool
                     | AttrValue'List !AttrValue'ListValue
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Prelude.Maybe AttrValue'Value,
          b ~ Prelude.Maybe AttrValue'Value, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'value" f AttrValue AttrValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe Data.ByteString.ByteString,
          b ~ Prelude.Maybe Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe's" f AttrValue AttrValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (AttrValue'S x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap AttrValue'S y__))

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "s" f AttrValue AttrValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (AttrValue'S x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap AttrValue'S y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))

instance (a ~ Prelude.Maybe Data.Int.Int64,
          b ~ Prelude.Maybe Data.Int.Int64, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'i" f AttrValue AttrValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (AttrValue'I x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap AttrValue'I y__))

instance (a ~ Data.Int.Int64, b ~ Data.Int.Int64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "i" f AttrValue AttrValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (AttrValue'I x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap AttrValue'I y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))

instance (a ~ Prelude.Maybe Prelude.Float,
          b ~ Prelude.Maybe Prelude.Float, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'f" f AttrValue AttrValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (AttrValue'F x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap AttrValue'F y__))

instance (a ~ Prelude.Float, b ~ Prelude.Float,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "f" f AttrValue AttrValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (AttrValue'F x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap AttrValue'F y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))

instance (a ~ Prelude.Maybe Prelude.Bool,
          b ~ Prelude.Maybe Prelude.Bool, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'b" f AttrValue AttrValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (AttrValue'B x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap AttrValue'B y__))

instance (a ~ Prelude.Bool, b ~ Prelude.Bool, Prelude.Functor f) =>
         Lens.Labels.HasLens "b" f AttrValue AttrValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (AttrValue'B x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap AttrValue'B y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))

instance (a ~ Prelude.Maybe AttrValue'ListValue,
          b ~ Prelude.Maybe AttrValue'ListValue, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'list" f AttrValue AttrValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (AttrValue'List x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap AttrValue'List y__))

instance (a ~ AttrValue'ListValue, b ~ AttrValue'ListValue,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "list" f AttrValue AttrValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (AttrValue'List x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap AttrValue'List y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))

instance Data.Default.Class.Default AttrValue where
        def = AttrValue{_AttrValue'value = Prelude.Nothing}

instance Data.ProtoLens.Message AttrValue where
        descriptor
          = let s__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "s"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.OptionalField maybe's)
                      :: Data.ProtoLens.FieldDescriptor AttrValue
                i__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "i"
                      (Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.OptionalField maybe'i)
                      :: Data.ProtoLens.FieldDescriptor AttrValue
                f__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "f"
                      (Data.ProtoLens.FloatField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Float)
                      (Data.ProtoLens.OptionalField maybe'f)
                      :: Data.ProtoLens.FieldDescriptor AttrValue
                b__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "b"
                      (Data.ProtoLens.BoolField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
                      (Data.ProtoLens.OptionalField maybe'b)
                      :: Data.ProtoLens.FieldDescriptor AttrValue
                list__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "list"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor AttrValue'ListValue)
                      (Data.ProtoLens.OptionalField maybe'list)
                      :: Data.ProtoLens.FieldDescriptor AttrValue
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "tensorflow.AttrValue")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 2, s__field_descriptor),
                    (Data.ProtoLens.Tag 3, i__field_descriptor),
                    (Data.ProtoLens.Tag 4, f__field_descriptor),
                    (Data.ProtoLens.Tag 5, b__field_descriptor),
                    (Data.ProtoLens.Tag 1, list__field_descriptor)])
                (Data.Map.fromList
                   [("s", s__field_descriptor), ("i", i__field_descriptor),
                    ("f", f__field_descriptor), ("b", b__field_descriptor),
                    ("list", list__field_descriptor)])

data AttrValue'ListValue = AttrValue'ListValue{_AttrValue'ListValue's
                                               :: ![Data.ByteString.ByteString],
                                               _AttrValue'ListValue'i :: ![Data.Int.Int64],
                                               _AttrValue'ListValue'f :: ![Prelude.Float],
                                               _AttrValue'ListValue'b :: ![Prelude.Bool],
                                               _AttrValue'ListValue'func :: ![NameAttrList]}
                         deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [Data.ByteString.ByteString],
          b ~ [Data.ByteString.ByteString], Prelude.Functor f) =>
         Lens.Labels.HasLens "s" f AttrValue'ListValue AttrValue'ListValue a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'ListValue's
                 (\ x__ y__ -> x__{_AttrValue'ListValue's = y__}))
              Prelude.id

instance (a ~ [Data.Int.Int64], b ~ [Data.Int.Int64],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "i" f AttrValue'ListValue AttrValue'ListValue a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'ListValue'i
                 (\ x__ y__ -> x__{_AttrValue'ListValue'i = y__}))
              Prelude.id

instance (a ~ [Prelude.Float], b ~ [Prelude.Float],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "f" f AttrValue'ListValue AttrValue'ListValue a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'ListValue'f
                 (\ x__ y__ -> x__{_AttrValue'ListValue'f = y__}))
              Prelude.id

instance (a ~ [Prelude.Bool], b ~ [Prelude.Bool],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "b" f AttrValue'ListValue AttrValue'ListValue a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'ListValue'b
                 (\ x__ y__ -> x__{_AttrValue'ListValue'b = y__}))
              Prelude.id

instance (a ~ [NameAttrList], b ~ [NameAttrList],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "func" f AttrValue'ListValue
         AttrValue'ListValue a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'ListValue'func
                 (\ x__ y__ -> x__{_AttrValue'ListValue'func = y__}))
              Prelude.id

instance Data.Default.Class.Default AttrValue'ListValue where
        def
          = AttrValue'ListValue{_AttrValue'ListValue's = [],
                                _AttrValue'ListValue'i = [], _AttrValue'ListValue'f = [],
                                _AttrValue'ListValue'b = [], _AttrValue'ListValue'func = []}

instance Data.ProtoLens.Message AttrValue'ListValue where
        descriptor
          = let s__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "s"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked s)
                      :: Data.ProtoLens.FieldDescriptor AttrValue'ListValue
                i__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "i"
                      (Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Packed i)
                      :: Data.ProtoLens.FieldDescriptor AttrValue'ListValue
                f__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "f"
                      (Data.ProtoLens.FloatField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Float)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Packed f)
                      :: Data.ProtoLens.FieldDescriptor AttrValue'ListValue
                b__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "b"
                      (Data.ProtoLens.BoolField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Packed b)
                      :: Data.ProtoLens.FieldDescriptor AttrValue'ListValue
                func__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "func"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor NameAttrList)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked func)
                      :: Data.ProtoLens.FieldDescriptor AttrValue'ListValue
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "tensorflow.AttrValue.ListValue")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 2, s__field_descriptor),
                    (Data.ProtoLens.Tag 3, i__field_descriptor),
                    (Data.ProtoLens.Tag 4, f__field_descriptor),
                    (Data.ProtoLens.Tag 5, b__field_descriptor),
                    (Data.ProtoLens.Tag 9, func__field_descriptor)])
                (Data.Map.fromList
                   [("s", s__field_descriptor), ("i", i__field_descriptor),
                    ("f", f__field_descriptor), ("b", b__field_descriptor),
                    ("func", func__field_descriptor)])

data NameAttrList = NameAttrList{_NameAttrList'name ::
                                 !Data.Text.Text,
                                 _NameAttrList'attr :: !(Data.Map.Map Data.Text.Text AttrValue)}
                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "name" f NameAttrList NameAttrList a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NameAttrList'name
                 (\ x__ y__ -> x__{_NameAttrList'name = y__}))
              Prelude.id

instance (a ~ Data.Map.Map Data.Text.Text AttrValue,
          b ~ Data.Map.Map Data.Text.Text AttrValue, Prelude.Functor f) =>
         Lens.Labels.HasLens "attr" f NameAttrList NameAttrList a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NameAttrList'attr
                 (\ x__ y__ -> x__{_NameAttrList'attr = y__}))
              Prelude.id

instance Data.Default.Class.Default NameAttrList where
        def
          = NameAttrList{_NameAttrList'name = Data.ProtoLens.fieldDefault,
                         _NameAttrList'attr = Data.Map.empty}

instance Data.ProtoLens.Message NameAttrList where
        descriptor
          = let name__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "name"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional name)
                      :: Data.ProtoLens.FieldDescriptor NameAttrList
                attr__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "attr"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor NameAttrList'AttrEntry)
                      (Data.ProtoLens.MapField key value attr)
                      :: Data.ProtoLens.FieldDescriptor NameAttrList
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "tensorflow.NameAttrList")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, name__field_descriptor),
                    (Data.ProtoLens.Tag 2, attr__field_descriptor)])
                (Data.Map.fromList
                   [("name", name__field_descriptor),
                    ("attr", attr__field_descriptor)])

data NameAttrList'AttrEntry = NameAttrList'AttrEntry{_NameAttrList'AttrEntry'key
                                                     :: !Data.Text.Text,
                                                     _NameAttrList'AttrEntry'value ::
                                                     !(Prelude.Maybe AttrValue)}
                            deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "key" f NameAttrList'AttrEntry
         NameAttrList'AttrEntry a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NameAttrList'AttrEntry'key
                 (\ x__ y__ -> x__{_NameAttrList'AttrEntry'key = y__}))
              Prelude.id

instance (a ~ AttrValue, b ~ AttrValue, Prelude.Functor f) =>
         Lens.Labels.HasLens "value" f NameAttrList'AttrEntry
         NameAttrList'AttrEntry a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NameAttrList'AttrEntry'value
                 (\ x__ y__ -> x__{_NameAttrList'AttrEntry'value = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe AttrValue, b ~ Prelude.Maybe AttrValue,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'value" f NameAttrList'AttrEntry
         NameAttrList'AttrEntry a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NameAttrList'AttrEntry'value
                 (\ x__ y__ -> x__{_NameAttrList'AttrEntry'value = y__}))
              Prelude.id

instance Data.Default.Class.Default NameAttrList'AttrEntry where
        def
          = NameAttrList'AttrEntry{_NameAttrList'AttrEntry'key =
                                     Data.ProtoLens.fieldDefault,
                                   _NameAttrList'AttrEntry'value = Prelude.Nothing}

instance Data.ProtoLens.Message NameAttrList'AttrEntry where
        descriptor
          = let key__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "key"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional key)
                      :: Data.ProtoLens.FieldDescriptor NameAttrList'AttrEntry
                value__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "value"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor AttrValue)
                      (Data.ProtoLens.OptionalField maybe'value)
                      :: Data.ProtoLens.FieldDescriptor NameAttrList'AttrEntry
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "tensorflow.NameAttrList.AttrEntry")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, key__field_descriptor),
                    (Data.ProtoLens.Tag 2, value__field_descriptor)])
                (Data.Map.fromList
                   [("key", key__field_descriptor),
                    ("value", value__field_descriptor)])

attr ::
     forall f s t a b . Lens.Labels.HasLens "attr" f s t a b =>
       Lens.Family2.LensLike f s t a b
attr
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "attr")

b ::
  forall f s t a b . Lens.Labels.HasLens "b" f s t a b =>
    Lens.Family2.LensLike f s t a b
b = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "b")

f ::
  forall f s t a b . Lens.Labels.HasLens "f" f s t a b =>
    Lens.Family2.LensLike f s t a b
f = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "f")

func ::
     forall f s t a b . Lens.Labels.HasLens "func" f s t a b =>
       Lens.Family2.LensLike f s t a b
func
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "func")

i ::
  forall f s t a b . Lens.Labels.HasLens "i" f s t a b =>
    Lens.Family2.LensLike f s t a b
i = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "i")

key ::
    forall f s t a b . Lens.Labels.HasLens "key" f s t a b =>
      Lens.Family2.LensLike f s t a b
key
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "key")

list ::
     forall f s t a b . Lens.Labels.HasLens "list" f s t a b =>
       Lens.Family2.LensLike f s t a b
list
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "list")

maybe'b ::
        forall f s t a b . Lens.Labels.HasLens "maybe'b" f s t a b =>
          Lens.Family2.LensLike f s t a b
maybe'b
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'b")

maybe'f ::
        forall f s t a b . Lens.Labels.HasLens "maybe'f" f s t a b =>
          Lens.Family2.LensLike f s t a b
maybe'f
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'f")

maybe'i ::
        forall f s t a b . Lens.Labels.HasLens "maybe'i" f s t a b =>
          Lens.Family2.LensLike f s t a b
maybe'i
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'i")

maybe'list ::
           forall f s t a b . Lens.Labels.HasLens "maybe'list" f s t a b =>
             Lens.Family2.LensLike f s t a b
maybe'list
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'list")

maybe's ::
        forall f s t a b . Lens.Labels.HasLens "maybe's" f s t a b =>
          Lens.Family2.LensLike f s t a b
maybe's
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe's")

maybe'value ::
            forall f s t a b . Lens.Labels.HasLens "maybe'value" f s t a b =>
              Lens.Family2.LensLike f s t a b
maybe'value
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'value")

name ::
     forall f s t a b . Lens.Labels.HasLens "name" f s t a b =>
       Lens.Family2.LensLike f s t a b
name
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "name")

s ::
  forall f s t a b . Lens.Labels.HasLens "s" f s t a b =>
    Lens.Family2.LensLike f s t a b
s = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "s")

value ::
      forall f s t a b . Lens.Labels.HasLens "value" f s t a b =>
        Lens.Family2.LensLike f s t a b
value
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "value")