{- This file was auto-generated from tensorflow/core/framework/attr_value.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Tensorflow.Core.Framework.AttrValue
       (AttrValue(..), AttrValue'Value(..), _AttrValue'S, _AttrValue'I,
        _AttrValue'F, _AttrValue'B, _AttrValue'List,
        AttrValue'ListValue(..), NameAttrList(..),
        NameAttrList'AttrEntry(..))
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

    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.maybe'value' @:: Lens' AttrValue (Prelude.Maybe AttrValue'Value)@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.maybe's' @:: Lens' AttrValue (Prelude.Maybe Data.ByteString.ByteString)@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.s' @:: Lens' AttrValue Data.ByteString.ByteString@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.maybe'i' @:: Lens' AttrValue (Prelude.Maybe Data.Int.Int64)@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.i' @:: Lens' AttrValue Data.Int.Int64@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.maybe'f' @:: Lens' AttrValue (Prelude.Maybe Prelude.Float)@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.f' @:: Lens' AttrValue Prelude.Float@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.maybe'b' @:: Lens' AttrValue (Prelude.Maybe Prelude.Bool)@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.b' @:: Lens' AttrValue Prelude.Bool@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.maybe'list' @:: Lens' AttrValue (Prelude.Maybe AttrValue'ListValue)@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.list' @:: Lens' AttrValue AttrValue'ListValue@
 -}
