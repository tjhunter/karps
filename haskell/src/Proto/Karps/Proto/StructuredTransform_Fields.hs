{- This file was auto-generated from karps/proto/structured_transform.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.StructuredTransform_Fields where
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

broadcast ::
          forall f s t a b . (Lens.Labels.HasLens f s t "broadcast" a b) =>
            Lens.Family2.LensLike f s t a b
broadcast
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "broadcast")
content ::
        forall f s t a b . (Lens.Labels.HasLens f s t "content" a b) =>
          Lens.Family2.LensLike f s t a b
content
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "content")
expectedType ::
             forall f s t a b .
               (Lens.Labels.HasLens f s t "expectedType" a b) =>
               Lens.Family2.LensLike f s t a b
expectedType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "expectedType")
extraction ::
           forall f s t a b . (Lens.Labels.HasLens f s t "extraction" a b) =>
             Lens.Family2.LensLike f s t a b
extraction
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "extraction")
fieldName ::
          forall f s t a b . (Lens.Labels.HasLens f s t "fieldName" a b) =>
            Lens.Family2.LensLike f s t a b
fieldName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fieldName")
fields ::
       forall f s t a b . (Lens.Labels.HasLens f s t "fields" a b) =>
         Lens.Family2.LensLike f s t a b
fields
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fields")
function ::
         forall f s t a b . (Lens.Labels.HasLens f s t "function" a b) =>
           Lens.Family2.LensLike f s t a b
function
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "function")
functionName ::
             forall f s t a b .
               (Lens.Labels.HasLens f s t "functionName" a b) =>
               Lens.Family2.LensLike f s t a b
functionName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "functionName")
inputs ::
       forall f s t a b . (Lens.Labels.HasLens f s t "inputs" a b) =>
         Lens.Family2.LensLike f s t a b
inputs
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "inputs")
literal ::
        forall f s t a b . (Lens.Labels.HasLens f s t "literal" a b) =>
          Lens.Family2.LensLike f s t a b
literal
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "literal")
maybe'aggOp ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'aggOp" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'aggOp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'aggOp")
maybe'broadcast ::
                forall f s t a b .
                  (Lens.Labels.HasLens f s t "maybe'broadcast" a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'broadcast
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'broadcast")
maybe'content ::
              forall f s t a b .
                (Lens.Labels.HasLens f s t "maybe'content" a b) =>
                Lens.Family2.LensLike f s t a b
maybe'content
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'content")
maybe'expectedType ::
                   forall f s t a b .
                     (Lens.Labels.HasLens f s t "maybe'expectedType" a b) =>
                     Lens.Family2.LensLike f s t a b
maybe'expectedType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'expectedType")
maybe'extraction ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "maybe'extraction" a b) =>
                   Lens.Family2.LensLike f s t a b
maybe'extraction
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'extraction")
maybe'function ::
               forall f s t a b .
                 (Lens.Labels.HasLens f s t "maybe'function" a b) =>
                 Lens.Family2.LensLike f s t a b
maybe'function
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'function")
maybe'literal ::
              forall f s t a b .
                (Lens.Labels.HasLens f s t "maybe'literal" a b) =>
                Lens.Family2.LensLike f s t a b
maybe'literal
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'literal")
maybe'op ::
         forall f s t a b . (Lens.Labels.HasLens f s t "maybe'op" a b) =>
           Lens.Family2.LensLike f s t a b
maybe'op
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'op")
maybe'struct ::
             forall f s t a b .
               (Lens.Labels.HasLens f s t "maybe'struct" a b) =>
               Lens.Family2.LensLike f s t a b
maybe'struct
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'struct")
observableIndex ::
                forall f s t a b .
                  (Lens.Labels.HasLens f s t "observableIndex" a b) =>
                  Lens.Family2.LensLike f s t a b
observableIndex
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "observableIndex")
op ::
   forall f s t a b . (Lens.Labels.HasLens f s t "op" a b) =>
     Lens.Family2.LensLike f s t a b
op
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "op")
path ::
     forall f s t a b . (Lens.Labels.HasLens f s t "path" a b) =>
       Lens.Family2.LensLike f s t a b
path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")
struct ::
       forall f s t a b . (Lens.Labels.HasLens f s t "struct" a b) =>
         Lens.Family2.LensLike f s t a b
struct
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "struct")