{- This file was auto-generated from karps/proto/graph.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Graph_Fields where
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
import qualified Proto.Tensorflow.Core.Framework.Graph

content ::
        forall f s t a b . (Lens.Labels.HasLens f s t "content" a b) =>
          Lens.Family2.LensLike f s t a b
content
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "content")
contentBase64 ::
              forall f s t a b .
                (Lens.Labels.HasLens f s t "contentBase64" a b) =>
                Lens.Family2.LensLike f s t a b
contentBase64
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "contentBase64")
contentDebug ::
             forall f s t a b .
               (Lens.Labels.HasLens f s t "contentDebug" a b) =>
               Lens.Family2.LensLike f s t a b
contentDebug
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "contentDebug")
errorMessage ::
             forall f s t a b .
               (Lens.Labels.HasLens f s t "errorMessage" a b) =>
               Lens.Family2.LensLike f s t a b
errorMessage
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "errorMessage")
graph ::
      forall f s t a b . (Lens.Labels.HasLens f s t "graph" a b) =>
        Lens.Family2.LensLike f s t a b
graph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "graph")
graphDef ::
         forall f s t a b . (Lens.Labels.HasLens f s t "graphDef" a b) =>
           Lens.Family2.LensLike f s t a b
graphDef
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "graphDef")
graphTensorboardRepr ::
                     forall f s t a b .
                       (Lens.Labels.HasLens f s t "graphTensorboardRepr" a b) =>
                       Lens.Family2.LensLike f s t a b
graphTensorboardRepr
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "graphTensorboardRepr")
inferedType ::
            forall f s t a b . (Lens.Labels.HasLens f s t "inferedType" a b) =>
              Lens.Family2.LensLike f s t a b
inferedType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "inferedType")
locality ::
         forall f s t a b . (Lens.Labels.HasLens f s t "locality" a b) =>
           Lens.Family2.LensLike f s t a b
locality
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "locality")
logicalDependencies ::
                    forall f s t a b .
                      (Lens.Labels.HasLens f s t "logicalDependencies" a b) =>
                      Lens.Family2.LensLike f s t a b
logicalDependencies
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "logicalDependencies")
maybe'graph ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'graph" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'graph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graph")
maybe'graphDef ::
               forall f s t a b .
                 (Lens.Labels.HasLens f s t "maybe'graphDef" a b) =>
                 Lens.Family2.LensLike f s t a b
maybe'graphDef
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graphDef")
maybe'inferedType ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'inferedType" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'inferedType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'inferedType")
maybe'opExtra ::
              forall f s t a b .
                (Lens.Labels.HasLens f s t "maybe'opExtra" a b) =>
                Lens.Family2.LensLike f s t a b
maybe'opExtra
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'opExtra")
maybe'path ::
           forall f s t a b . (Lens.Labels.HasLens f s t "maybe'path" a b) =>
             Lens.Family2.LensLike f s t a b
maybe'path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'path")
nodes ::
      forall f s t a b . (Lens.Labels.HasLens f s t "nodes" a b) =>
        Lens.Family2.LensLike f s t a b
nodes
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "nodes")
opExtra ::
        forall f s t a b . (Lens.Labels.HasLens f s t "opExtra" a b) =>
          Lens.Family2.LensLike f s t a b
opExtra
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "opExtra")
opName ::
       forall f s t a b . (Lens.Labels.HasLens f s t "opName" a b) =>
         Lens.Family2.LensLike f s t a b
opName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "opName")
parents ::
        forall f s t a b . (Lens.Labels.HasLens f s t "parents" a b) =>
          Lens.Family2.LensLike f s t a b
parents
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parents")
path ::
     forall f s t a b . (Lens.Labels.HasLens f s t "path" a b) =>
       Lens.Family2.LensLike f s t a b
path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")
phaseName ::
          forall f s t a b . (Lens.Labels.HasLens f s t "phaseName" a b) =>
            Lens.Family2.LensLike f s t a b
phaseName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "phaseName")