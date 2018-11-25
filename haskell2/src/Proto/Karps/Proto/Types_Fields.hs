{- This file was auto-generated from karps/proto/types.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Types_Fields where
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

arrayType ::
          forall f s t a b . (Lens.Labels.HasLens f s t "arrayType" a b) =>
            Lens.Family2.LensLike f s t a b
arrayType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "arrayType")
basicType ::
          forall f s t a b . (Lens.Labels.HasLens f s t "basicType" a b) =>
            Lens.Family2.LensLike f s t a b
basicType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "basicType")
fieldName ::
          forall f s t a b . (Lens.Labels.HasLens f s t "fieldName" a b) =>
            Lens.Family2.LensLike f s t a b
fieldName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fieldName")
fieldType ::
          forall f s t a b . (Lens.Labels.HasLens f s t "fieldType" a b) =>
            Lens.Family2.LensLike f s t a b
fieldType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fieldType")
fields ::
       forall f s t a b . (Lens.Labels.HasLens f s t "fields" a b) =>
         Lens.Family2.LensLike f s t a b
fields
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fields")
maybe'arrayType ::
                forall f s t a b .
                  (Lens.Labels.HasLens f s t "maybe'arrayType" a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'arrayType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'arrayType")
maybe'basicType ::
                forall f s t a b .
                  (Lens.Labels.HasLens f s t "maybe'basicType" a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'basicType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'basicType")
maybe'fieldType ::
                forall f s t a b .
                  (Lens.Labels.HasLens f s t "maybe'fieldType" a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'fieldType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'fieldType")
maybe'strictType ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "maybe'strictType" a b) =>
                   Lens.Family2.LensLike f s t a b
maybe'strictType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'strictType")
maybe'structType ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "maybe'structType" a b) =>
                   Lens.Family2.LensLike f s t a b
maybe'structType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'structType")
nullable ::
         forall f s t a b . (Lens.Labels.HasLens f s t "nullable" a b) =>
           Lens.Family2.LensLike f s t a b
nullable
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "nullable")
structType ::
           forall f s t a b . (Lens.Labels.HasLens f s t "structType" a b) =>
             Lens.Family2.LensLike f s t a b
structType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "structType")