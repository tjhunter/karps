{- This file was auto-generated from karps/proto/structured_transform.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Karps.Proto.StructuredTransform where
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
import qualified Proto.Karps.Proto.Row
import qualified Proto.Karps.Proto.Types

data Aggregation = Aggregation{_Aggregation'fieldName ::
                               !Data.Text.Text,
                               _Aggregation'aggOp :: !(Prelude.Maybe Aggregation'AggOp)}
                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

data Aggregation'AggOp = Aggregation'Op !AggregationFunction
                       | Aggregation'Struct !AggregationStructure
                       deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "fieldName" f Aggregation Aggregation a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Aggregation'fieldName
                 (\ x__ y__ -> x__{_Aggregation'fieldName = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe Aggregation'AggOp,
          b ~ Prelude.Maybe Aggregation'AggOp, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'aggOp" f Aggregation Aggregation a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Aggregation'aggOp
                 (\ x__ y__ -> x__{_Aggregation'aggOp = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe AggregationFunction,
          b ~ Prelude.Maybe AggregationFunction, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'op" f Aggregation Aggregation a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Aggregation'aggOp
                 (\ x__ y__ -> x__{_Aggregation'aggOp = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Aggregation'Op x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Aggregation'Op y__))

instance (a ~ AggregationFunction, b ~ AggregationFunction,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "op" f Aggregation Aggregation a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Aggregation'aggOp
                 (\ x__ y__ -> x__{_Aggregation'aggOp = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Aggregation'Op x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Aggregation'Op y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))

instance (a ~ Prelude.Maybe AggregationStructure,
          b ~ Prelude.Maybe AggregationStructure, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'struct" f Aggregation Aggregation a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Aggregation'aggOp
                 (\ x__ y__ -> x__{_Aggregation'aggOp = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Aggregation'Struct x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Aggregation'Struct y__))

instance (a ~ AggregationStructure, b ~ AggregationStructure,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "struct" f Aggregation Aggregation a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Aggregation'aggOp
                 (\ x__ y__ -> x__{_Aggregation'aggOp = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Aggregation'Struct x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Aggregation'Struct y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))

instance Data.Default.Class.Default Aggregation where
        def
          = Aggregation{_Aggregation'fieldName = Data.ProtoLens.fieldDefault,
                        _Aggregation'aggOp = Prelude.Nothing}

instance Data.ProtoLens.Message Aggregation where
        descriptor
          = let fieldName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "field_name"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional fieldName)
                      :: Data.ProtoLens.FieldDescriptor Aggregation
                op__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "op"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor AggregationFunction)
                      (Data.ProtoLens.OptionalField maybe'op)
                      :: Data.ProtoLens.FieldDescriptor Aggregation
                struct__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "struct"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor AggregationStructure)
                      (Data.ProtoLens.OptionalField maybe'struct)
                      :: Data.ProtoLens.FieldDescriptor Aggregation
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.Aggregation")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 3, fieldName__field_descriptor),
                    (Data.ProtoLens.Tag 1, op__field_descriptor),
                    (Data.ProtoLens.Tag 2, struct__field_descriptor)])
                (Data.Map.fromList
                   [("field_name", fieldName__field_descriptor),
                    ("op", op__field_descriptor),
                    ("struct", struct__field_descriptor)])

data AggregationFunction = AggregationFunction{_AggregationFunction'functionName
                                               :: !Data.Text.Text,
                                               _AggregationFunction'inputs :: ![ColumnExtraction],
                                               _AggregationFunction'expectedType ::
                                               !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType)}
                         deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "functionName" f AggregationFunction
         AggregationFunction a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AggregationFunction'functionName
                 (\ x__ y__ -> x__{_AggregationFunction'functionName = y__}))
              Prelude.id

instance (a ~ [ColumnExtraction], b ~ [ColumnExtraction],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "inputs" f AggregationFunction
         AggregationFunction a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AggregationFunction'inputs
                 (\ x__ y__ -> x__{_AggregationFunction'inputs = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Types.SQLType,
          b ~ Proto.Karps.Proto.Types.SQLType, Prelude.Functor f) =>
         Lens.Labels.HasLens "expectedType" f AggregationFunction
         AggregationFunction a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AggregationFunction'expectedType
                 (\ x__ y__ -> x__{_AggregationFunction'expectedType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          b ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'expectedType" f AggregationFunction
         AggregationFunction a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AggregationFunction'expectedType
                 (\ x__ y__ -> x__{_AggregationFunction'expectedType = y__}))
              Prelude.id

instance Data.Default.Class.Default AggregationFunction where
        def
          = AggregationFunction{_AggregationFunction'functionName =
                                  Data.ProtoLens.fieldDefault,
                                _AggregationFunction'inputs = [],
                                _AggregationFunction'expectedType = Prelude.Nothing}

instance Data.ProtoLens.Message AggregationFunction where
        descriptor
          = let functionName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "function_name"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional functionName)
                      :: Data.ProtoLens.FieldDescriptor AggregationFunction
                inputs__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "inputs"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnExtraction)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked inputs)
                      :: Data.ProtoLens.FieldDescriptor AggregationFunction
                expectedType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "expected_type"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField maybe'expectedType)
                      :: Data.ProtoLens.FieldDescriptor AggregationFunction
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.AggregationFunction")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, functionName__field_descriptor),
                    (Data.ProtoLens.Tag 2, inputs__field_descriptor),
                    (Data.ProtoLens.Tag 3, expectedType__field_descriptor)])
                (Data.Map.fromList
                   [("function_name", functionName__field_descriptor),
                    ("inputs", inputs__field_descriptor),
                    ("expected_type", expectedType__field_descriptor)])

data AggregationStructure = AggregationStructure{_AggregationStructure'fields
                                                 :: ![Aggregation]}
                          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [Aggregation], b ~ [Aggregation],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "fields" f AggregationStructure
         AggregationStructure a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AggregationStructure'fields
                 (\ x__ y__ -> x__{_AggregationStructure'fields = y__}))
              Prelude.id

instance Data.Default.Class.Default AggregationStructure where
        def = AggregationStructure{_AggregationStructure'fields = []}

instance Data.ProtoLens.Message AggregationStructure where
        descriptor
          = let fields__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "fields"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Aggregation)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked fields)
                      :: Data.ProtoLens.FieldDescriptor AggregationStructure
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.AggregationStructure")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, fields__field_descriptor)])
                (Data.Map.fromList [("fields", fields__field_descriptor)])

data Column = Column{_Column'fieldName :: !Data.Text.Text,
                     _Column'content :: !(Prelude.Maybe Column'Content)}
            deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

data Column'Content = Column'Struct !ColumnStructure
                    | Column'Function !ColumnFunction
                    | Column'Extraction !ColumnExtraction
                    | Column'Broadcast !ColumnBroadcastObservable
                    | Column'Literal !ColumnLiteral
                    deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "fieldName" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'fieldName
                 (\ x__ y__ -> x__{_Column'fieldName = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe Column'Content,
          b ~ Prelude.Maybe Column'Content, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'content" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              Prelude.id

instance (a ~ Prelude.Maybe ColumnStructure,
          b ~ Prelude.Maybe ColumnStructure, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'struct" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Column'Struct x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Column'Struct y__))

instance (a ~ ColumnStructure, b ~ ColumnStructure,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "struct" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Column'Struct x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Column'Struct y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))

instance (a ~ Prelude.Maybe ColumnFunction,
          b ~ Prelude.Maybe ColumnFunction, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'function" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Column'Function x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Column'Function y__))

instance (a ~ ColumnFunction, b ~ ColumnFunction,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "function" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Column'Function x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Column'Function y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))

instance (a ~ Prelude.Maybe ColumnExtraction,
          b ~ Prelude.Maybe ColumnExtraction, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'extraction" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Column'Extraction x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Column'Extraction y__))

instance (a ~ ColumnExtraction, b ~ ColumnExtraction,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "extraction" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Column'Extraction x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Column'Extraction y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))

instance (a ~ Prelude.Maybe ColumnBroadcastObservable,
          b ~ Prelude.Maybe ColumnBroadcastObservable, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'broadcast" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Column'Broadcast x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Column'Broadcast y__))

instance (a ~ ColumnBroadcastObservable,
          b ~ ColumnBroadcastObservable, Prelude.Functor f) =>
         Lens.Labels.HasLens "broadcast" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Column'Broadcast x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Column'Broadcast y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))

instance (a ~ Prelude.Maybe ColumnLiteral,
          b ~ Prelude.Maybe ColumnLiteral, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'literal" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Column'Literal x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Column'Literal y__))

instance (a ~ ColumnLiteral, b ~ ColumnLiteral,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "literal" f Column Column a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (Column'Literal x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap Column'Literal y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))

instance Data.Default.Class.Default Column where
        def
          = Column{_Column'fieldName = Data.ProtoLens.fieldDefault,
                   _Column'content = Prelude.Nothing}

instance Data.ProtoLens.Message Column where
        descriptor
          = let fieldName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "field_name"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional fieldName)
                      :: Data.ProtoLens.FieldDescriptor Column
                struct__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "struct"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnStructure)
                      (Data.ProtoLens.OptionalField maybe'struct)
                      :: Data.ProtoLens.FieldDescriptor Column
                function__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "function"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnFunction)
                      (Data.ProtoLens.OptionalField maybe'function)
                      :: Data.ProtoLens.FieldDescriptor Column
                extraction__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "extraction"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnExtraction)
                      (Data.ProtoLens.OptionalField maybe'extraction)
                      :: Data.ProtoLens.FieldDescriptor Column
                broadcast__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "broadcast"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnBroadcastObservable)
                      (Data.ProtoLens.OptionalField maybe'broadcast)
                      :: Data.ProtoLens.FieldDescriptor Column
                literal__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "literal"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnLiteral)
                      (Data.ProtoLens.OptionalField maybe'literal)
                      :: Data.ProtoLens.FieldDescriptor Column
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.Column")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 10, fieldName__field_descriptor),
                    (Data.ProtoLens.Tag 1, struct__field_descriptor),
                    (Data.ProtoLens.Tag 2, function__field_descriptor),
                    (Data.ProtoLens.Tag 3, extraction__field_descriptor),
                    (Data.ProtoLens.Tag 4, broadcast__field_descriptor),
                    (Data.ProtoLens.Tag 5, literal__field_descriptor)])
                (Data.Map.fromList
                   [("field_name", fieldName__field_descriptor),
                    ("struct", struct__field_descriptor),
                    ("function", function__field_descriptor),
                    ("extraction", extraction__field_descriptor),
                    ("broadcast", broadcast__field_descriptor),
                    ("literal", literal__field_descriptor)])

data ColumnBroadcastObservable = ColumnBroadcastObservable{_ColumnBroadcastObservable'observableIndex
                                                           :: !Data.Int.Int32}
                               deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Int.Int32, b ~ Data.Int.Int32,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "observableIndex" f ColumnBroadcastObservable
         ColumnBroadcastObservable a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _ColumnBroadcastObservable'observableIndex
                 (\ x__ y__ ->
                    x__{_ColumnBroadcastObservable'observableIndex = y__}))
              Prelude.id

instance Data.Default.Class.Default ColumnBroadcastObservable where
        def
          = ColumnBroadcastObservable{_ColumnBroadcastObservable'observableIndex
                                        = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ColumnBroadcastObservable where
        descriptor
          = let observableIndex__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "observable_index"
                      (Data.ProtoLens.Int32Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional observableIndex)
                      :: Data.ProtoLens.FieldDescriptor ColumnBroadcastObservable
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ColumnBroadcastObservable")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, observableIndex__field_descriptor)])
                (Data.Map.fromList
                   [("observable_index", observableIndex__field_descriptor)])

data ColumnExtraction = ColumnExtraction{_ColumnExtraction'path ::
                                         ![Data.Text.Text]}
                      deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [Data.Text.Text], b ~ [Data.Text.Text],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "path" f ColumnExtraction ColumnExtraction a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnExtraction'path
                 (\ x__ y__ -> x__{_ColumnExtraction'path = y__}))
              Prelude.id

instance Data.Default.Class.Default ColumnExtraction where
        def = ColumnExtraction{_ColumnExtraction'path = []}

instance Data.ProtoLens.Message ColumnExtraction where
        descriptor
          = let path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked path)
                      :: Data.ProtoLens.FieldDescriptor ColumnExtraction
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ColumnExtraction")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, path__field_descriptor)])
                (Data.Map.fromList [("path", path__field_descriptor)])

data ColumnFunction = ColumnFunction{_ColumnFunction'functionName
                                     :: !Data.Text.Text,
                                     _ColumnFunction'inputs :: ![Column],
                                     _ColumnFunction'expectedType ::
                                     !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType)}
                    deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "functionName" f ColumnFunction ColumnFunction
         a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnFunction'functionName
                 (\ x__ y__ -> x__{_ColumnFunction'functionName = y__}))
              Prelude.id

instance (a ~ [Column], b ~ [Column], Prelude.Functor f) =>
         Lens.Labels.HasLens "inputs" f ColumnFunction ColumnFunction a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnFunction'inputs
                 (\ x__ y__ -> x__{_ColumnFunction'inputs = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Types.SQLType,
          b ~ Proto.Karps.Proto.Types.SQLType, Prelude.Functor f) =>
         Lens.Labels.HasLens "expectedType" f ColumnFunction ColumnFunction
         a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnFunction'expectedType
                 (\ x__ y__ -> x__{_ColumnFunction'expectedType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          b ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'expectedType" f ColumnFunction
         ColumnFunction a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnFunction'expectedType
                 (\ x__ y__ -> x__{_ColumnFunction'expectedType = y__}))
              Prelude.id

instance Data.Default.Class.Default ColumnFunction where
        def
          = ColumnFunction{_ColumnFunction'functionName =
                             Data.ProtoLens.fieldDefault,
                           _ColumnFunction'inputs = [],
                           _ColumnFunction'expectedType = Prelude.Nothing}

instance Data.ProtoLens.Message ColumnFunction where
        descriptor
          = let functionName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "function_name"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional functionName)
                      :: Data.ProtoLens.FieldDescriptor ColumnFunction
                inputs__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "inputs"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Column)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked inputs)
                      :: Data.ProtoLens.FieldDescriptor ColumnFunction
                expectedType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "expected_type"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField maybe'expectedType)
                      :: Data.ProtoLens.FieldDescriptor ColumnFunction
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ColumnFunction")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, functionName__field_descriptor),
                    (Data.ProtoLens.Tag 2, inputs__field_descriptor),
                    (Data.ProtoLens.Tag 3, expectedType__field_descriptor)])
                (Data.Map.fromList
                   [("function_name", functionName__field_descriptor),
                    ("inputs", inputs__field_descriptor),
                    ("expected_type", expectedType__field_descriptor)])

data ColumnLiteral = ColumnLiteral{_ColumnLiteral'content ::
                                   !(Prelude.Maybe Proto.Karps.Proto.Row.CellWithType)}
                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Proto.Karps.Proto.Row.CellWithType,
          b ~ Proto.Karps.Proto.Row.CellWithType, Prelude.Functor f) =>
         Lens.Labels.HasLens "content" f ColumnLiteral ColumnLiteral a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnLiteral'content
                 (\ x__ y__ -> x__{_ColumnLiteral'content = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Row.CellWithType,
          b ~ Prelude.Maybe Proto.Karps.Proto.Row.CellWithType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'content" f ColumnLiteral ColumnLiteral a
         b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnLiteral'content
                 (\ x__ y__ -> x__{_ColumnLiteral'content = y__}))
              Prelude.id

instance Data.Default.Class.Default ColumnLiteral where
        def = ColumnLiteral{_ColumnLiteral'content = Prelude.Nothing}

instance Data.ProtoLens.Message ColumnLiteral where
        descriptor
          = let content__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "content"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Row.CellWithType)
                      (Data.ProtoLens.OptionalField maybe'content)
                      :: Data.ProtoLens.FieldDescriptor ColumnLiteral
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ColumnLiteral")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, content__field_descriptor)])
                (Data.Map.fromList [("content", content__field_descriptor)])

data ColumnStructure = ColumnStructure{_ColumnStructure'fields ::
                                       ![Column]}
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [Column], b ~ [Column], Prelude.Functor f) =>
         Lens.Labels.HasLens "fields" f ColumnStructure ColumnStructure a b
         where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnStructure'fields
                 (\ x__ y__ -> x__{_ColumnStructure'fields = y__}))
              Prelude.id

instance Data.Default.Class.Default ColumnStructure where
        def = ColumnStructure{_ColumnStructure'fields = []}

instance Data.ProtoLens.Message ColumnStructure where
        descriptor
          = let fields__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "fields"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Column)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked fields)
                      :: Data.ProtoLens.FieldDescriptor ColumnStructure
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.ColumnStructure")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, fields__field_descriptor)])
                (Data.Map.fromList [("fields", fields__field_descriptor)])

broadcast ::
          forall f s t a b . Lens.Labels.HasLens "broadcast" f s t a b =>
            Lens.Family2.LensLike f s t a b
broadcast
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "broadcast")

content ::
        forall f s t a b . Lens.Labels.HasLens "content" f s t a b =>
          Lens.Family2.LensLike f s t a b
content
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "content")

expectedType ::
             forall f s t a b . Lens.Labels.HasLens "expectedType" f s t a b =>
               Lens.Family2.LensLike f s t a b
expectedType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "expectedType")

extraction ::
           forall f s t a b . Lens.Labels.HasLens "extraction" f s t a b =>
             Lens.Family2.LensLike f s t a b
extraction
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "extraction")

fieldName ::
          forall f s t a b . Lens.Labels.HasLens "fieldName" f s t a b =>
            Lens.Family2.LensLike f s t a b
fieldName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fieldName")

fields ::
       forall f s t a b . Lens.Labels.HasLens "fields" f s t a b =>
         Lens.Family2.LensLike f s t a b
fields
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fields")

function ::
         forall f s t a b . Lens.Labels.HasLens "function" f s t a b =>
           Lens.Family2.LensLike f s t a b
function
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "function")

functionName ::
             forall f s t a b . Lens.Labels.HasLens "functionName" f s t a b =>
               Lens.Family2.LensLike f s t a b
functionName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "functionName")

inputs ::
       forall f s t a b . Lens.Labels.HasLens "inputs" f s t a b =>
         Lens.Family2.LensLike f s t a b
inputs
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "inputs")

literal ::
        forall f s t a b . Lens.Labels.HasLens "literal" f s t a b =>
          Lens.Family2.LensLike f s t a b
literal
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "literal")

maybe'aggOp ::
            forall f s t a b . Lens.Labels.HasLens "maybe'aggOp" f s t a b =>
              Lens.Family2.LensLike f s t a b
maybe'aggOp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'aggOp")

maybe'broadcast ::
                forall f s t a b .
                  Lens.Labels.HasLens "maybe'broadcast" f s t a b =>
                  Lens.Family2.LensLike f s t a b
maybe'broadcast
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'broadcast")

maybe'content ::
              forall f s t a b . Lens.Labels.HasLens "maybe'content" f s t a b =>
                Lens.Family2.LensLike f s t a b
maybe'content
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'content")

maybe'expectedType ::
                   forall f s t a b .
                     Lens.Labels.HasLens "maybe'expectedType" f s t a b =>
                     Lens.Family2.LensLike f s t a b
maybe'expectedType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'expectedType")

maybe'extraction ::
                 forall f s t a b .
                   Lens.Labels.HasLens "maybe'extraction" f s t a b =>
                   Lens.Family2.LensLike f s t a b
maybe'extraction
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'extraction")

maybe'function ::
               forall f s t a b .
                 Lens.Labels.HasLens "maybe'function" f s t a b =>
                 Lens.Family2.LensLike f s t a b
maybe'function
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'function")

maybe'literal ::
              forall f s t a b . Lens.Labels.HasLens "maybe'literal" f s t a b =>
                Lens.Family2.LensLike f s t a b
maybe'literal
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'literal")

maybe'op ::
         forall f s t a b . Lens.Labels.HasLens "maybe'op" f s t a b =>
           Lens.Family2.LensLike f s t a b
maybe'op
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'op")

maybe'struct ::
             forall f s t a b . Lens.Labels.HasLens "maybe'struct" f s t a b =>
               Lens.Family2.LensLike f s t a b
maybe'struct
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'struct")

observableIndex ::
                forall f s t a b .
                  Lens.Labels.HasLens "observableIndex" f s t a b =>
                  Lens.Family2.LensLike f s t a b
observableIndex
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "observableIndex")

op ::
   forall f s t a b . Lens.Labels.HasLens "op" f s t a b =>
     Lens.Family2.LensLike f s t a b
op
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "op")

path ::
     forall f s t a b . Lens.Labels.HasLens "path" f s t a b =>
       Lens.Family2.LensLike f s t a b
path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")

struct ::
       forall f s t a b . Lens.Labels.HasLens "struct" f s t a b =>
         Lens.Family2.LensLike f s t a b
struct
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "struct")