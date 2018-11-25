{- This file was auto-generated from karps/proto/row.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Row_Fields where
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

arrayValue ::
           forall f s t a b . (Lens.Labels.HasLens f s t "arrayValue" a b) =>
             Lens.Family2.LensLike f s t a b
arrayValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "arrayValue")
boolValue ::
          forall f s t a b . (Lens.Labels.HasLens f s t "boolValue" a b) =>
            Lens.Family2.LensLike f s t a b
boolValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "boolValue")
cell ::
     forall f s t a b . (Lens.Labels.HasLens f s t "cell" a b) =>
       Lens.Family2.LensLike f s t a b
cell
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "cell")
cellType ::
         forall f s t a b . (Lens.Labels.HasLens f s t "cellType" a b) =>
           Lens.Family2.LensLike f s t a b
cellType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "cellType")
doubleValue ::
            forall f s t a b . (Lens.Labels.HasLens f s t "doubleValue" a b) =>
              Lens.Family2.LensLike f s t a b
doubleValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "doubleValue")
intValue ::
         forall f s t a b . (Lens.Labels.HasLens f s t "intValue" a b) =>
           Lens.Family2.LensLike f s t a b
intValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "intValue")
maybe'arrayValue ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "maybe'arrayValue" a b) =>
                   Lens.Family2.LensLike f s t a b
maybe'arrayValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'arrayValue")
maybe'boolValue ::
                forall f s t a b .
                  (Lens.Labels.HasLens f s t "maybe'boolValue" a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'boolValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'boolValue")
maybe'cell ::
           forall f s t a b . (Lens.Labels.HasLens f s t "maybe'cell" a b) =>
             Lens.Family2.LensLike f s t a b
maybe'cell
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'cell")
maybe'cellType ::
               forall f s t a b .
                 (Lens.Labels.HasLens f s t "maybe'cellType" a b) =>
                 Lens.Family2.LensLike f s t a b
maybe'cellType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'cellType")
maybe'doubleValue ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'doubleValue" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'doubleValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'doubleValue")
maybe'element ::
              forall f s t a b .
                (Lens.Labels.HasLens f s t "maybe'element" a b) =>
                Lens.Family2.LensLike f s t a b
maybe'element
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'element")
maybe'intValue ::
               forall f s t a b .
                 (Lens.Labels.HasLens f s t "maybe'intValue" a b) =>
                 Lens.Family2.LensLike f s t a b
maybe'intValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'intValue")
maybe'stringValue ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'stringValue" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'stringValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'stringValue")
maybe'structValue ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'structValue" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'structValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'structValue")
stringValue ::
            forall f s t a b . (Lens.Labels.HasLens f s t "stringValue" a b) =>
              Lens.Family2.LensLike f s t a b
stringValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "stringValue")
structValue ::
            forall f s t a b . (Lens.Labels.HasLens f s t "structValue" a b) =>
              Lens.Family2.LensLike f s t a b
structValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "structValue")
values ::
       forall f s t a b . (Lens.Labels.HasLens f s t "values" a b) =>
         Lens.Family2.LensLike f s t a b
values
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "values")