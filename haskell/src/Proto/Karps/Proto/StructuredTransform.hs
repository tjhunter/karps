{- This file was auto-generated from karps/proto/structured_transform.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.StructuredTransform
       (Aggregation(..), Aggregation'AggOp(..), _Aggregation'Op,
        _Aggregation'Struct, AggregationFunction(..),
        AggregationStructure(..), Column(..), Column'Content(..),
        _Column'Struct, _Column'Function, _Column'Extraction,
        _Column'Broadcast, _Column'Literal, ColumnBroadcastObservable(..),
        ColumnExtraction(..), ColumnFunction(..), ColumnLiteral(..),
        ColumnStructure(..))
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
import qualified Proto.Karps.Proto.Row
import qualified Proto.Karps.Proto.Types

{- | Fields :

    * 'Proto.Karps.Proto.StructuredTransform_Fields.fieldName' @:: Lens' Aggregation Data.Text.Text@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'aggOp' @:: Lens' Aggregation (Prelude.Maybe Aggregation'AggOp)@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'op' @:: Lens' Aggregation (Prelude.Maybe AggregationFunction)@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.op' @:: Lens' Aggregation AggregationFunction@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'struct' @:: Lens' Aggregation (Prelude.Maybe AggregationStructure)@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.struct' @:: Lens' Aggregation AggregationStructure@
 -}
data Aggregation = Aggregation{_Aggregation'fieldName ::
                               !Data.Text.Text,
                               _Aggregation'aggOp :: !(Prelude.Maybe Aggregation'AggOp),
                               _Aggregation'_unknownFields :: !Data.ProtoLens.FieldSet}
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
data Aggregation'AggOp = Aggregation'Op !AggregationFunction
                       | Aggregation'Struct !AggregationStructure
                           deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f Aggregation x a, a ~ b) =>
         Lens.Labels.HasLens f Aggregation Aggregation x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Aggregation "fieldName" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Aggregation'fieldName
                 (\ x__ y__ -> x__{_Aggregation'fieldName = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Aggregation "maybe'aggOp"
           (Prelude.Maybe Aggregation'AggOp)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Aggregation'aggOp
                 (\ x__ y__ -> x__{_Aggregation'aggOp = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Aggregation "maybe'op"
           (Prelude.Maybe AggregationFunction)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Aggregation'aggOp
                 (\ x__ y__ -> x__{_Aggregation'aggOp = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Aggregation'Op x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Aggregation'Op y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Aggregation "op" (AggregationFunction)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Aggregation "maybe'struct"
           (Prelude.Maybe AggregationStructure)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Aggregation'aggOp
                 (\ x__ y__ -> x__{_Aggregation'aggOp = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Aggregation'Struct x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Aggregation'Struct y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Aggregation "struct" (AggregationStructure)
         where
        lensOf' _
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
                        _Aggregation'aggOp = Prelude.Nothing,
                        _Aggregation'_unknownFields = ([])}
instance Data.ProtoLens.Message Aggregation where
        messageName _ = Data.Text.pack "karps.core.Aggregation"
        fieldsByTag
          = let fieldName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "field_name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fieldName")))
                      :: Data.ProtoLens.FieldDescriptor Aggregation
                op__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "op"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor AggregationFunction)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'op")))
                      :: Data.ProtoLens.FieldDescriptor Aggregation
                struct__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "struct"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor AggregationStructure)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'struct")))
                      :: Data.ProtoLens.FieldDescriptor Aggregation
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 3, fieldName__field_descriptor),
                 (Data.ProtoLens.Tag 1, op__field_descriptor),
                 (Data.ProtoLens.Tag 2, struct__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _Aggregation'_unknownFields
              (\ x__ y__ -> x__{_Aggregation'_unknownFields = y__})
_Aggregation'Op ::
                Lens.Labels.Prism.Prism' Aggregation'AggOp AggregationFunction
_Aggregation'Op
  = Lens.Labels.Prism.prism' Aggregation'Op
      (\ p__ ->
         case p__ of
             Aggregation'Op p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_Aggregation'Struct ::
                    Lens.Labels.Prism.Prism' Aggregation'AggOp AggregationStructure
_Aggregation'Struct
  = Lens.Labels.Prism.prism' Aggregation'Struct
      (\ p__ ->
         case p__ of
             Aggregation'Struct p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
{- | Fields :

    * 'Proto.Karps.Proto.StructuredTransform_Fields.functionName' @:: Lens' AggregationFunction Data.Text.Text@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.inputs' @:: Lens' AggregationFunction [ColumnExtraction]@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.expectedType' @:: Lens' AggregationFunction Proto.Karps.Proto.Types.SQLType@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'expectedType' @:: Lens' AggregationFunction
  (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)@
 -}
data AggregationFunction = AggregationFunction{_AggregationFunction'functionName
                                               :: !Data.Text.Text,
                                               _AggregationFunction'inputs :: ![ColumnExtraction],
                                               _AggregationFunction'expectedType ::
                                               !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType),
                                               _AggregationFunction'_unknownFields ::
                                               !Data.ProtoLens.FieldSet}
                             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f AggregationFunction x a, a ~ b) =>
         Lens.Labels.HasLens f AggregationFunction AggregationFunction x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AggregationFunction "functionName"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AggregationFunction'functionName
                 (\ x__ y__ -> x__{_AggregationFunction'functionName = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AggregationFunction "inputs"
           ([ColumnExtraction])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AggregationFunction'inputs
                 (\ x__ y__ -> x__{_AggregationFunction'inputs = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AggregationFunction "expectedType"
           (Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AggregationFunction'expectedType
                 (\ x__ y__ -> x__{_AggregationFunction'expectedType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AggregationFunction "maybe'expectedType"
           (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AggregationFunction'expectedType
                 (\ x__ y__ -> x__{_AggregationFunction'expectedType = y__}))
              Prelude.id
instance Data.Default.Class.Default AggregationFunction where
        def
          = AggregationFunction{_AggregationFunction'functionName =
                                  Data.ProtoLens.fieldDefault,
                                _AggregationFunction'inputs = [],
                                _AggregationFunction'expectedType = Prelude.Nothing,
                                _AggregationFunction'_unknownFields = ([])}
instance Data.ProtoLens.Message AggregationFunction where
        messageName _ = Data.Text.pack "karps.core.AggregationFunction"
        fieldsByTag
          = let functionName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "function_name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "functionName")))
                      :: Data.ProtoLens.FieldDescriptor AggregationFunction
                inputs__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "inputs"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnExtraction)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "inputs")))
                      :: Data.ProtoLens.FieldDescriptor AggregationFunction
                expectedType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "expected_type"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'expectedType")))
                      :: Data.ProtoLens.FieldDescriptor AggregationFunction
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, functionName__field_descriptor),
                 (Data.ProtoLens.Tag 2, inputs__field_descriptor),
                 (Data.ProtoLens.Tag 3, expectedType__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _AggregationFunction'_unknownFields
              (\ x__ y__ -> x__{_AggregationFunction'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.StructuredTransform_Fields.fields' @:: Lens' AggregationStructure [Aggregation]@
 -}
data AggregationStructure = AggregationStructure{_AggregationStructure'fields
                                                 :: ![Aggregation],
                                                 _AggregationStructure'_unknownFields ::
                                                 !Data.ProtoLens.FieldSet}
                              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f AggregationStructure x a,
          a ~ b) =>
         Lens.Labels.HasLens f AggregationStructure AggregationStructure x a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f AggregationStructure "fields"
           ([Aggregation])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _AggregationStructure'fields
                 (\ x__ y__ -> x__{_AggregationStructure'fields = y__}))
              Prelude.id
instance Data.Default.Class.Default AggregationStructure where
        def
          = AggregationStructure{_AggregationStructure'fields = [],
                                 _AggregationStructure'_unknownFields = ([])}
instance Data.ProtoLens.Message AggregationStructure where
        messageName _ = Data.Text.pack "karps.core.AggregationStructure"
        fieldsByTag
          = let fields__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "fields"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Aggregation)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fields")))
                      :: Data.ProtoLens.FieldDescriptor AggregationStructure
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, fields__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _AggregationStructure'_unknownFields
              (\ x__ y__ -> x__{_AggregationStructure'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.StructuredTransform_Fields.fieldName' @:: Lens' Column Data.Text.Text@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'content' @:: Lens' Column (Prelude.Maybe Column'Content)@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'struct' @:: Lens' Column (Prelude.Maybe ColumnStructure)@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.struct' @:: Lens' Column ColumnStructure@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'function' @:: Lens' Column (Prelude.Maybe ColumnFunction)@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.function' @:: Lens' Column ColumnFunction@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'extraction' @:: Lens' Column (Prelude.Maybe ColumnExtraction)@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.extraction' @:: Lens' Column ColumnExtraction@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'broadcast' @:: Lens' Column (Prelude.Maybe ColumnBroadcastObservable)@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.broadcast' @:: Lens' Column ColumnBroadcastObservable@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'literal' @:: Lens' Column (Prelude.Maybe ColumnLiteral)@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.literal' @:: Lens' Column ColumnLiteral@
 -}
data Column = Column{_Column'fieldName :: !Data.Text.Text,
                     _Column'content :: !(Prelude.Maybe Column'Content),
                     _Column'_unknownFields :: !Data.ProtoLens.FieldSet}
                deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
data Column'Content = Column'Struct !ColumnStructure
                    | Column'Function !ColumnFunction
                    | Column'Extraction !ColumnExtraction
                    | Column'Broadcast !ColumnBroadcastObservable
                    | Column'Literal !ColumnLiteral
                        deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f Column x a, a ~ b) =>
         Lens.Labels.HasLens f Column Column x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "fieldName" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'fieldName
                 (\ x__ y__ -> x__{_Column'fieldName = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "maybe'content"
           (Prelude.Maybe Column'Content)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "maybe'struct"
           (Prelude.Maybe ColumnStructure)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Column'Struct x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Column'Struct y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "struct" (ColumnStructure)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "maybe'function"
           (Prelude.Maybe ColumnFunction)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Column'Function x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Column'Function y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "function" (ColumnFunction)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "maybe'extraction"
           (Prelude.Maybe ColumnExtraction)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Column'Extraction x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Column'Extraction y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "extraction" (ColumnExtraction)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "maybe'broadcast"
           (Prelude.Maybe ColumnBroadcastObservable)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Column'Broadcast x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Column'Broadcast y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "broadcast"
           (ColumnBroadcastObservable)
         where
        lensOf' _
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
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "maybe'literal"
           (Prelude.Maybe ColumnLiteral)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Column'content
                 (\ x__ y__ -> x__{_Column'content = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (Column'Literal x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap Column'Literal y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f Column "literal" (ColumnLiteral)
         where
        lensOf' _
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
                   _Column'content = Prelude.Nothing, _Column'_unknownFields = ([])}
instance Data.ProtoLens.Message Column where
        messageName _ = Data.Text.pack "karps.core.Column"
        fieldsByTag
          = let fieldName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "field_name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fieldName")))
                      :: Data.ProtoLens.FieldDescriptor Column
                struct__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "struct"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnStructure)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'struct")))
                      :: Data.ProtoLens.FieldDescriptor Column
                function__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "function"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnFunction)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'function")))
                      :: Data.ProtoLens.FieldDescriptor Column
                extraction__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "extraction"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnExtraction)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'extraction")))
                      :: Data.ProtoLens.FieldDescriptor Column
                broadcast__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "broadcast"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnBroadcastObservable)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'broadcast")))
                      :: Data.ProtoLens.FieldDescriptor Column
                literal__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "literal"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor ColumnLiteral)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'literal")))
                      :: Data.ProtoLens.FieldDescriptor Column
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 10, fieldName__field_descriptor),
                 (Data.ProtoLens.Tag 1, struct__field_descriptor),
                 (Data.ProtoLens.Tag 2, function__field_descriptor),
                 (Data.ProtoLens.Tag 3, extraction__field_descriptor),
                 (Data.ProtoLens.Tag 4, broadcast__field_descriptor),
                 (Data.ProtoLens.Tag 5, literal__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _Column'_unknownFields
              (\ x__ y__ -> x__{_Column'_unknownFields = y__})
_Column'Struct ::
               Lens.Labels.Prism.Prism' Column'Content ColumnStructure
_Column'Struct
  = Lens.Labels.Prism.prism' Column'Struct
      (\ p__ ->
         case p__ of
             Column'Struct p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_Column'Function ::
                 Lens.Labels.Prism.Prism' Column'Content ColumnFunction
_Column'Function
  = Lens.Labels.Prism.prism' Column'Function
      (\ p__ ->
         case p__ of
             Column'Function p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_Column'Extraction ::
                   Lens.Labels.Prism.Prism' Column'Content ColumnExtraction
_Column'Extraction
  = Lens.Labels.Prism.prism' Column'Extraction
      (\ p__ ->
         case p__ of
             Column'Extraction p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_Column'Broadcast ::
                  Lens.Labels.Prism.Prism' Column'Content ColumnBroadcastObservable
_Column'Broadcast
  = Lens.Labels.Prism.prism' Column'Broadcast
      (\ p__ ->
         case p__ of
             Column'Broadcast p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_Column'Literal ::
                Lens.Labels.Prism.Prism' Column'Content ColumnLiteral
_Column'Literal
  = Lens.Labels.Prism.prism' Column'Literal
      (\ p__ ->
         case p__ of
             Column'Literal p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
{- | Fields :

    * 'Proto.Karps.Proto.StructuredTransform_Fields.observableIndex' @:: Lens' ColumnBroadcastObservable Data.Int.Int32@
 -}
data ColumnBroadcastObservable = ColumnBroadcastObservable{_ColumnBroadcastObservable'observableIndex
                                                           :: !Data.Int.Int32,
                                                           _ColumnBroadcastObservable'_unknownFields
                                                           :: !Data.ProtoLens.FieldSet}
                                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ColumnBroadcastObservable x a,
          a ~ b) =>
         Lens.Labels.HasLens f ColumnBroadcastObservable
           ColumnBroadcastObservable
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ColumnBroadcastObservable "observableIndex"
           (Data.Int.Int32)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _ColumnBroadcastObservable'observableIndex
                 (\ x__ y__ ->
                    x__{_ColumnBroadcastObservable'observableIndex = y__}))
              Prelude.id
instance Data.Default.Class.Default ColumnBroadcastObservable where
        def
          = ColumnBroadcastObservable{_ColumnBroadcastObservable'observableIndex
                                        = Data.ProtoLens.fieldDefault,
                                      _ColumnBroadcastObservable'_unknownFields = ([])}
instance Data.ProtoLens.Message ColumnBroadcastObservable where
        messageName _
          = Data.Text.pack "karps.core.ColumnBroadcastObservable"
        fieldsByTag
          = let observableIndex__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "observable_index"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "observableIndex")))
                      :: Data.ProtoLens.FieldDescriptor ColumnBroadcastObservable
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, observableIndex__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _ColumnBroadcastObservable'_unknownFields
              (\ x__ y__ -> x__{_ColumnBroadcastObservable'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.StructuredTransform_Fields.path' @:: Lens' ColumnExtraction [Data.Text.Text]@
 -}
data ColumnExtraction = ColumnExtraction{_ColumnExtraction'path ::
                                         ![Data.Text.Text],
                                         _ColumnExtraction'_unknownFields ::
                                         !Data.ProtoLens.FieldSet}
                          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ColumnExtraction x a, a ~ b) =>
         Lens.Labels.HasLens f ColumnExtraction ColumnExtraction x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ColumnExtraction "path" ([Data.Text.Text])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnExtraction'path
                 (\ x__ y__ -> x__{_ColumnExtraction'path = y__}))
              Prelude.id
instance Data.Default.Class.Default ColumnExtraction where
        def
          = ColumnExtraction{_ColumnExtraction'path = [],
                             _ColumnExtraction'_unknownFields = ([])}
instance Data.ProtoLens.Message ColumnExtraction where
        messageName _ = Data.Text.pack "karps.core.ColumnExtraction"
        fieldsByTag
          = let path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")))
                      :: Data.ProtoLens.FieldDescriptor ColumnExtraction
              in
              Data.Map.fromList [(Data.ProtoLens.Tag 1, path__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ColumnExtraction'_unknownFields
              (\ x__ y__ -> x__{_ColumnExtraction'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.StructuredTransform_Fields.functionName' @:: Lens' ColumnFunction Data.Text.Text@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.inputs' @:: Lens' ColumnFunction [Column]@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.expectedType' @:: Lens' ColumnFunction Proto.Karps.Proto.Types.SQLType@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'expectedType' @:: Lens' ColumnFunction
  (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)@
 -}
data ColumnFunction = ColumnFunction{_ColumnFunction'functionName
                                     :: !Data.Text.Text,
                                     _ColumnFunction'inputs :: ![Column],
                                     _ColumnFunction'expectedType ::
                                     !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType),
                                     _ColumnFunction'_unknownFields :: !Data.ProtoLens.FieldSet}
                        deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ColumnFunction x a, a ~ b) =>
         Lens.Labels.HasLens f ColumnFunction ColumnFunction x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ColumnFunction "functionName"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnFunction'functionName
                 (\ x__ y__ -> x__{_ColumnFunction'functionName = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ColumnFunction "inputs" ([Column])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnFunction'inputs
                 (\ x__ y__ -> x__{_ColumnFunction'inputs = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ColumnFunction "expectedType"
           (Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnFunction'expectedType
                 (\ x__ y__ -> x__{_ColumnFunction'expectedType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ColumnFunction "maybe'expectedType"
           (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnFunction'expectedType
                 (\ x__ y__ -> x__{_ColumnFunction'expectedType = y__}))
              Prelude.id
instance Data.Default.Class.Default ColumnFunction where
        def
          = ColumnFunction{_ColumnFunction'functionName =
                             Data.ProtoLens.fieldDefault,
                           _ColumnFunction'inputs = [],
                           _ColumnFunction'expectedType = Prelude.Nothing,
                           _ColumnFunction'_unknownFields = ([])}
instance Data.ProtoLens.Message ColumnFunction where
        messageName _ = Data.Text.pack "karps.core.ColumnFunction"
        fieldsByTag
          = let functionName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "function_name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "functionName")))
                      :: Data.ProtoLens.FieldDescriptor ColumnFunction
                inputs__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "inputs"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Column)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "inputs")))
                      :: Data.ProtoLens.FieldDescriptor ColumnFunction
                expectedType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "expected_type"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'expectedType")))
                      :: Data.ProtoLens.FieldDescriptor ColumnFunction
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, functionName__field_descriptor),
                 (Data.ProtoLens.Tag 2, inputs__field_descriptor),
                 (Data.ProtoLens.Tag 3, expectedType__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ColumnFunction'_unknownFields
              (\ x__ y__ -> x__{_ColumnFunction'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.StructuredTransform_Fields.content' @:: Lens' ColumnLiteral Proto.Karps.Proto.Row.CellWithType@
    * 'Proto.Karps.Proto.StructuredTransform_Fields.maybe'content' @:: Lens' ColumnLiteral
  (Prelude.Maybe Proto.Karps.Proto.Row.CellWithType)@
 -}
data ColumnLiteral = ColumnLiteral{_ColumnLiteral'content ::
                                   !(Prelude.Maybe Proto.Karps.Proto.Row.CellWithType),
                                   _ColumnLiteral'_unknownFields :: !Data.ProtoLens.FieldSet}
                       deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ColumnLiteral x a, a ~ b) =>
         Lens.Labels.HasLens f ColumnLiteral ColumnLiteral x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ColumnLiteral "content"
           (Proto.Karps.Proto.Row.CellWithType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnLiteral'content
                 (\ x__ y__ -> x__{_ColumnLiteral'content = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ColumnLiteral "maybe'content"
           (Prelude.Maybe Proto.Karps.Proto.Row.CellWithType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnLiteral'content
                 (\ x__ y__ -> x__{_ColumnLiteral'content = y__}))
              Prelude.id
instance Data.Default.Class.Default ColumnLiteral where
        def
          = ColumnLiteral{_ColumnLiteral'content = Prelude.Nothing,
                          _ColumnLiteral'_unknownFields = ([])}
instance Data.ProtoLens.Message ColumnLiteral where
        messageName _ = Data.Text.pack "karps.core.ColumnLiteral"
        fieldsByTag
          = let content__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "content"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Karps.Proto.Row.CellWithType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'content")))
                      :: Data.ProtoLens.FieldDescriptor ColumnLiteral
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, content__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ColumnLiteral'_unknownFields
              (\ x__ y__ -> x__{_ColumnLiteral'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.StructuredTransform_Fields.fields' @:: Lens' ColumnStructure [Column]@
 -}
data ColumnStructure = ColumnStructure{_ColumnStructure'fields ::
                                       ![Column],
                                       _ColumnStructure'_unknownFields :: !Data.ProtoLens.FieldSet}
                         deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f ColumnStructure x a, a ~ b) =>
         Lens.Labels.HasLens f ColumnStructure ColumnStructure x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f ColumnStructure "fields" ([Column])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _ColumnStructure'fields
                 (\ x__ y__ -> x__{_ColumnStructure'fields = y__}))
              Prelude.id
instance Data.Default.Class.Default ColumnStructure where
        def
          = ColumnStructure{_ColumnStructure'fields = [],
                            _ColumnStructure'_unknownFields = ([])}
instance Data.ProtoLens.Message ColumnStructure where
        messageName _ = Data.Text.pack "karps.core.ColumnStructure"
        fieldsByTag
          = let fields__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "fields"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Column)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fields")))
                      :: Data.ProtoLens.FieldDescriptor ColumnStructure
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, fields__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _ColumnStructure'_unknownFields
              (\ x__ y__ -> x__{_ColumnStructure'_unknownFields = y__})