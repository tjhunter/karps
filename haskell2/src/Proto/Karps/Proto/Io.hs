{- This file was auto-generated from karps/proto/io.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Io
       (InputOption(..), InputOption'Value(..), _InputOption'IntValue,
        _InputOption'DoubleValue, _InputOption'StringValue,
        _InputOption'BoolValue, ResourcePath(..), ResourceStamp(..),
        SourceDescription(..))
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
import qualified Proto.Karps.Proto.Types

{- | Fields :

    * 'Proto.Karps.Proto.Io_Fields.key' @:: Lens' InputOption Data.Text.Text@
    * 'Proto.Karps.Proto.Io_Fields.maybe'value' @:: Lens' InputOption (Prelude.Maybe InputOption'Value)@
    * 'Proto.Karps.Proto.Io_Fields.maybe'intValue' @:: Lens' InputOption (Prelude.Maybe Data.Int.Int32)@
    * 'Proto.Karps.Proto.Io_Fields.intValue' @:: Lens' InputOption Data.Int.Int32@
    * 'Proto.Karps.Proto.Io_Fields.maybe'doubleValue' @:: Lens' InputOption (Prelude.Maybe Prelude.Double)@
    * 'Proto.Karps.Proto.Io_Fields.doubleValue' @:: Lens' InputOption Prelude.Double@
    * 'Proto.Karps.Proto.Io_Fields.maybe'stringValue' @:: Lens' InputOption (Prelude.Maybe Data.Text.Text)@
    * 'Proto.Karps.Proto.Io_Fields.stringValue' @:: Lens' InputOption Data.Text.Text@
    * 'Proto.Karps.Proto.Io_Fields.maybe'boolValue' @:: Lens' InputOption (Prelude.Maybe Prelude.Bool)@
    * 'Proto.Karps.Proto.Io_Fields.boolValue' @:: Lens' InputOption Prelude.Bool@
 -}
data InputOption = InputOption{_InputOption'key :: !Data.Text.Text,
                               _InputOption'value :: !(Prelude.Maybe InputOption'Value),
                               _InputOption'_unknownFields :: !Data.ProtoLens.FieldSet}
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
data InputOption'Value = InputOption'IntValue !Data.Int.Int32
                       | InputOption'DoubleValue !Prelude.Double
                       | InputOption'StringValue !Data.Text.Text
                       | InputOption'BoolValue !Prelude.Bool
                           deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f InputOption x a, a ~ b) =>
         Lens.Labels.HasLens f InputOption InputOption x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f InputOption "key" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'key
                 (\ x__ y__ -> x__{_InputOption'key = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f InputOption "maybe'value"
           (Prelude.Maybe InputOption'Value)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f InputOption "maybe'intValue"
           (Prelude.Maybe Data.Int.Int32)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (InputOption'IntValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap InputOption'IntValue y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f InputOption "intValue" (Data.Int.Int32)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f InputOption "maybe'doubleValue"
           (Prelude.Maybe Prelude.Double)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f InputOption "doubleValue" (Prelude.Double)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f InputOption "maybe'stringValue"
           (Prelude.Maybe Data.Text.Text)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f InputOption "stringValue" (Data.Text.Text)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f InputOption "maybe'boolValue"
           (Prelude.Maybe Prelude.Bool)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _InputOption'value
                 (\ x__ y__ -> x__{_InputOption'value = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (InputOption'BoolValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap InputOption'BoolValue y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f InputOption "boolValue" (Prelude.Bool)
         where
        lensOf' _
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
                        _InputOption'value = Prelude.Nothing,
                        _InputOption'_unknownFields = ([])}
instance Data.ProtoLens.Message InputOption where
        messageName _ = Data.Text.pack "karps.core.InputOption"
        fieldsByTag
          = let key__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "key"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "key")))
                      :: Data.ProtoLens.FieldDescriptor InputOption
                intValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "int_value"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'intValue")))
                      :: Data.ProtoLens.FieldDescriptor InputOption
                doubleValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "double_value"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.DoubleField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Double)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'doubleValue")))
                      :: Data.ProtoLens.FieldDescriptor InputOption
                stringValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "string_value"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'stringValue")))
                      :: Data.ProtoLens.FieldDescriptor InputOption
                boolValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "bool_value"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'boolValue")))
                      :: Data.ProtoLens.FieldDescriptor InputOption
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, key__field_descriptor),
                 (Data.ProtoLens.Tag 2, intValue__field_descriptor),
                 (Data.ProtoLens.Tag 3, doubleValue__field_descriptor),
                 (Data.ProtoLens.Tag 4, stringValue__field_descriptor),
                 (Data.ProtoLens.Tag 5, boolValue__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _InputOption'_unknownFields
              (\ x__ y__ -> x__{_InputOption'_unknownFields = y__})
_InputOption'IntValue ::
                      Lens.Labels.Prism.Prism' InputOption'Value Data.Int.Int32
_InputOption'IntValue
  = Lens.Labels.Prism.prism' InputOption'IntValue
      (\ p__ ->
         case p__ of
             InputOption'IntValue p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_InputOption'DoubleValue ::
                         Lens.Labels.Prism.Prism' InputOption'Value Prelude.Double
_InputOption'DoubleValue
  = Lens.Labels.Prism.prism' InputOption'DoubleValue
      (\ p__ ->
         case p__ of
             InputOption'DoubleValue p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_InputOption'StringValue ::
                         Lens.Labels.Prism.Prism' InputOption'Value Data.Text.Text
_InputOption'StringValue
  = Lens.Labels.Prism.prism' InputOption'StringValue
      (\ p__ ->
         case p__ of
             InputOption'StringValue p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_InputOption'BoolValue ::
                       Lens.Labels.Prism.Prism' InputOption'Value Prelude.Bool
_InputOption'BoolValue
  = Lens.Labels.Prism.prism' InputOption'BoolValue
      (\ p__ ->
         case p__ of
             InputOption'BoolValue p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
{- | Fields :

    * 'Proto.Karps.Proto.Io_Fields.uri' @:: Lens' ResourcePath Data.Text.Text@
 -}
data ResourcePath = ResourcePath{_ResourcePath'uri ::
                                 !Data.Text.Text,
                                 _ResourcePath'_unknownFields :: !Data.ProtoLens.FieldSet}
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ResourcePath x a, a ~ b) =>
         Lens.Labels.HasLens f ResourcePath ResourcePath x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ResourcePath "uri" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ResourcePath'uri
                 (\ x__ y__ -> x__{_ResourcePath'uri = y__}))
              Prelude.id
instance Data.Default.Class.Default ResourcePath where
        def
          = ResourcePath{_ResourcePath'uri = Data.ProtoLens.fieldDefault,
                         _ResourcePath'_unknownFields = ([])}
instance Data.ProtoLens.Message ResourcePath where
        messageName _ = Data.Text.pack "karps.core.ResourcePath"
        fieldsByTag
          = let uri__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "uri"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "uri")))
                      :: Data.ProtoLens.FieldDescriptor ResourcePath
              in
              Data.Map.fromList [(Data.ProtoLens.Tag 1, uri__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ResourcePath'_unknownFields
              (\ x__ y__ -> x__{_ResourcePath'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Io_Fields.data'' @:: Lens' ResourceStamp Data.Text.Text@
 -}
data ResourceStamp = ResourceStamp{_ResourceStamp'data' ::
                                   !Data.Text.Text,
                                   _ResourceStamp'_unknownFields :: !Data.ProtoLens.FieldSet}
                       deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ResourceStamp x a, a ~ b) =>
         Lens.Labels.HasLens f ResourceStamp ResourceStamp x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ResourceStamp "data'" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ResourceStamp'data'
                 (\ x__ y__ -> x__{_ResourceStamp'data' = y__}))
              Prelude.id
instance Data.Default.Class.Default ResourceStamp where
        def
          = ResourceStamp{_ResourceStamp'data' = Data.ProtoLens.fieldDefault,
                          _ResourceStamp'_unknownFields = ([])}
instance Data.ProtoLens.Message ResourceStamp where
        messageName _ = Data.Text.pack "karps.core.ResourceStamp"
        fieldsByTag
          = let data'__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "data'")))
                      :: Data.ProtoLens.FieldDescriptor ResourceStamp
              in
              Data.Map.fromList [(Data.ProtoLens.Tag 1, data'__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ResourceStamp'_unknownFields
              (\ x__ y__ -> x__{_ResourceStamp'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Io_Fields.path' @:: Lens' SourceDescription Data.Text.Text@
    * 'Proto.Karps.Proto.Io_Fields.source' @:: Lens' SourceDescription Data.Text.Text@
    * 'Proto.Karps.Proto.Io_Fields.schema' @:: Lens' SourceDescription Proto.Karps.Proto.Types.SQLType@
    * 'Proto.Karps.Proto.Io_Fields.maybe'schema' @:: Lens' SourceDescription
  (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)@
    * 'Proto.Karps.Proto.Io_Fields.options' @:: Lens' SourceDescription [InputOption]@
    * 'Proto.Karps.Proto.Io_Fields.stamp' @:: Lens' SourceDescription Data.Text.Text@
 -}
data SourceDescription = SourceDescription{_SourceDescription'path
                                           :: !Data.Text.Text,
                                           _SourceDescription'source :: !Data.Text.Text,
                                           _SourceDescription'schema ::
                                           !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType),
                                           _SourceDescription'options :: ![InputOption],
                                           _SourceDescription'stamp :: !Data.Text.Text,
                                           _SourceDescription'_unknownFields ::
                                           !Data.ProtoLens.FieldSet}
                           deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f SourceDescription x a, a ~ b) =>
         Lens.Labels.HasLens f SourceDescription SourceDescription x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SourceDescription "path" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SourceDescription'path
                 (\ x__ y__ -> x__{_SourceDescription'path = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SourceDescription "source" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SourceDescription'source
                 (\ x__ y__ -> x__{_SourceDescription'source = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SourceDescription "schema"
           (Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SourceDescription'schema
                 (\ x__ y__ -> x__{_SourceDescription'schema = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SourceDescription "maybe'schema"
           (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SourceDescription'schema
                 (\ x__ y__ -> x__{_SourceDescription'schema = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SourceDescription "options" ([InputOption])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SourceDescription'options
                 (\ x__ y__ -> x__{_SourceDescription'options = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SourceDescription "stamp" (Data.Text.Text)
         where
        lensOf' _
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
                              _SourceDescription'stamp = Data.ProtoLens.fieldDefault,
                              _SourceDescription'_unknownFields = ([])}
instance Data.ProtoLens.Message SourceDescription where
        messageName _ = Data.Text.pack "karps.core.SourceDescription"
        fieldsByTag
          = let path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")))
                      :: Data.ProtoLens.FieldDescriptor SourceDescription
                source__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "source"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "source")))
                      :: Data.ProtoLens.FieldDescriptor SourceDescription
                schema__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "schema"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'schema")))
                      :: Data.ProtoLens.FieldDescriptor SourceDescription
                options__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "options"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor InputOption)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "options")))
                      :: Data.ProtoLens.FieldDescriptor SourceDescription
                stamp__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "stamp"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "stamp")))
                      :: Data.ProtoLens.FieldDescriptor SourceDescription
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, path__field_descriptor),
                 (Data.ProtoLens.Tag 2, source__field_descriptor),
                 (Data.ProtoLens.Tag 3, schema__field_descriptor),
                 (Data.ProtoLens.Tag 4, options__field_descriptor),
                 (Data.ProtoLens.Tag 5, stamp__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _SourceDescription'_unknownFields
              (\ x__ y__ -> x__{_SourceDescription'_unknownFields = y__})