data AttrValue = AttrValue{_AttrValue'value ::
                           !(Prelude.Maybe AttrValue'Value),
                           _AttrValue'_unknownFields :: !Data.ProtoLens.FieldSet}
                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
data AttrValue'Value = AttrValue'S !Data.ByteString.ByteString
                     | AttrValue'I !Data.Int.Int64
                     | AttrValue'F !Prelude.Float
                     | AttrValue'B !Prelude.Bool
                     | AttrValue'List !AttrValue'ListValue
                         deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f AttrValue x a, a ~ b) =>
         Lens.Labels.HasLens f AttrValue AttrValue x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue "maybe'value"
           (Prelude.Maybe AttrValue'Value)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue "maybe's"
           (Prelude.Maybe Data.ByteString.ByteString)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (AttrValue'S x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap AttrValue'S y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue "s" (Data.ByteString.ByteString)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue "maybe'i"
           (Prelude.Maybe Data.Int.Int64)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (AttrValue'I x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap AttrValue'I y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue "i" (Data.Int.Int64)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue "maybe'f"
           (Prelude.Maybe Prelude.Float)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (AttrValue'F x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap AttrValue'F y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue "f" (Prelude.Float)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue "maybe'b"
           (Prelude.Maybe Prelude.Bool)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (AttrValue'B x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap AttrValue'B y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue "b" (Prelude.Bool)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue "maybe'list"
           (Prelude.Maybe AttrValue'ListValue)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'value
                 (\ x__ y__ -> x__{_AttrValue'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (AttrValue'List x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap AttrValue'List y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue "list" (AttrValue'ListValue)
         where
        lensOf' _
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
        def
          = AttrValue{_AttrValue'value = Prelude.Nothing,
                      _AttrValue'_unknownFields = ([])}
instance Data.ProtoLens.Message AttrValue where
        messageName _ = Data.Text.pack "tensorflow.AttrValue"
        fieldsByTag
          = let s__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "s"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe's")))
                      :: Data.ProtoLens.FieldDescriptor AttrValue
                i__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "i"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'i")))
                      :: Data.ProtoLens.FieldDescriptor AttrValue
                f__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "f"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.FloatField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Float)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'f")))
                      :: Data.ProtoLens.FieldDescriptor AttrValue
                b__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "b"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'b")))
                      :: Data.ProtoLens.FieldDescriptor AttrValue
                list__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "list"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor AttrValue'ListValue)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'list")))
                      :: Data.ProtoLens.FieldDescriptor AttrValue
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 2, s__field_descriptor),
                 (Data.ProtoLens.Tag 3, i__field_descriptor),
                 (Data.ProtoLens.Tag 4, f__field_descriptor),
                 (Data.ProtoLens.Tag 5, b__field_descriptor),
                 (Data.ProtoLens.Tag 1, list__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _AttrValue'_unknownFields
              (\ x__ y__ -> x__{_AttrValue'_unknownFields = y__})
_AttrValue'S ::
             Lens.Labels.Prism.Prism' AttrValue'Value Data.ByteString.ByteString
_AttrValue'S
  = Lens.Labels.Prism.prism' AttrValue'S
      (\ p__ ->
         case p__ of
             AttrValue'S p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_AttrValue'I ::
             Lens.Labels.Prism.Prism' AttrValue'Value Data.Int.Int64
_AttrValue'I
  = Lens.Labels.Prism.prism' AttrValue'I
      (\ p__ ->
         case p__ of
             AttrValue'I p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_AttrValue'F ::
             Lens.Labels.Prism.Prism' AttrValue'Value Prelude.Float
_AttrValue'F
  = Lens.Labels.Prism.prism' AttrValue'F
      (\ p__ ->
         case p__ of
             AttrValue'F p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_AttrValue'B ::
             Lens.Labels.Prism.Prism' AttrValue'Value Prelude.Bool
_AttrValue'B
  = Lens.Labels.Prism.prism' AttrValue'B
      (\ p__ ->
         case p__ of
             AttrValue'B p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_AttrValue'List ::
                Lens.Labels.Prism.Prism' AttrValue'Value AttrValue'ListValue
_AttrValue'List
  = Lens.Labels.Prism.prism' AttrValue'List
      (\ p__ ->
         case p__ of
             AttrValue'List p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
{- | Fields :

    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.s' @:: Lens' AttrValue'ListValue [Data.ByteString.ByteString]@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.i' @:: Lens' AttrValue'ListValue [Data.Int.Int64]@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.f' @:: Lens' AttrValue'ListValue [Prelude.Float]@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.b' @:: Lens' AttrValue'ListValue [Prelude.Bool]@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.func' @:: Lens' AttrValue'ListValue [NameAttrList]@
 -}
data AttrValue'ListValue = AttrValue'ListValue{_AttrValue'ListValue's
                                               :: ![Data.ByteString.ByteString],
                                               _AttrValue'ListValue'i :: ![Data.Int.Int64],
                                               _AttrValue'ListValue'f :: ![Prelude.Float],
                                               _AttrValue'ListValue'b :: ![Prelude.Bool],
                                               _AttrValue'ListValue'func :: ![NameAttrList],
                                               _AttrValue'ListValue'_unknownFields ::
                                               !Data.ProtoLens.FieldSet}
                             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f AttrValue'ListValue x a, a ~ b) =>
         Lens.Labels.HasLens f AttrValue'ListValue AttrValue'ListValue x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue'ListValue "s"
           ([Data.ByteString.ByteString])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'ListValue's
                 (\ x__ y__ -> x__{_AttrValue'ListValue's = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue'ListValue "i" ([Data.Int.Int64])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'ListValue'i
                 (\ x__ y__ -> x__{_AttrValue'ListValue'i = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue'ListValue "f" ([Prelude.Float])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'ListValue'f
                 (\ x__ y__ -> x__{_AttrValue'ListValue'f = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue'ListValue "b" ([Prelude.Bool])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'ListValue'b
                 (\ x__ y__ -> x__{_AttrValue'ListValue'b = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AttrValue'ListValue "func" ([NameAttrList])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AttrValue'ListValue'func
                 (\ x__ y__ -> x__{_AttrValue'ListValue'func = y__}))
              Prelude.id
instance Data.Default.Class.Default AttrValue'ListValue where
        def
          = AttrValue'ListValue{_AttrValue'ListValue's = [],
                                _AttrValue'ListValue'i = [], _AttrValue'ListValue'f = [],
                                _AttrValue'ListValue'b = [], _AttrValue'ListValue'func = [],
                                _AttrValue'ListValue'_unknownFields = ([])}
instance Data.ProtoLens.Message AttrValue'ListValue where
        messageName _ = Data.Text.pack "tensorflow.AttrValue.ListValue"
        fieldsByTag
          = let s__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "s"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "s")))
                      :: Data.ProtoLens.FieldDescriptor AttrValue'ListValue
                i__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "i"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Packed
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "i")))
                      :: Data.ProtoLens.FieldDescriptor AttrValue'ListValue
                f__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "f"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.FloatField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Float)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Packed
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "f")))
                      :: Data.ProtoLens.FieldDescriptor AttrValue'ListValue
                b__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "b"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Packed
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "b")))
                      :: Data.ProtoLens.FieldDescriptor AttrValue'ListValue
                func__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "func"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor NameAttrList)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "func")))
                      :: Data.ProtoLens.FieldDescriptor AttrValue'ListValue
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 2, s__field_descriptor),
                 (Data.ProtoLens.Tag 3, i__field_descriptor),
                 (Data.ProtoLens.Tag 4, f__field_descriptor),
                 (Data.ProtoLens.Tag 5, b__field_descriptor),
                 (Data.ProtoLens.Tag 9, func__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _AttrValue'ListValue'_unknownFields
              (\ x__ y__ -> x__{_AttrValue'ListValue'_unknownFields = y__})
{- | Fields :

    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.name' @:: Lens' NameAttrList Data.Text.Text@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.attr' @:: Lens' NameAttrList (Data.Map.Map Data.Text.Text AttrValue)@
 -}
data NameAttrList = NameAttrList{_NameAttrList'name ::
                                 !Data.Text.Text,
                                 _NameAttrList'attr :: !(Data.Map.Map Data.Text.Text AttrValue),
                                 _NameAttrList'_unknownFields :: !Data.ProtoLens.FieldSet}
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f NameAttrList x a, a ~ b) =>
         Lens.Labels.HasLens f NameAttrList NameAttrList x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NameAttrList "name" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NameAttrList'name
                 (\ x__ y__ -> x__{_NameAttrList'name = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NameAttrList "attr"
           (Data.Map.Map Data.Text.Text AttrValue)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NameAttrList'attr
                 (\ x__ y__ -> x__{_NameAttrList'attr = y__}))
              Prelude.id
instance Data.Default.Class.Default NameAttrList where
        def
          = NameAttrList{_NameAttrList'name = Data.ProtoLens.fieldDefault,
                         _NameAttrList'attr = Data.Map.empty,
                         _NameAttrList'_unknownFields = ([])}
instance Data.ProtoLens.Message NameAttrList where
        messageName _ = Data.Text.pack "tensorflow.NameAttrList"
        fieldsByTag
          = let name__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "name")))
                      :: Data.ProtoLens.FieldDescriptor NameAttrList
                attr__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "attr"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor NameAttrList'AttrEntry)
                      (Data.ProtoLens.MapField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "key"))
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "value"))
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "attr")))
                      :: Data.ProtoLens.FieldDescriptor NameAttrList
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, name__field_descriptor),
                 (Data.ProtoLens.Tag 2, attr__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _NameAttrList'_unknownFields
              (\ x__ y__ -> x__{_NameAttrList'_unknownFields = y__})
{- | Fields :

    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.key' @:: Lens' NameAttrList'AttrEntry Data.Text.Text@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.value' @:: Lens' NameAttrList'AttrEntry AttrValue@
    * 'Proto.Tensorflow.Core.Framework.AttrValue_Fields.maybe'value' @:: Lens' NameAttrList'AttrEntry (Prelude.Maybe AttrValue)@
 -}
data NameAttrList'AttrEntry = NameAttrList'AttrEntry{_NameAttrList'AttrEntry'key
                                                     :: !Data.Text.Text,
                                                     _NameAttrList'AttrEntry'value ::
                                                     !(Prelude.Maybe AttrValue),
                                                     _NameAttrList'AttrEntry'_unknownFields ::
                                                     !Data.ProtoLens.FieldSet}
                                deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f NameAttrList'AttrEntry x a,
          a ~ b) =>
         Lens.Labels.HasLens f NameAttrList'AttrEntry NameAttrList'AttrEntry
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NameAttrList'AttrEntry "key"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NameAttrList'AttrEntry'key
                 (\ x__ y__ -> x__{_NameAttrList'AttrEntry'key = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NameAttrList'AttrEntry "value" (AttrValue)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NameAttrList'AttrEntry'value
                 (\ x__ y__ -> x__{_NameAttrList'AttrEntry'value = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NameAttrList'AttrEntry "maybe'value"
           (Prelude.Maybe AttrValue)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NameAttrList'AttrEntry'value
                 (\ x__ y__ -> x__{_NameAttrList'AttrEntry'value = y__}))
              Prelude.id
instance Data.Default.Class.Default NameAttrList'AttrEntry where
        def
          = NameAttrList'AttrEntry{_NameAttrList'AttrEntry'key =
                                     Data.ProtoLens.fieldDefault,
                                   _NameAttrList'AttrEntry'value = Prelude.Nothing,
                                   _NameAttrList'AttrEntry'_unknownFields = ([])}
instance Data.ProtoLens.Message NameAttrList'AttrEntry where
        messageName _ = Data.Text.pack "tensorflow.NameAttrList.AttrEntry"
        fieldsByTag
          = let key__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "key"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "key")))
                      :: Data.ProtoLens.FieldDescriptor NameAttrList'AttrEntry
                value__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "value"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor AttrValue)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'value")))
                      :: Data.ProtoLens.FieldDescriptor NameAttrList'AttrEntry
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, key__field_descriptor),
                 (Data.ProtoLens.Tag 2, value__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _NameAttrList'AttrEntry'_unknownFields
              (\ x__ y__ -> x__{_NameAttrList'AttrEntry'_unknownFields = y__})