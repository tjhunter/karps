{- This file was auto-generated from karps/proto/row.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Row
       (ArrayCell(..), Cell(..), Cell'Element(..), _Cell'IntValue,
        _Cell'StringValue, _Cell'DoubleValue, _Cell'BoolValue,
        _Cell'ArrayValue, _Cell'StructValue, CellWithType(..), Row(..))
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

    * 'Proto.Karps.Proto.Row_Fields.values' @:: Lens' ArrayCell [Cell]@
 -}
data ArrayCell = ArrayCell{_ArrayCell'values :: ![Cell],
                           _ArrayCell'_unknownFields :: !Data.ProtoLens.FieldSet}
                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ArrayCell x a, a ~ b) =>
         Lens.Labels.HasLens f ArrayCell ArrayCell x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ArrayCell "values" ([Cell])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ArrayCell'values
                 (\ x__ y__ -> x__{_ArrayCell'values = y__}))
              Prelude.id
instance Data.Default.Class.Default ArrayCell where
        def
          = ArrayCell{_ArrayCell'values = [],
                      _ArrayCell'_unknownFields = ([])}
instance Data.ProtoLens.Message ArrayCell where
        messageName _ = Data.Text.pack "karps.core.ArrayCell"
        fieldsByTag
          = let values__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "values"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Cell)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "values")))
                      :: Data.ProtoLens.FieldDescriptor ArrayCell
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, values__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ArrayCell'_unknownFields
              (\ x__ y__ -> x__{_ArrayCell'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Row_Fields.maybe'element' @:: Lens' Cell (Prelude.Maybe Cell'Element)@
    * 'Proto.Karps.Proto.Row_Fields.maybe'intValue' @:: Lens' Cell (Prelude.Maybe Data.Int.Int32)@
    * 'Proto.Karps.Proto.Row_Fields.intValue' @:: Lens' Cell Data.Int.Int32@
    * 'Proto.Karps.Proto.Row_Fields.maybe'stringValue' @:: Lens' Cell (Prelude.Maybe Data.Text.Text)@
    * 'Proto.Karps.Proto.Row_Fields.stringValue' @:: Lens' Cell Data.Text.Text@
    * 'Proto.Karps.Proto.Row_Fields.maybe'doubleValue' @:: Lens' Cell (Prelude.Maybe Prelude.Double)@
    * 'Proto.Karps.Proto.Row_Fields.doubleValue' @:: Lens' Cell Prelude.Double@
    * 'Proto.Karps.Proto.Row_Fields.maybe'boolValue' @:: Lens' Cell (Prelude.Maybe Prelude.Bool)@
    * 'Proto.Karps.Proto.Row_Fields.boolValue' @:: Lens' Cell Prelude.Bool@
    * 'Proto.Karps.Proto.Row_Fields.maybe'arrayValue' @:: Lens' Cell (Prelude.Maybe ArrayCell)@
    * 'Proto.Karps.Proto.Row_Fields.arrayValue' @:: Lens' Cell ArrayCell@
    * 'Proto.Karps.Proto.Row_Fields.maybe'structValue' @:: Lens' Cell (Prelude.Maybe Row)@
    * 'Proto.Karps.Proto.Row_Fields.structValue' @:: Lens' Cell Row@
 -}
data Cell = Cell{_Cell'element :: !(Prelude.Maybe Cell'Element),
                 _Cell'_unknownFields :: !Data.ProtoLens.FieldSet}
              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
data Cell'Element = Cell'IntValue !Data.Int.Int32
                  | Cell'StringValue !Data.Text.Text
                  | Cell'DoubleValue !Prelude.Double
                  | Cell'BoolValue !Prelude.Bool
                  | Cell'ArrayValue !ArrayCell
                  | Cell'StructValue !Row
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f Cell x a, a ~ b) =>
         Lens.Labels.HasLens f Cell Cell x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "maybe'element"
           (Prelude.Maybe Cell'Element)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "maybe'intValue"
           (Prelude.Maybe Data.Int.Int32)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'IntValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'IntValue y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "intValue" (Data.Int.Int32)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Cell'IntValue x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Cell'IntValue y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "maybe'stringValue"
           (Prelude.Maybe Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'StringValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'StringValue y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "stringValue" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Cell'StringValue x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Cell'StringValue y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "maybe'doubleValue"
           (Prelude.Maybe Prelude.Double)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'DoubleValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'DoubleValue y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "doubleValue" (Prelude.Double)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Cell'DoubleValue x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Cell'DoubleValue y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "maybe'boolValue"
           (Prelude.Maybe Prelude.Bool)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'BoolValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'BoolValue y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "boolValue" (Prelude.Bool)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Cell'BoolValue x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Cell'BoolValue y__))
                 (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "maybe'arrayValue"
           (Prelude.Maybe ArrayCell)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'ArrayValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'ArrayValue y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "arrayValue" (ArrayCell)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Cell'ArrayValue x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Cell'ArrayValue y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "maybe'structValue" (Prelude.Maybe Row)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'StructValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'StructValue y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Cell "structValue" (Row)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Cell'StructValue x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Cell'StructValue y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))
