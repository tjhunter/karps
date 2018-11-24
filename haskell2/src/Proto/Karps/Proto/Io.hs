{- This file was auto-generated from karps/proto/io.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Karps.Proto.Io where
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
import qualified Proto.Karps.Proto.Types

data InputOption = InputOption{_InputOption'key :: !Data.Text.Text,
                               _InputOption'value :: !(Prelude.Maybe InputOption'Value)}
                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

data InputOption'Value = InputOption'IntValue !Data.Int.Int32
                       | InputOption'DoubleValue !Prelude.Double
                       | InputOption'StringValue !Data.Text.Text
                       | InputOption'BoolValue !Prelude.Bool
                       deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "key" f InputOption InputOption a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'key
                 (\ x__ y__ -> x__{_InputOption'key = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe InputOption'Value,
          b ~ Prelude.Maybe InputOption'Value, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'value" f InputOption InputOption a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe Data.Int.Int32,
          b ~ Prelude.Maybe Data.Int.Int32, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'intValue" f InputOption InputOption a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (InputOption'IntValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap InputOption'IntValue y__))

instance (a ~ Data.Int.Int32, b ~ Data.Int.Int32,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "intValue" f InputOption InputOption a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (InputOption'IntValue x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap InputOption'IntValue y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))

instance (a ~ Prelude.Maybe Prelude.Double,
          b ~ Prelude.Maybe Prelude.Double, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'doubleValue" f InputOption InputOption a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (InputOption'DoubleValue x__val) -> Prelude.Just
                                                                           x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap InputOption'DoubleValue y__))

instance (a ~ Prelude.Double, b ~ Prelude.Double,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "doubleValue" f InputOption InputOption a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (InputOption'DoubleValue x__val) -> Prelude.Just
                                                                              x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap InputOption'DoubleValue y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))

instance (a ~ Prelude.Maybe Data.Text.Text,
          b ~ Prelude.Maybe Data.Text.Text, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'stringValue" f InputOption InputOption a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (InputOption'StringValue x__val) -> Prelude.Just
                                                                           x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap InputOption'StringValue y__))

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "stringValue" f InputOption InputOption a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (InputOption'StringValue x__val) -> Prelude.Just
                                                                              x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap InputOption'StringValue y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))

instance (a ~ Prelude.Maybe Prelude.Bool,
          b ~ Prelude.Maybe Prelude.Bool, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'boolValue" f InputOption InputOption a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (InputOption'BoolValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap InputOption'BoolValue y__))

instance (a ~ Prelude.Bool, b ~ Prelude.Bool, Prelude.Functor f) =>
         Lens.Labels.HasLens "boolValue" f InputOption InputOption a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (InputOption'BoolValue x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap InputOption'BoolValue y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))

instance Data.Default.Class.Default InputOption where
        def
          = InputOption{_InputOption'key = Data.ProtoLens.fieldDefault,
                        _InputOption'value = Prelude.Nothing}

instance Data.ProtoLens.Message InputOption where
        descriptor
          = let key__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "key"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional key)
                      :: Data.ProtoLens.FieldDescriptor InputOption
                intValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "int_value"
                      (Data.ProtoLens.Int32Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
                      (Data.ProtoLens.OptionalField maybe'intValue)
                      :: Data.ProtoLens.FieldDescriptor InputOption
                doubleValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "double_value"
                      (Data.ProtoLens.DoubleField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Double)
                      (Data.ProtoLens.OptionalField maybe'doubleValue)
                      :: Data.ProtoLens.FieldDescriptor InputOption
                stringValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "string_value"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.OptionalField maybe'stringValue)
                      :: Data.ProtoLens.FieldDescriptor InputOption
                boolValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "bool_value"
                      (Data.ProtoLens.BoolField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
                      (Data.ProtoLens.OptionalField maybe'boolValue)
                      :: Data.ProtoLens.FieldDescriptor InputOption
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.InputOption")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, key__field_descriptor),
                    (Data.ProtoLens.Tag 2, intValue__field_descriptor),
                    (Data.ProtoLens.Tag 3, doubleValue__field_descriptor),
                    (Data.ProtoLens.Tag 4, stringValue__field_descriptor),
                    (Data.ProtoLens.Tag 5, boolValue__field_descriptor)])
                (Data.Map.fromList
                   [("key", key__field_descriptor),
                    ("int_value", intValue__field_descriptor),
                    ("double_value", doubleValue__field_descriptor),
                    ("string_value", stringValue__field_descriptor),
                    ("bool_value", boolValue__field_descriptor)])

data ResourcePath = ResourcePath{_ResourcePath'uri ::
                                 !Data.Text.Text}
                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "uri" f ResourcePath ResourcePath a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ResourcePath'uri
                 (\ x__ y__ -> x__{_ResourcePath'uri = y__}))
              Prelude.id

instance Data.Default.Class.Default ResourcePath where
        def = ResourcePath{_ResourcePath'uri = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ResourcePath where
        descriptor
          = let uri__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "uri"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional uri)
                      :: Data.ProtoLens.FieldDescriptor ResourcePath
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ResourcePath")
                (Data.Map.fromList [(Data.ProtoLens.Tag 1, uri__field_descriptor)])
                (Data.Map.fromList [("uri", uri__field_descriptor)])

data ResourceStamp = ResourceStamp{_ResourceStamp'data' ::
                                   !Data.Text.Text}
                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "data'" f ResourceStamp ResourceStamp a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ResourceStamp'data'
                 (\ x__ y__ -> x__{_ResourceStamp'data' = y__}))
              Prelude.id

instance Data.Default.Class.Default ResourceStamp where
        def
          = ResourceStamp{_ResourceStamp'data' = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ResourceStamp where
        descriptor
          = let data'__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional data')
                      :: Data.ProtoLens.FieldDescriptor ResourceStamp
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ResourceStamp")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, data'__field_descriptor)])
                (Data.Map.fromList [("data", data'__field_descriptor)])

data SourceDescription = SourceDescription{_SourceDescription'path
                                           :: !Data.Text.Text,
                                           _SourceDescription'source :: !Data.Text.Text,
                                           _SourceDescription'schema ::
                                           !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType),
                                           _SourceDescription'options :: ![InputOption],
                                           _SourceDescription'stamp :: !Data.Text.Text}
                       deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "path" f SourceDescription SourceDescription a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SourceDescription'path
                 (\ x__ y__ -> x__{_SourceDescription'path = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "source" f SourceDescription SourceDescription
         a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SourceDescription'source
                 (\ x__ y__ -> x__{_SourceDescription'source = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Types.SQLType,
          b ~ Proto.Karps.Proto.Types.SQLType, Prelude.Functor f) =>
         Lens.Labels.HasLens "schema" f SourceDescription SourceDescription
         a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SourceDescription'schema
                 (\ x__ y__ -> x__{_SourceDescription'schema = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          b ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'schema" f SourceDescription
         SourceDescription a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SourceDescription'schema
                 (\ x__ y__ -> x__{_SourceDescription'schema = y__}))
              Prelude.id

instance (a ~ [InputOption], b ~ [InputOption],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "options" f SourceDescription SourceDescription
         a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SourceDescription'options
                 (\ x__ y__ -> x__{_SourceDescription'options = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "stamp" f SourceDescription SourceDescription a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SourceDescription'stamp
                 (\ x__ y__ -> x__{_SourceDescription'stamp = y__}))
              Prelude.id

instance Data.Default.Class.Default SourceDescription where
        def
          = SourceDescription{_SourceDescription'path =
                                Data.ProtoLens.fieldDefault,
                              _SourceDescription'source = Data.ProtoLens.fieldDefault,
                              _SourceDescription'schema = Prelude.Nothing,
                              _SourceDescription'options = [],
                              _SourceDescription'stamp = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message SourceDescription where
        descriptor
          = let path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional path)
                      :: Data.ProtoLens.FieldDescriptor SourceDescription
                source__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "source"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional source)
                      :: Data.ProtoLens.FieldDescriptor SourceDescription
                schema__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "schema"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField maybe'schema)
                      :: Data.ProtoLens.FieldDescriptor SourceDescription
                options__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "options"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor InputOption)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked options)
                      :: Data.ProtoLens.FieldDescriptor SourceDescription
                stamp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "stamp"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional stamp)
                      :: Data.ProtoLens.FieldDescriptor SourceDescription
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.SourceDescription")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, path__field_descriptor),
                    (Data.ProtoLens.Tag 2, source__field_descriptor),
                    (Data.ProtoLens.Tag 3, schema__field_descriptor),
                    (Data.ProtoLens.Tag 4, options__field_descriptor),
                    (Data.ProtoLens.Tag 5, stamp__field_descriptor)])
                (Data.Map.fromList
                   [("path", path__field_descriptor),
                    ("source", source__field_descriptor),
                    ("schema", schema__field_descriptor),
                    ("options", options__field_descriptor),
                    ("stamp", stamp__field_descriptor)])

boolValue ::
          forall f s t a b . Lens.Labels.HasLens "boolValue" f s t a b =>
            Lens.Family2.LensLike f s t a b
boolValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "boolValue")

data' ::
      forall f s t a b . Lens.Labels.HasLens "data'" f s t a b =>
        Lens.Family2.LensLike f s t a b
data'
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "data'")

doubleValue ::
            forall f s t a b . Lens.Labels.HasLens "doubleValue" f s t a b =>
              Lens.Family2.LensLike f s t a b
doubleValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "doubleValue")

intValue ::
         forall f s t a b . Lens.Labels.HasLens "intValue" f s t a b =>
           Lens.Family2.LensLike f s t a b
intValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "intValue")

key ::
    forall f s t a b . Lens.Labels.HasLens "key" f s t a b =>
      Lens.Family2.LensLike f s t a b
key
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "key")

maybe'boolValue ::
                forall f s t a b .
                  Lens.Labels.HasLens "maybe'boolValue" f s t a b =>
                  Lens.Family2.LensLike f s t a b
maybe'boolValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'boolValue")

maybe'doubleValue ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'doubleValue" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'doubleValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'doubleValue")

maybe'intValue ::
               forall f s t a b .
                 Lens.Labels.HasLens "maybe'intValue" f s t a b =>
                 Lens.Family2.LensLike f s t a b
maybe'intValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'intValue")

maybe'schema ::
             forall f s t a b . Lens.Labels.HasLens "maybe'schema" f s t a b =>
               Lens.Family2.LensLike f s t a b
maybe'schema
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'schema")

maybe'stringValue ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'stringValue" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'stringValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'stringValue")

maybe'value ::
            forall f s t a b . Lens.Labels.HasLens "maybe'value" f s t a b =>
              Lens.Family2.LensLike f s t a b
maybe'value
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'value")

options ::
        forall f s t a b . Lens.Labels.HasLens "options" f s t a b =>
          Lens.Family2.LensLike f s t a b
options
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "options")

path ::
     forall f s t a b . Lens.Labels.HasLens "path" f s t a b =>
       Lens.Family2.LensLike f s t a b
path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")

schema ::
       forall f s t a b . Lens.Labels.HasLens "schema" f s t a b =>
         Lens.Family2.LensLike f s t a b
schema
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "schema")

source ::
       forall f s t a b . Lens.Labels.HasLens "source" f s t a b =>
         Lens.Family2.LensLike f s t a b
source
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "source")

stamp ::
      forall f s t a b . Lens.Labels.HasLens "stamp" f s t a b =>
        Lens.Family2.LensLike f s t a b
stamp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "stamp")

stringValue ::
            forall f s t a b . Lens.Labels.HasLens "stringValue" f s t a b =>
              Lens.Family2.LensLike f s t a b
stringValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "stringValue")

uri ::
    forall f s t a b . Lens.Labels.HasLens "uri" f s t a b =>
      Lens.Family2.LensLike f s t a b
uri
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "uri")