{- This file was auto-generated from tensorflow/core/framework/attr_value.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Tensorflow.Core.Framework.AttrValue_Fields where
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

attr ::
     forall f s t a b . (Lens.Labels.HasLens f s t "attr" a b) =>
       Lens.Family2.LensLike f s t a b
attr
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "attr")
b ::
  forall f s t a b . (Lens.Labels.HasLens f s t "b" a b) =>
    Lens.Family2.LensLike f s t a b
b = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "b")
f ::
  forall f s t a b . (Lens.Labels.HasLens f s t "f" a b) =>
    Lens.Family2.LensLike f s t a b
f = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "f")
func ::
     forall f s t a b . (Lens.Labels.HasLens f s t "func" a b) =>
       Lens.Family2.LensLike f s t a b
func
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "func")
i ::
  forall f s t a b . (Lens.Labels.HasLens f s t "i" a b) =>
    Lens.Family2.LensLike f s t a b
i = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "i")
key ::
    forall f s t a b . (Lens.Labels.HasLens f s t "key" a b) =>
      Lens.Family2.LensLike f s t a b
key
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "key")
list ::
     forall f s t a b . (Lens.Labels.HasLens f s t "list" a b) =>
       Lens.Family2.LensLike f s t a b
list
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "list")
maybe'b ::
        forall f s t a b . (Lens.Labels.HasLens f s t "maybe'b" a b) =>
          Lens.Family2.LensLike f s t a b
maybe'b
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'b")
maybe'f ::
        forall f s t a b . (Lens.Labels.HasLens f s t "maybe'f" a b) =>
          Lens.Family2.LensLike f s t a b
maybe'f
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'f")
maybe'i ::
        forall f s t a b . (Lens.Labels.HasLens f s t "maybe'i" a b) =>
          Lens.Family2.LensLike f s t a b
maybe'i
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'i")
maybe'list ::
           forall f s t a b . (Lens.Labels.HasLens f s t "maybe'list" a b) =>
             Lens.Family2.LensLike f s t a b
maybe'list
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'list")
maybe's ::
        forall f s t a b . (Lens.Labels.HasLens f s t "maybe's" a b) =>
          Lens.Family2.LensLike f s t a b
maybe's
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe's")
maybe'value ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'value" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'value
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'value")
name ::
     forall f s t a b . (Lens.Labels.HasLens f s t "name" a b) =>
       Lens.Family2.LensLike f s t a b
name
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "name")
s ::
  forall f s t a b . (Lens.Labels.HasLens f s t "s" a b) =>
    Lens.Family2.LensLike f s t a b
s = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "s")
value ::
      forall f s t a b . (Lens.Labels.HasLens f s t "value" a b) =>
        Lens.Family2.LensLike f s t a b
value
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "value")