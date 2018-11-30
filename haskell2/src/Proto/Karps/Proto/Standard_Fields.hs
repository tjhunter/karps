{- This file was auto-generated from karps/proto/standard.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Standard_Fields where
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
import qualified Proto.Karps.Proto.Computation
import qualified Proto.Karps.Proto.Graph
import qualified Proto.Karps.Proto.StructuredTransform
import qualified Proto.Karps.Proto.Types

aggOp ::
      forall f s t a b . (Lens.Labels.HasLens f s t "aggOp" a b) =>
        Lens.Family2.LensLike f s t a b
aggOp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "aggOp")
colOp ::
      forall f s t a b . (Lens.Labels.HasLens f s t "colOp" a b) =>
        Lens.Family2.LensLike f s t a b
colOp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "colOp")
computation ::
            forall f s t a b . (Lens.Labels.HasLens f s t "computation" a b) =>
              Lens.Family2.LensLike f s t a b
computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "computation")
dataType ::
         forall f s t a b . (Lens.Labels.HasLens f s t "dataType" a b) =>
           Lens.Family2.LensLike f s t a b
dataType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "dataType")
jointType ::
          forall f s t a b . (Lens.Labels.HasLens f s t "jointType" a b) =>
            Lens.Family2.LensLike f s t a b
jointType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "jointType")
localPath ::
          forall f s t a b . (Lens.Labels.HasLens f s t "localPath" a b) =>
            Lens.Family2.LensLike f s t a b
localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "localPath")
locality ::
         forall f s t a b . (Lens.Labels.HasLens f s t "locality" a b) =>
           Lens.Family2.LensLike f s t a b
locality
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "locality")
maybe'aggOp ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'aggOp" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'aggOp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'aggOp")
maybe'colOp ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'colOp" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'colOp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'colOp")
maybe'computation ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'computation" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'computation")
maybe'dataType ::
               forall f s t a b .
                 (Lens.Labels.HasLens f s t "maybe'dataType" a b) =>
                 Lens.Family2.LensLike f s t a b
maybe'dataType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'dataType")
maybe'localPath ::
                forall f s t a b .
                  (Lens.Labels.HasLens f s t "maybe'localPath" a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'localPath")
parquet ::
        forall f s t a b . (Lens.Labels.HasLens f s t "parquet" a b) =>
          Lens.Family2.LensLike f s t a b
parquet
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parquet")