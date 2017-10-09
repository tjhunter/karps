{- This file was auto-generated from karps/proto/row.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Karps.Proto.Row where
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

data ArrayCell = ArrayCell{_ArrayCell'values :: ![Cell]}
               deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [Cell], b ~ [Cell], Prelude.Functor f) =>
         Lens.Labels.HasLens "values" f ArrayCell ArrayCell a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ArrayCell'values
                 (\ x__ y__ -> x__{_ArrayCell'values = y__}))
              Prelude.id

instance Data.Default.Class.Default ArrayCell where
        def = ArrayCell{_ArrayCell'values = []}

instance Data.ProtoLens.Message ArrayCell where
        descriptor
          = let values__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "values"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Cell)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked values)
                      :: Data.ProtoLens.FieldDescriptor ArrayCell
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ArrayCell")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, values__field_descriptor)])
                (Data.Map.fromList [("values", values__field_descriptor)])

data Cell = Cell{_Cell'element :: !(Prelude.Maybe Cell'Element)}
          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

data Cell'Element = Cell'IntValue !Data.Int.Int32
                  | Cell'StringValue !Data.Text.Text
                  | Cell'DoubleValue !Prelude.Double
                  | Cell'BoolValue !Prelude.Bool
                  | Cell'ArrayValue !ArrayCell
                  | Cell'StructValue !Row
                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Prelude.Maybe Cell'Element,
          b ~ Prelude.Maybe Cell'Element, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'element" f Cell Cell a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe Data.Int.Int32,
          b ~ Prelude.Maybe Data.Int.Int32, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'intValue" f Cell Cell a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'IntValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'IntValue y__))

instance (a ~ Data.Int.Int32, b ~ Data.Int.Int32,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "intValue" f Cell Cell a b where
        lensOf _
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

instance (a ~ Prelude.Maybe Data.Text.Text,
          b ~ Prelude.Maybe Data.Text.Text, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'stringValue" f Cell Cell a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'StringValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'StringValue y__))

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "stringValue" f Cell Cell a b where
        lensOf _
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

instance (a ~ Prelude.Maybe Prelude.Double,
          b ~ Prelude.Maybe Prelude.Double, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'doubleValue" f Cell Cell a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'DoubleValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'DoubleValue y__))

instance (a ~ Prelude.Double, b ~ Prelude.Double,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "doubleValue" f Cell Cell a b where
        lensOf _
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

instance (a ~ Prelude.Maybe Prelude.Bool,
          b ~ Prelude.Maybe Prelude.Bool, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'boolValue" f Cell Cell a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'BoolValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'BoolValue y__))

instance (a ~ Prelude.Bool, b ~ Prelude.Bool, Prelude.Functor f) =>
         Lens.Labels.HasLens "boolValue" f Cell Cell a b where
        lensOf _
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

instance (a ~ Prelude.Maybe ArrayCell, b ~ Prelude.Maybe ArrayCell,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'arrayValue" f Cell Cell a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'ArrayValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'ArrayValue y__))

instance (a ~ ArrayCell, b ~ ArrayCell, Prelude.Functor f) =>
         Lens.Labels.HasLens "arrayValue" f Cell Cell a b where
        lensOf _
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

instance (a ~ Prelude.Maybe Row, b ~ Prelude.Maybe Row,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'structValue" f Cell Cell a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Cell'element
                 (\ x__ y__ -> x__{_Cell'element = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Cell'StructValue x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Cell'StructValue y__))

instance (a ~ Row, b ~ Row, Prelude.Functor f) =>
         Lens.Labels.HasLens "structValue" f Cell Cell a b where
        lensOf _
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
        def = Cell{_Cell'element = Prelude.Nothing}

instance Data.ProtoLens.Message Cell where
        descriptor
          = let intValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "int_value"
                      (Data.ProtoLens.Int32Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
                      (Data.ProtoLens.OptionalField maybe'intValue)
                      :: Data.ProtoLens.FieldDescriptor Cell
                stringValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "string_value"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.OptionalField maybe'stringValue)
                      :: Data.ProtoLens.FieldDescriptor Cell
                doubleValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "double_value"
                      (Data.ProtoLens.DoubleField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Double)
                      (Data.ProtoLens.OptionalField maybe'doubleValue)
                      :: Data.ProtoLens.FieldDescriptor Cell
                boolValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "bool_value"
                      (Data.ProtoLens.BoolField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
                      (Data.ProtoLens.OptionalField maybe'boolValue)
                      :: Data.ProtoLens.FieldDescriptor Cell
                arrayValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "array_value"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ArrayCell)
                      (Data.ProtoLens.OptionalField maybe'arrayValue)
                      :: Data.ProtoLens.FieldDescriptor Cell
                structValue__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "struct_value"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Row)
                      (Data.ProtoLens.OptionalField maybe'structValue)
                      :: Data.ProtoLens.FieldDescriptor Cell
              in
              Data.ProtoLens.MessageDescriptor (Data.Text.pack "karps.core.Cell")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 2, intValue__field_descriptor),
                    (Data.ProtoLens.Tag 3, stringValue__field_descriptor),
                    (Data.ProtoLens.Tag 5, doubleValue__field_descriptor),
                    (Data.ProtoLens.Tag 6, boolValue__field_descriptor),
                    (Data.ProtoLens.Tag 10, arrayValue__field_descriptor),
                    (Data.ProtoLens.Tag 11, structValue__field_descriptor)])
                (Data.Map.fromList
                   [("int_value", intValue__field_descriptor),
                    ("string_value", stringValue__field_descriptor),
                    ("double_value", doubleValue__field_descriptor),
                    ("bool_value", boolValue__field_descriptor),
                    ("array_value", arrayValue__field_descriptor),
                    ("struct_value", structValue__field_descriptor)])

data CellWithType = CellWithType{_CellWithType'cell ::
                                 !(Prelude.Maybe Cell),
                                 _CellWithType'cellType ::
                                 !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType)}
                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Cell, b ~ Cell, Prelude.Functor f) =>
         Lens.Labels.HasLens "cell" f CellWithType CellWithType a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CellWithType'cell
                 (\ x__ y__ -> x__{_CellWithType'cell = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Cell, b ~ Prelude.Maybe Cell,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'cell" f CellWithType CellWithType a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CellWithType'cell
                 (\ x__ y__ -> x__{_CellWithType'cell = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Types.SQLType,
          b ~ Proto.Karps.Proto.Types.SQLType, Prelude.Functor f) =>
         Lens.Labels.HasLens "cellType" f CellWithType CellWithType a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CellWithType'cellType
                 (\ x__ y__ -> x__{_CellWithType'cellType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          b ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'cellType" f CellWithType CellWithType a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CellWithType'cellType
                 (\ x__ y__ -> x__{_CellWithType'cellType = y__}))
              Prelude.id

instance Data.Default.Class.Default CellWithType where
        def
          = CellWithType{_CellWithType'cell = Prelude.Nothing,
                         _CellWithType'cellType = Prelude.Nothing}

instance Data.ProtoLens.Message CellWithType where
        descriptor
          = let cell__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "cell"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Cell)
                      (Data.ProtoLens.OptionalField maybe'cell)
                      :: Data.ProtoLens.FieldDescriptor CellWithType
                cellType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "cell_type"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField maybe'cellType)
                      :: Data.ProtoLens.FieldDescriptor CellWithType
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.CellWithType")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, cell__field_descriptor),
                    (Data.ProtoLens.Tag 2, cellType__field_descriptor)])
                (Data.Map.fromList
                   [("cell", cell__field_descriptor),
                    ("cell_type", cellType__field_descriptor)])

data Row = Row{_Row'values :: ![Cell]}
         deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [Cell], b ~ [Cell], Prelude.Functor f) =>
         Lens.Labels.HasLens "values" f Row Row a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Row'values
                 (\ x__ y__ -> x__{_Row'values = y__}))
              Prelude.id

instance Data.Default.Class.Default Row where
        def = Row{_Row'values = []}

instance Data.ProtoLens.Message Row where
        descriptor
          = let values__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "values"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Cell)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked values)
                      :: Data.ProtoLens.FieldDescriptor Row
              in
              Data.ProtoLens.MessageDescriptor (Data.Text.pack "karps.core.Row")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, values__field_descriptor)])
                (Data.Map.fromList [("values", values__field_descriptor)])

arrayValue ::
           forall f s t a b . Lens.Labels.HasLens "arrayValue" f s t a b =>
             Lens.Family2.LensLike f s t a b
arrayValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "arrayValue")

boolValue ::
          forall f s t a b . Lens.Labels.HasLens "boolValue" f s t a b =>
            Lens.Family2.LensLike f s t a b
boolValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "boolValue")

cell ::
     forall f s t a b . Lens.Labels.HasLens "cell" f s t a b =>
       Lens.Family2.LensLike f s t a b
cell
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "cell")

cellType ::
         forall f s t a b . Lens.Labels.HasLens "cellType" f s t a b =>
           Lens.Family2.LensLike f s t a b
cellType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "cellType")

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

maybe'arrayValue ::
                 forall f s t a b .
                   Lens.Labels.HasLens "maybe'arrayValue" f s t a b =>
                   Lens.Family2.LensLike f s t a b
maybe'arrayValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'arrayValue")

maybe'boolValue ::
                forall f s t a b .
                  Lens.Labels.HasLens "maybe'boolValue" f s t a b =>
                  Lens.Family2.LensLike f s t a b
maybe'boolValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'boolValue")

maybe'cell ::
           forall f s t a b . Lens.Labels.HasLens "maybe'cell" f s t a b =>
             Lens.Family2.LensLike f s t a b
maybe'cell
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'cell")

maybe'cellType ::
               forall f s t a b .
                 Lens.Labels.HasLens "maybe'cellType" f s t a b =>
                 Lens.Family2.LensLike f s t a b
maybe'cellType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'cellType")

maybe'doubleValue ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'doubleValue" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'doubleValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'doubleValue")

maybe'element ::
              forall f s t a b . Lens.Labels.HasLens "maybe'element" f s t a b =>
                Lens.Family2.LensLike f s t a b
maybe'element
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'element")

maybe'intValue ::
               forall f s t a b .
                 Lens.Labels.HasLens "maybe'intValue" f s t a b =>
                 Lens.Family2.LensLike f s t a b
maybe'intValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'intValue")

maybe'stringValue ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'stringValue" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'stringValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'stringValue")

maybe'structValue ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'structValue" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'structValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'structValue")

stringValue ::
            forall f s t a b . Lens.Labels.HasLens "stringValue" f s t a b =>
              Lens.Family2.LensLike f s t a b
stringValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "stringValue")

structValue ::
            forall f s t a b . Lens.Labels.HasLens "structValue" f s t a b =>
              Lens.Family2.LensLike f s t a b
structValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "structValue")

values ::
       forall f s t a b . Lens.Labels.HasLens "values" f s t a b =>
         Lens.Family2.LensLike f s t a b
values
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "values")