instance Data.Default.Class.Default Cell where
        def
          = Cell{_Cell'element = Prelude.Nothing,
                 _Cell'_unknownFields = ([])}
instance Data.ProtoLens.Message Cell where
        messageName _ = Data.Text.pack "karps.core.Cell"
        fieldsByTag
          = let intValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "int_value"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'intValue")))
                      :: Data.ProtoLens.FieldDescriptor Cell
                stringValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "string_value"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'stringValue")))
                      :: Data.ProtoLens.FieldDescriptor Cell
                doubleValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "double_value"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.DoubleField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Double)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'doubleValue")))
                      :: Data.ProtoLens.FieldDescriptor Cell
                boolValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "bool_value"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'boolValue")))
                      :: Data.ProtoLens.FieldDescriptor Cell
                arrayValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "array_value"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ArrayCell)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'arrayValue")))
                      :: Data.ProtoLens.FieldDescriptor Cell
                structValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "struct_value"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Row)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'structValue")))
                      :: Data.ProtoLens.FieldDescriptor Cell
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 2, intValue__field_descriptor),
                 (Data.ProtoLens.Tag 3, stringValue__field_descriptor),
                 (Data.ProtoLens.Tag 5, doubleValue__field_descriptor),
                 (Data.ProtoLens.Tag 6, boolValue__field_descriptor),
                 (Data.ProtoLens.Tag 10, arrayValue__field_descriptor),
                 (Data.ProtoLens.Tag 11, structValue__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _Cell'_unknownFields
              (\ x__ y__ -> x__{_Cell'_unknownFields = y__})
_Cell'IntValue ::
               Lens.Labels.Prism.Prism' Cell'Element Data.Int.Int32
_Cell'IntValue
  = Lens.Labels.Prism.prism' Cell'IntValue
      (\ p__ ->
         case p__ of
             Cell'IntValue p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_Cell'StringValue ::
                  Lens.Labels.Prism.Prism' Cell'Element Data.Text.Text
_Cell'StringValue
  = Lens.Labels.Prism.prism' Cell'StringValue
      (\ p__ ->
         case p__ of
             Cell'StringValue p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_Cell'DoubleValue ::
                  Lens.Labels.Prism.Prism' Cell'Element Prelude.Double
_Cell'DoubleValue
  = Lens.Labels.Prism.prism' Cell'DoubleValue
      (\ p__ ->
         case p__ of
             Cell'DoubleValue p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_Cell'BoolValue ::
                Lens.Labels.Prism.Prism' Cell'Element Prelude.Bool
_Cell'BoolValue
  = Lens.Labels.Prism.prism' Cell'BoolValue
      (\ p__ ->
         case p__ of
             Cell'BoolValue p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_Cell'ArrayValue :: Lens.Labels.Prism.Prism' Cell'Element ArrayCell
_Cell'ArrayValue
  = Lens.Labels.Prism.prism' Cell'ArrayValue
      (\ p__ ->
         case p__ of
             Cell'ArrayValue p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_Cell'StructValue :: Lens.Labels.Prism.Prism' Cell'Element Row
_Cell'StructValue
  = Lens.Labels.Prism.prism' Cell'StructValue
      (\ p__ ->
         case p__ of
             Cell'StructValue p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
{- | Fields :

    * 'Proto.Karps.Proto.Row_Fields.cell' @:: Lens' CellWithType Cell@
    * 'Proto.Karps.Proto.Row_Fields.maybe'cell' @:: Lens' CellWithType (Prelude.Maybe Cell)@
    * 'Proto.Karps.Proto.Row_Fields.cellType' @:: Lens' CellWithType Proto.Karps.Proto.Types.SQLType@
    * 'Proto.Karps.Proto.Row_Fields.maybe'cellType' @:: Lens' CellWithType (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)@
 -}
data CellWithType = CellWithType{_CellWithType'cell ::
                                 !(Prelude.Maybe Cell),
                                 _CellWithType'cellType ::
                                 !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType),
                                 _CellWithType'_unknownFields :: !Data.ProtoLens.FieldSet}
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f CellWithType x a, a ~ b) =>
         Lens.Labels.HasLens f CellWithType CellWithType x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CellWithType "cell" (Cell)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CellWithType'cell
                 (\ x__ y__ -> x__{_CellWithType'cell = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CellWithType "maybe'cell"
           (Prelude.Maybe Cell)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CellWithType'cell
                 (\ x__ y__ -> x__{_CellWithType'cell = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CellWithType "cellType"
           (Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CellWithType'cellType
                 (\ x__ y__ -> x__{_CellWithType'cellType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f CellWithType "maybe'cellType"
           (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CellWithType'cellType
                 (\ x__ y__ -> x__{_CellWithType'cellType = y__}))
              Prelude.id
instance Data.Default.Class.Default CellWithType where
        def
          = CellWithType{_CellWithType'cell = Prelude.Nothing,
                         _CellWithType'cellType = Prelude.Nothing,
                         _CellWithType'_unknownFields = ([])}
instance Data.ProtoLens.Message CellWithType where
        messageName _ = Data.Text.pack "karps.core.CellWithType"
        fieldsByTag
          = let cell__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "cell"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Cell)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'cell")))
                      :: Data.ProtoLens.FieldDescriptor CellWithType
                cellType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "cell_type"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'cellType")))
                      :: Data.ProtoLens.FieldDescriptor CellWithType
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, cell__field_descriptor),
                 (Data.ProtoLens.Tag 2, cellType__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _CellWithType'_unknownFields
              (\ x__ y__ -> x__{_CellWithType'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Row_Fields.values' @:: Lens' Row [Cell]@
 -}
data Row = Row{_Row'values :: ![Cell],
               _Row'_unknownFields :: !Data.ProtoLens.FieldSet}
             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f Row x a, a ~ b) =>
         Lens.Labels.HasLens f Row Row x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Row "values" ([Cell])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Row'values
                 (\ x__ y__ -> x__{_Row'values = y__}))
              Prelude.id
instance Data.Default.Class.Default Row where
        def = Row{_Row'values = [], _Row'_unknownFields = ([])}
instance Data.ProtoLens.Message Row where
        messageName _ = Data.Text.pack "karps.core.Row"
        fieldsByTag
          = let values__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "values"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Cell)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "values")))
                      :: Data.ProtoLens.FieldDescriptor Row
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, values__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _Row'_unknownFields
              (\ x__ y__ -> x__{_Row'_unknownFields = y__})