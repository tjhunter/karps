{- This file was auto-generated from tensorflow/core/framework/node_def.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Tensorflow.Core.Framework.NodeDef where
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
import qualified Proto.Tensorflow.Core.Framework.AttrValue

data NodeDef = NodeDef{_NodeDef'name :: !Data.Text.Text,
                       _NodeDef'op :: !Data.Text.Text,
                       _NodeDef'input :: ![Data.Text.Text],
                       _NodeDef'device :: !Data.Text.Text,
                       _NodeDef'attr ::
                       !(Data.Map.Map Data.Text.Text
                           Proto.Tensorflow.Core.Framework.AttrValue.AttrValue)}
             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "name" f NodeDef NodeDef a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'name
                 (\ x__ y__ -> x__{_NodeDef'name = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "op" f NodeDef NodeDef a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'op
                 (\ x__ y__ -> x__{_NodeDef'op = y__}))
              Prelude.id

instance (a ~ [Data.Text.Text], b ~ [Data.Text.Text],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "input" f NodeDef NodeDef a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'input
                 (\ x__ y__ -> x__{_NodeDef'input = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "device" f NodeDef NodeDef a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'device
                 (\ x__ y__ -> x__{_NodeDef'device = y__}))
              Prelude.id

instance (a ~
            Data.Map.Map Data.Text.Text
              Proto.Tensorflow.Core.Framework.AttrValue.AttrValue,
          b ~
            Data.Map.Map Data.Text.Text
              Proto.Tensorflow.Core.Framework.AttrValue.AttrValue,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "attr" f NodeDef NodeDef a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'attr
                 (\ x__ y__ -> x__{_NodeDef'attr = y__}))
              Prelude.id

instance Data.Default.Class.Default NodeDef where
        def
          = NodeDef{_NodeDef'name = Data.ProtoLens.fieldDefault,
                    _NodeDef'op = Data.ProtoLens.fieldDefault, _NodeDef'input = [],
                    _NodeDef'device = Data.ProtoLens.fieldDefault,
                    _NodeDef'attr = Data.Map.empty}

instance Data.ProtoLens.Message NodeDef where
        descriptor
          = let name__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "name"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional name)
                      :: Data.ProtoLens.FieldDescriptor NodeDef
                op__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "op"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional op)
                      :: Data.ProtoLens.FieldDescriptor NodeDef
                input__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "input"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked input)
                      :: Data.ProtoLens.FieldDescriptor NodeDef
                device__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "device"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional device)
                      :: Data.ProtoLens.FieldDescriptor NodeDef
                attr__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "attr"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor NodeDef'AttrEntry)
                      (Data.ProtoLens.MapField key value attr)
                      :: Data.ProtoLens.FieldDescriptor NodeDef
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "tensorflow.NodeDef")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, name__field_descriptor),
                    (Data.ProtoLens.Tag 2, op__field_descriptor),
                    (Data.ProtoLens.Tag 3, input__field_descriptor),
                    (Data.ProtoLens.Tag 4, device__field_descriptor),
                    (Data.ProtoLens.Tag 5, attr__field_descriptor)])
                (Data.Map.fromList
                   [("name", name__field_descriptor), ("op", op__field_descriptor),
                    ("input", input__field_descriptor),
                    ("device", device__field_descriptor),
                    ("attr", attr__field_descriptor)])

data NodeDef'AttrEntry = NodeDef'AttrEntry{_NodeDef'AttrEntry'key
                                           :: !Data.Text.Text,
                                           _NodeDef'AttrEntry'value ::
                                           !(Prelude.Maybe
                                               Proto.Tensorflow.Core.Framework.AttrValue.AttrValue)}
                       deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "key" f NodeDef'AttrEntry NodeDef'AttrEntry a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'AttrEntry'key
                 (\ x__ y__ -> x__{_NodeDef'AttrEntry'key = y__}))
              Prelude.id

instance (a ~ Proto.Tensorflow.Core.Framework.AttrValue.AttrValue,
          b ~ Proto.Tensorflow.Core.Framework.AttrValue.AttrValue,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "value" f NodeDef'AttrEntry NodeDef'AttrEntry a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'AttrEntry'value
                 (\ x__ y__ -> x__{_NodeDef'AttrEntry'value = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Tensorflow.Core.Framework.AttrValue.AttrValue,
          b ~
            Prelude.Maybe Proto.Tensorflow.Core.Framework.AttrValue.AttrValue,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'value" f NodeDef'AttrEntry
         NodeDef'AttrEntry a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'AttrEntry'value
                 (\ x__ y__ -> x__{_NodeDef'AttrEntry'value = y__}))
              Prelude.id

instance Data.Default.Class.Default NodeDef'AttrEntry where
        def
          = NodeDef'AttrEntry{_NodeDef'AttrEntry'key =
                                Data.ProtoLens.fieldDefault,
                              _NodeDef'AttrEntry'value = Prelude.Nothing}

instance Data.ProtoLens.Message NodeDef'AttrEntry where
        descriptor
          = let key__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "key"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional key)
                      :: Data.ProtoLens.FieldDescriptor NodeDef'AttrEntry
                value__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "value"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Tensorflow.Core.Framework.AttrValue.AttrValue)
                      (Data.ProtoLens.OptionalField maybe'value)
                      :: Data.ProtoLens.FieldDescriptor NodeDef'AttrEntry
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "tensorflow.NodeDef.AttrEntry")
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

device ::
       forall f s t a b . Lens.Labels.HasLens "device" f s t a b =>
         Lens.Family2.LensLike f s t a b
device
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "device")

input ::
      forall f s t a b . Lens.Labels.HasLens "input" f s t a b =>
        Lens.Family2.LensLike f s t a b
input
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "input")

key ::
    forall f s t a b . Lens.Labels.HasLens "key" f s t a b =>
      Lens.Family2.LensLike f s t a b
key
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "key")

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

op ::
   forall f s t a b . Lens.Labels.HasLens "op" f s t a b =>
     Lens.Family2.LensLike f s t a b
op
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "op")

value ::
      forall f s t a b . Lens.Labels.HasLens "value" f s t a b =>
        Lens.Family2.LensLike f s t a b
value
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "value")