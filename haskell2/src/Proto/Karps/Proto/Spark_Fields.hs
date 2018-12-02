{- This file was auto-generated from karps/proto/spark.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Spark_Fields where
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

actions ::
        forall f s t a b . (Lens.Labels.HasLens f s t "actions" a b) =>
          Lens.Family2.LensLike f s t a b
actions
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "actions")
dataType ::
         forall f s t a b . (Lens.Labels.HasLens f s t "dataType" a b) =>
           Lens.Family2.LensLike f s t a b
dataType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "dataType")
dependencies ::
             forall f s t a b .
               (Lens.Labels.HasLens f s t "dependencies" a b) =>
               Lens.Family2.LensLike f s t a b
dependencies
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "dependencies")
execSql ::
        forall f s t a b . (Lens.Labels.HasLens f s t "execSql" a b) =>
          Lens.Family2.LensLike f s t a b
execSql
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "execSql")
extractCell ::
            forall f s t a b . (Lens.Labels.HasLens f s t "extractCell" a b) =>
              Lens.Family2.LensLike f s t a b
extractCell
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "extractCell")
extractPandas ::
              forall f s t a b .
                (Lens.Labels.HasLens f s t "extractPandas" a b) =>
                Lens.Family2.LensLike f s t a b
extractPandas
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "extractPandas")
loadInline ::
           forall f s t a b . (Lens.Labels.HasLens f s t "loadInline" a b) =>
             Lens.Family2.LensLike f s t a b
loadInline
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "loadInline")
maybe'action ::
             forall f s t a b .
               (Lens.Labels.HasLens f s t "maybe'action" a b) =>
               Lens.Family2.LensLike f s t a b
maybe'action
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'action")
maybe'dataType ::
               forall f s t a b .
                 (Lens.Labels.HasLens f s t "maybe'dataType" a b) =>
                 Lens.Family2.LensLike f s t a b
maybe'dataType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'dataType")
maybe'execSql ::
              forall f s t a b .
                (Lens.Labels.HasLens f s t "maybe'execSql" a b) =>
                Lens.Family2.LensLike f s t a b
maybe'execSql
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'execSql")
maybe'extractCell ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'extractCell" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'extractCell
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'extractCell")
maybe'extractPandas ::
                    forall f s t a b .
                      (Lens.Labels.HasLens f s t "maybe'extractPandas" a b) =>
                      Lens.Family2.LensLike f s t a b
maybe'extractPandas
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'extractPandas")
maybe'loadInline ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "maybe'loadInline" a b) =>
                   Lens.Family2.LensLike f s t a b
maybe'loadInline
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'loadInline")
maybe'path ::
           forall f s t a b . (Lens.Labels.HasLens f s t "maybe'path" a b) =>
             Lens.Family2.LensLike f s t a b
maybe'path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'path")
parquet ::
        forall f s t a b . (Lens.Labels.HasLens f s t "parquet" a b) =>
          Lens.Family2.LensLike f s t a b
parquet
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parquet")
path ::
     forall f s t a b . (Lens.Labels.HasLens f s t "path" a b) =>
       Lens.Family2.LensLike f s t a b
path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")
statement ::
          forall f s t a b . (Lens.Labels.HasLens f s t "statement" a b) =>
            Lens.Family2.LensLike f s t a b
statement
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "statement")
tableName ::
          forall f s t a b . (Lens.Labels.HasLens f s t "tableName" a b) =>
            Lens.Family2.LensLike f s t a b
tableName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "tableName")