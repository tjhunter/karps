{- This file was auto-generated from karps/proto/spark.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Spark
       (SparkAction(..), SparkAction'Action(..), _SparkAction'LoadInline,
        _SparkAction'ExecSql, _SparkAction'ExtractPandas',
        _SparkAction'ExtractCell', SparkAction'ExecuteSQL(..),
        SparkAction'ExtractCell(..), SparkAction'ExtractPandas(..),
        SparkAction'LoadFromInline(..), SparkGraph(..))
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
import qualified Proto.Karps.Proto.Graph
import qualified Proto.Karps.Proto.Types

{- | Fields :

    * 'Proto.Karps.Proto.Spark_Fields.path' @:: Lens' SparkAction Proto.Karps.Proto.Graph.Path@
    * 'Proto.Karps.Proto.Spark_Fields.maybe'path' @:: Lens' SparkAction (Prelude.Maybe Proto.Karps.Proto.Graph.Path)@
    * 'Proto.Karps.Proto.Spark_Fields.tableName' @:: Lens' SparkAction Data.Text.Text@
    * 'Proto.Karps.Proto.Spark_Fields.dependencies' @:: Lens' SparkAction [Proto.Karps.Proto.Graph.Path]@
    * 'Proto.Karps.Proto.Spark_Fields.maybe'action' @:: Lens' SparkAction (Prelude.Maybe SparkAction'Action)@
    * 'Proto.Karps.Proto.Spark_Fields.maybe'loadInline' @:: Lens' SparkAction (Prelude.Maybe SparkAction'LoadFromInline)@
    * 'Proto.Karps.Proto.Spark_Fields.loadInline' @:: Lens' SparkAction SparkAction'LoadFromInline@
    * 'Proto.Karps.Proto.Spark_Fields.maybe'execSql' @:: Lens' SparkAction (Prelude.Maybe SparkAction'ExecuteSQL)@
    * 'Proto.Karps.Proto.Spark_Fields.execSql' @:: Lens' SparkAction SparkAction'ExecuteSQL@
    * 'Proto.Karps.Proto.Spark_Fields.maybe'extractPandas' @:: Lens' SparkAction (Prelude.Maybe SparkAction'ExtractPandas)@
    * 'Proto.Karps.Proto.Spark_Fields.extractPandas' @:: Lens' SparkAction SparkAction'ExtractPandas@
    * 'Proto.Karps.Proto.Spark_Fields.maybe'extractCell' @:: Lens' SparkAction (Prelude.Maybe SparkAction'ExtractCell)@
    * 'Proto.Karps.Proto.Spark_Fields.extractCell' @:: Lens' SparkAction SparkAction'ExtractCell@
 -}
data SparkAction = SparkAction{_SparkAction'path ::
                               !(Prelude.Maybe Proto.Karps.Proto.Graph.Path),
                               _SparkAction'tableName :: !Data.Text.Text,
                               _SparkAction'dependencies :: ![Proto.Karps.Proto.Graph.Path],
                               _SparkAction'action :: !(Prelude.Maybe SparkAction'Action),
                               _SparkAction'_unknownFields :: !Data.ProtoLens.FieldSet}
                     deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
data SparkAction'Action = SparkAction'LoadInline !SparkAction'LoadFromInline
                        | SparkAction'ExecSql !SparkAction'ExecuteSQL
                        | SparkAction'ExtractPandas' !SparkAction'ExtractPandas
                        | SparkAction'ExtractCell' !SparkAction'ExtractCell
                            deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f SparkAction x a, a ~ b) =>
         Lens.Labels.HasLens f SparkAction SparkAction x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "path"
           (Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'path
                 (\ x__ y__ -> x__{_SparkAction'path = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "maybe'path"
           (Prelude.Maybe Proto.Karps.Proto.Graph.Path)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'path
                 (\ x__ y__ -> x__{_SparkAction'path = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "tableName" (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'tableName
                 (\ x__ y__ -> x__{_SparkAction'tableName = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "dependencies"
           ([Proto.Karps.Proto.Graph.Path])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'dependencies
                 (\ x__ y__ -> x__{_SparkAction'dependencies = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "maybe'action"
           (Prelude.Maybe SparkAction'Action)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'action
                 (\ x__ y__ -> x__{_SparkAction'action = y__}))
              Prelude.id
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "maybe'loadInline"
           (Prelude.Maybe SparkAction'LoadFromInline)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'action
                 (\ x__ y__ -> x__{_SparkAction'action = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (SparkAction'LoadInline x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap SparkAction'LoadInline y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "loadInline"
           (SparkAction'LoadFromInline)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'action
                 (\ x__ y__ -> x__{_SparkAction'action = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (SparkAction'LoadInline x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap SparkAction'LoadInline y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "maybe'execSql"
           (Prelude.Maybe SparkAction'ExecuteSQL)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'action
                 (\ x__ y__ -> x__{_SparkAction'action = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (SparkAction'ExecSql x__val) -> Prelude.Just x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap SparkAction'ExecSql y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "execSql"
           (SparkAction'ExecuteSQL)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'action
                 (\ x__ y__ -> x__{_SparkAction'action = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (SparkAction'ExecSql x__val) -> Prelude.Just x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap SparkAction'ExecSql y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "maybe'extractPandas"
           (Prelude.Maybe SparkAction'ExtractPandas)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'action
                 (\ x__ y__ -> x__{_SparkAction'action = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (SparkAction'ExtractPandas' x__val) -> Prelude.Just
                                                                              x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap SparkAction'ExtractPandas' y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "extractPandas"
           (SparkAction'ExtractPandas)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'action
                 (\ x__ y__ -> x__{_SparkAction'action = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (SparkAction'ExtractPandas' x__val) -> Prelude.Just
                                                                                 x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap SparkAction'ExtractPandas' y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "maybe'extractCell"
           (Prelude.Maybe SparkAction'ExtractCell)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'action
                 (\ x__ y__ -> x__{_SparkAction'action = y__}))
              (Lens.Family2.Unchecked.lens
                 (\ x__ ->
                    case x__ of
                        Prelude.Just (SparkAction'ExtractCell' x__val) -> Prelude.Just
                                                                            x__val
                        _otherwise -> Prelude.Nothing)
                 (\ _ y__ -> Prelude.fmap SparkAction'ExtractCell' y__))
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction "extractCell"
           (SparkAction'ExtractCell)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'action
                 (\ x__ y__ -> x__{_SparkAction'action = y__}))
              ((Prelude..)
                 (Lens.Family2.Unchecked.lens
                    (\ x__ ->
                       case x__ of
                           Prelude.Just (SparkAction'ExtractCell' x__val) -> Prelude.Just
                                                                               x__val
                           _otherwise -> Prelude.Nothing)
                    (\ _ y__ -> Prelude.fmap SparkAction'ExtractCell' y__))
                 (Data.ProtoLens.maybeLens Data.Default.Class.def))
instance Data.Default.Class.Default SparkAction where
        def
          = SparkAction{_SparkAction'path = Prelude.Nothing,
                        _SparkAction'tableName = Data.ProtoLens.fieldDefault,
                        _SparkAction'dependencies = [],
                        _SparkAction'action = Prelude.Nothing,
                        _SparkAction'_unknownFields = ([])}
instance Data.ProtoLens.Message SparkAction where
        messageName _ = Data.Text.pack "karps.spark.SparkAction"
        fieldsByTag
          = let path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'path")))
                      :: Data.ProtoLens.FieldDescriptor SparkAction
                tableName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "table_name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "tableName")))
                      :: Data.ProtoLens.FieldDescriptor SparkAction
                dependencies__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "dependencies"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Graph.Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "dependencies")))
                      :: Data.ProtoLens.FieldDescriptor SparkAction
                loadInline__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "load_inline"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SparkAction'LoadFromInline)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'loadInline")))
                      :: Data.ProtoLens.FieldDescriptor SparkAction
                execSql__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "exec_sql"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SparkAction'ExecuteSQL)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'execSql")))
                      :: Data.ProtoLens.FieldDescriptor SparkAction
                extractPandas__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "extract_pandas"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SparkAction'ExtractPandas)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'extractPandas")))
                      :: Data.ProtoLens.FieldDescriptor SparkAction
                extractCell__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "extract_cell"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SparkAction'ExtractCell)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'extractCell")))
                      :: Data.ProtoLens.FieldDescriptor SparkAction
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, path__field_descriptor),
                 (Data.ProtoLens.Tag 2, tableName__field_descriptor),
                 (Data.ProtoLens.Tag 3, dependencies__field_descriptor),
                 (Data.ProtoLens.Tag 4, loadInline__field_descriptor),
                 (Data.ProtoLens.Tag 5, execSql__field_descriptor),
                 (Data.ProtoLens.Tag 6, extractPandas__field_descriptor),
                 (Data.ProtoLens.Tag 7, extractCell__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _SparkAction'_unknownFields
              (\ x__ y__ -> x__{_SparkAction'_unknownFields = y__})
_SparkAction'LoadInline ::
                        Lens.Labels.Prism.Prism' SparkAction'Action
                          SparkAction'LoadFromInline
_SparkAction'LoadInline
  = Lens.Labels.Prism.prism' SparkAction'LoadInline
      (\ p__ ->
         case p__ of
             SparkAction'LoadInline p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_SparkAction'ExecSql ::
                     Lens.Labels.Prism.Prism' SparkAction'Action SparkAction'ExecuteSQL
_SparkAction'ExecSql
  = Lens.Labels.Prism.prism' SparkAction'ExecSql
      (\ p__ ->
         case p__ of
             SparkAction'ExecSql p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_SparkAction'ExtractPandas' ::
                            Lens.Labels.Prism.Prism' SparkAction'Action
                              SparkAction'ExtractPandas
_SparkAction'ExtractPandas'
  = Lens.Labels.Prism.prism' SparkAction'ExtractPandas'
      (\ p__ ->
         case p__ of
             SparkAction'ExtractPandas' p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
_SparkAction'ExtractCell' ::
                          Lens.Labels.Prism.Prism' SparkAction'Action SparkAction'ExtractCell
_SparkAction'ExtractCell'
  = Lens.Labels.Prism.prism' SparkAction'ExtractCell'
      (\ p__ ->
         case p__ of
             SparkAction'ExtractCell' p__val -> Prelude.Just p__val
             _otherwise -> Prelude.Nothing)
{- | Fields :

    * 'Proto.Karps.Proto.Spark_Fields.statement' @:: Lens' SparkAction'ExecuteSQL Data.Text.Text@
 -}
data SparkAction'ExecuteSQL = SparkAction'ExecuteSQL{_SparkAction'ExecuteSQL'statement
                                                     :: !Data.Text.Text,
                                                     _SparkAction'ExecuteSQL'_unknownFields ::
                                                     !Data.ProtoLens.FieldSet}
                                deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f SparkAction'ExecuteSQL x a,
          a ~ b) =>
         Lens.Labels.HasLens f SparkAction'ExecuteSQL SparkAction'ExecuteSQL
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction'ExecuteSQL "statement"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'ExecuteSQL'statement
                 (\ x__ y__ -> x__{_SparkAction'ExecuteSQL'statement = y__}))
              Prelude.id
instance Data.Default.Class.Default SparkAction'ExecuteSQL where
        def
          = SparkAction'ExecuteSQL{_SparkAction'ExecuteSQL'statement =
                                     Data.ProtoLens.fieldDefault,
                                   _SparkAction'ExecuteSQL'_unknownFields = ([])}
instance Data.ProtoLens.Message SparkAction'ExecuteSQL where
        messageName _ = Data.Text.pack "karps.spark.SparkAction.ExecuteSQL"
        fieldsByTag
          = let statement__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "statement"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "statement")))
                      :: Data.ProtoLens.FieldDescriptor SparkAction'ExecuteSQL
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, statement__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _SparkAction'ExecuteSQL'_unknownFields
              (\ x__ y__ -> x__{_SparkAction'ExecuteSQL'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Spark_Fields.dataType' @:: Lens' SparkAction'ExtractCell Proto.Karps.Proto.Types.SQLType@
    * 'Proto.Karps.Proto.Spark_Fields.maybe'dataType' @:: Lens' SparkAction'ExtractCell
  (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)@
 -}
data SparkAction'ExtractCell = SparkAction'ExtractCell{_SparkAction'ExtractCell'dataType
                                                       ::
                                                       !(Prelude.Maybe
                                                           Proto.Karps.Proto.Types.SQLType),
                                                       _SparkAction'ExtractCell'_unknownFields ::
                                                       !Data.ProtoLens.FieldSet}
                                 deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f SparkAction'ExtractCell x a,
          a ~ b) =>
         Lens.Labels.HasLens f SparkAction'ExtractCell
           SparkAction'ExtractCell
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction'ExtractCell "dataType"
           (Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'ExtractCell'dataType
                 (\ x__ y__ -> x__{_SparkAction'ExtractCell'dataType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction'ExtractCell "maybe'dataType"
           (Prelude.Maybe Proto.Karps.Proto.Types.SQLType)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'ExtractCell'dataType
                 (\ x__ y__ -> x__{_SparkAction'ExtractCell'dataType = y__}))
              Prelude.id
instance Data.Default.Class.Default SparkAction'ExtractCell where
        def
          = SparkAction'ExtractCell{_SparkAction'ExtractCell'dataType =
                                      Prelude.Nothing,
                                    _SparkAction'ExtractCell'_unknownFields = ([])}
instance Data.ProtoLens.Message SparkAction'ExtractCell where
        messageName _
          = Data.Text.pack "karps.spark.SparkAction.ExtractCell"
        fieldsByTag
          = let dataType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data_type"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'dataType")))
                      :: Data.ProtoLens.FieldDescriptor SparkAction'ExtractCell
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, dataType__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _SparkAction'ExtractCell'_unknownFields
              (\ x__ y__ -> x__{_SparkAction'ExtractCell'_unknownFields = y__})
{- | Fields :

 -}
data SparkAction'ExtractPandas = SparkAction'ExtractPandas{_SparkAction'ExtractPandas'_unknownFields
                                                           :: !Data.ProtoLens.FieldSet}
                                   deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f SparkAction'ExtractPandas x a,
          a ~ b) =>
         Lens.Labels.HasLens f SparkAction'ExtractPandas
           SparkAction'ExtractPandas
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Data.Default.Class.Default SparkAction'ExtractPandas where
        def
          = SparkAction'ExtractPandas{_SparkAction'ExtractPandas'_unknownFields
                                        = ([])}
instance Data.ProtoLens.Message SparkAction'ExtractPandas where
        messageName _
          = Data.Text.pack "karps.spark.SparkAction.ExtractPandas"
        fieldsByTag = let in Data.Map.fromList []
        unknownFields
          = Lens.Family2.Unchecked.lens
              _SparkAction'ExtractPandas'_unknownFields
              (\ x__ y__ -> x__{_SparkAction'ExtractPandas'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Spark_Fields.parquet' @:: Lens' SparkAction'LoadFromInline Data.ByteString.ByteString@
 -}
data SparkAction'LoadFromInline = SparkAction'LoadFromInline{_SparkAction'LoadFromInline'parquet
                                                             :: !Data.ByteString.ByteString,
                                                             _SparkAction'LoadFromInline'_unknownFields
                                                             :: !Data.ProtoLens.FieldSet}
                                    deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f SparkAction'LoadFromInline x a,
          a ~ b) =>
         Lens.Labels.HasLens f SparkAction'LoadFromInline
           SparkAction'LoadFromInline
           x
           a
           b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkAction'LoadFromInline "parquet"
           (Data.ByteString.ByteString)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkAction'LoadFromInline'parquet
                 (\ x__ y__ -> x__{_SparkAction'LoadFromInline'parquet = y__}))
              Prelude.id
instance Data.Default.Class.Default SparkAction'LoadFromInline
         where
        def
          = SparkAction'LoadFromInline{_SparkAction'LoadFromInline'parquet =
                                         Data.ProtoLens.fieldDefault,
                                       _SparkAction'LoadFromInline'_unknownFields = ([])}
instance Data.ProtoLens.Message SparkAction'LoadFromInline where
        messageName _
          = Data.Text.pack "karps.spark.SparkAction.LoadFromInline"
        fieldsByTag
          = let parquet__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "parquet"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parquet")))
                      :: Data.ProtoLens.FieldDescriptor SparkAction'LoadFromInline
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, parquet__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _SparkAction'LoadFromInline'_unknownFields
              (\ x__ y__ ->
                 x__{_SparkAction'LoadFromInline'_unknownFields = y__})
{- | Fields :

    * 'Proto.Karps.Proto.Spark_Fields.actions' @:: Lens' SparkGraph [SparkAction]@
 -}
data SparkGraph = SparkGraph{_SparkGraph'actions :: ![SparkAction],
                             _SparkGraph'_unknownFields :: !Data.ProtoLens.FieldSet}
                    deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f SparkGraph x a, a ~ b) =>
         Lens.Labels.HasLens f SparkGraph SparkGraph x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f SparkGraph "actions" ([SparkAction])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _SparkGraph'actions
                 (\ x__ y__ -> x__{_SparkGraph'actions = y__}))
              Prelude.id
instance Data.Default.Class.Default SparkGraph where
        def
          = SparkGraph{_SparkGraph'actions = [],
                       _SparkGraph'_unknownFields = ([])}
instance Data.ProtoLens.Message SparkGraph where
        messageName _ = Data.Text.pack "karps.spark.SparkGraph"
        fieldsByTag
          = let actions__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "actions"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor SparkAction)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "actions")))
                      :: Data.ProtoLens.FieldDescriptor SparkGraph
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, actions__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _SparkGraph'_unknownFields
              (\ x__ y__ -> x__{_SparkGraph'_unknownFields = y__})