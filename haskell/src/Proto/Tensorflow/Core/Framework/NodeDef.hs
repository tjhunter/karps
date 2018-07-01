{- This file was auto-generated from tensorflow/core/framework/node_def.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Tensorflow.Core.Framework.NodeDef
       (NodeDef(..), NodeDef'AttrEntry(..)) where
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
import qualified Proto.Tensorflow.Core.Framework.AttrValue

{- | Fields :

    * 'Proto.Tensorflow.Core.Framework.NodeDef_Fields.name' @:: Lens' NodeDef Data.Text.Text@
    * 'Proto.Tensorflow.Core.Framework.NodeDef_Fields.op' @:: Lens' NodeDef Data.Text.Text@
    * 'Proto.Tensorflow.Core.Framework.NodeDef_Fields.input' @:: Lens' NodeDef [Data.Text.Text]@
    * 'Proto.Tensorflow.Core.Framework.NodeDef_Fields.device' @:: Lens' NodeDef Data.Text.Text@
    * 'Proto.Tensorflow.Core.Framework.NodeDef_Fields.attr' @:: Lens' NodeDef
  (Data.Map.Map Data.Text.Text
     Proto.Tensorflow.Core.Framework.AttrValue.AttrValue)@
 -}
data NodeDef = NodeDef{_NodeDef'name :: !Data.Text.Text,
                       _NodeDef'op :: !Data.Text.Text,
                       _NodeDef'input :: ![Data.Text.Text],
                       _NodeDef'device :: !Data.Text.Text,
                       _NodeDef'attr ::
                       !(Data.Map.Map Data.Text.Text
                           Proto.Tensorflow.Core.Framework.AttrValue.AttrValue),
                       _NodeDef'_unknownFields :: !Data.ProtoLens.FieldSet}
                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f NodeDef x a, a ~ b) =>
         Lens.Labels.HasLens f NodeDef NodeDef x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeDef "name" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'name
                 (\ x__ y__ -> x__{_NodeDef'name = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeDef "op" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'op
                 (\ x__ y__ -> x__{_NodeDef'op = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeDef "input" ([Data.Text.Text])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'input
                 (\ x__ y__ -> x__{_NodeDef'input = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeDef "device" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'device
                 (\ x__ y__ -> x__{_NodeDef'device = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeDef "attr"
           (Data.Map.Map Data.Text.Text
              Proto.Tensorflow.Core.Framework.AttrValue.AttrValue)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'attr
                 (\ x__ y__ -> x__{_NodeDef'attr = y__}))
              Prelude.id
instance Data.Default.Class.Default NodeDef where
        def
          = NodeDef{_NodeDef'name = Data.ProtoLens.fieldDefault,
                    _NodeDef'op = Data.ProtoLens.fieldDefault, _NodeDef'input = [],
                    _NodeDef'device = Data.ProtoLens.fieldDefault,
                    _NodeDef'attr = Data.Map.empty, _NodeDef'_unknownFields = ([])}
instance Data.ProtoLens.Message NodeDef where
        messageName _ = Data.Text.pack "tensorflow.NodeDef"
        fieldsByTag
          = let name__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "name")))
                      :: Data.ProtoLens.FieldDescriptor NodeDef
                op__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "op"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "op")))
                      :: Data.ProtoLens.FieldDescriptor NodeDef
                input__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "input"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "input")))
                      :: Data.ProtoLens.FieldDescriptor NodeDef
                device__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "device"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "device")))
                      :: Data.ProtoLens.FieldDescriptor NodeDef
                attr__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "attr"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor NodeDef'AttrEntry)
                      (Data.ProtoLens.MapField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "key"))
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "value"))
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "attr")))
                      :: Data.ProtoLens.FieldDescriptor NodeDef
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, name__field_descriptor),
                 (Data.ProtoLens.Tag 2, op__field_descriptor),
                 (Data.ProtoLens.Tag 3, input__field_descriptor),
                 (Data.ProtoLens.Tag 4, device__field_descriptor),
                 (Data.ProtoLens.Tag 5, attr__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _NodeDef'_unknownFields
              (\ x__ y__ -> x__{_NodeDef'_unknownFields = y__})
{- | Fields :

    * 'Proto.Tensorflow.Core.Framework.NodeDef_Fields.key' @:: Lens' NodeDef'AttrEntry Data.Text.Text@
    * 'Proto.Tensorflow.Core.Framework.NodeDef_Fields.value' @:: Lens' NodeDef'AttrEntry
  Proto.Tensorflow.Core.Framework.AttrValue.AttrValue@
    * 'Proto.Tensorflow.Core.Framework.NodeDef_Fields.maybe'value' @:: Lens' NodeDef'AttrEntry
  (Prelude.Maybe Proto.Tensorflow.Core.Framework.AttrValue.AttrValue)@
 -}
data NodeDef'AttrEntry = NodeDef'AttrEntry{_NodeDef'AttrEntry'key
                                           :: !Data.Text.Text,
                                           _NodeDef'AttrEntry'value ::
                                           !(Prelude.Maybe
                                               Proto.Tensorflow.Core.Framework.AttrValue.AttrValue),
                                           _NodeDef'AttrEntry'_unknownFields ::
                                           !Data.ProtoLens.FieldSet}
                           deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f NodeDef'AttrEntry x a, a ~ b) =>
         Lens.Labels.HasLens f NodeDef'AttrEntry NodeDef'AttrEntry x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeDef'AttrEntry "key" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'AttrEntry'key
                 (\ x__ y__ -> x__{_NodeDef'AttrEntry'key = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeDef'AttrEntry "value"
           (Proto.Tensorflow.Core.Framework.AttrValue.AttrValue)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'AttrEntry'value
                 (\ x__ y__ -> x__{_NodeDef'AttrEntry'value = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f NodeDef'AttrEntry "maybe'value"
           (Prelude.Maybe Proto.Tensorflow.Core.Framework.AttrValue.AttrValue)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _NodeDef'AttrEntry'value
                 (\ x__ y__ -> x__{_NodeDef'AttrEntry'value = y__}))
              Prelude.id
instance Data.Default.Class.Default NodeDef'AttrEntry where
        def
          = NodeDef'AttrEntry{_NodeDef'AttrEntry'key =
                                Data.ProtoLens.fieldDefault,
                              _NodeDef'AttrEntry'value = Prelude.Nothing,
                              _NodeDef'AttrEntry'_unknownFields = ([])}
instance Data.ProtoLens.Message NodeDef'AttrEntry where
        messageName _ = Data.Text.pack "tensorflow.NodeDef.AttrEntry"
        fieldsByTag
          = let key__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "key"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "key")))
                      :: Data.ProtoLens.FieldDescriptor NodeDef'AttrEntry
                value__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "value"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Tensorflow.Core.Framework.AttrValue.AttrValue)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'value")))
                      :: Data.ProtoLens.FieldDescriptor NodeDef'AttrEntry
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, key__field_descriptor),
                 (Data.ProtoLens.Tag 2, value__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _NodeDef'AttrEntry'_unknownFields
              (\ x__ y__ -> x__{_NodeDef'AttrEntry'_unknownFields = y__})