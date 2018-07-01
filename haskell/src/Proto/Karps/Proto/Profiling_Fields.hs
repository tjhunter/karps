{- This file was auto-generated from karps/proto/profiling.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Profiling_Fields where
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

beginComputation ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "beginComputation" a b) =>
                   Lens.Family2.LensLike f s t a b
beginComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "beginComputation")
chromeEvents ::
             forall f s t a b .
               (Lens.Labels.HasLens f s t "chromeEvents" a b) =>
               Lens.Family2.LensLike f s t a b
chromeEvents
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "chromeEvents")
computationEvents ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "computationEvents" a b) =>
                    Lens.Family2.LensLike f s t a b
computationEvents
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "computationEvents")
endComputation ::
               forall f s t a b .
                 (Lens.Labels.HasLens f s t "endComputation" a b) =>
                 Lens.Family2.LensLike f s t a b
endComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "endComputation")
localPath ::
          forall f s t a b . (Lens.Labels.HasLens f s t "localPath" a b) =>
            Lens.Family2.LensLike f s t a b
localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "localPath")
maybe'beginComputation ::
                       forall f s t a b .
                         (Lens.Labels.HasLens f s t "maybe'beginComputation" a b) =>
                         Lens.Family2.LensLike f s t a b
maybe'beginComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'beginComputation")
maybe'endComputation ::
                     forall f s t a b .
                       (Lens.Labels.HasLens f s t "maybe'endComputation" a b) =>
                       Lens.Family2.LensLike f s t a b
maybe'endComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'endComputation")
maybe'event ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'event" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'event
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'event")
maybe'localPath ::
                forall f s t a b .
                  (Lens.Labels.HasLens f s t "maybe'localPath" a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'localPath")
name ::
     forall f s t a b . (Lens.Labels.HasLens f s t "name" a b) =>
       Lens.Family2.LensLike f s t a b
name
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "name")
ph ::
   forall f s t a b . (Lens.Labels.HasLens f s t "ph" a b) =>
     Lens.Family2.LensLike f s t a b
ph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "ph")
pid ::
    forall f s t a b . (Lens.Labels.HasLens f s t "pid" a b) =>
      Lens.Family2.LensLike f s t a b
pid
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "pid")
tid ::
    forall f s t a b . (Lens.Labels.HasLens f s t "tid" a b) =>
      Lens.Family2.LensLike f s t a b
tid
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "tid")
timestamp ::
          forall f s t a b . (Lens.Labels.HasLens f s t "timestamp" a b) =>
            Lens.Family2.LensLike f s t a b
timestamp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "timestamp")
ts ::
   forall f s t a b . (Lens.Labels.HasLens f s t "ts" a b) =>
     Lens.Family2.LensLike f s t a b
ts
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "ts")