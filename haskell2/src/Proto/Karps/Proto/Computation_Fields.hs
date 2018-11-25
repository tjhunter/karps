{- This file was auto-generated from karps/proto/computation.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Computation_Fields where
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
import qualified Proto.Karps.Proto.Row
import qualified Proto.Tensorflow.Core.Framework.NodeDef

analyzed ::
         forall f s t a b . (Lens.Labels.HasLens f s t "analyzed" a b) =>
           Lens.Family2.LensLike f s t a b
analyzed
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "analyzed")
className ::
          forall f s t a b . (Lens.Labels.HasLens f s t "className" a b) =>
            Lens.Family2.LensLike f s t a b
className
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "className")
computation ::
            forall f s t a b . (Lens.Labels.HasLens f s t "computation" a b) =>
              Lens.Family2.LensLike f s t a b
computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "computation")
dependencies ::
             forall f s t a b .
               (Lens.Labels.HasLens f s t "dependencies" a b) =>
               Lens.Family2.LensLike f s t a b
dependencies
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "dependencies")
finalError ::
           forall f s t a b . (Lens.Labels.HasLens f s t "finalError" a b) =>
             Lens.Family2.LensLike f s t a b
finalError
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "finalError")
finalResult ::
            forall f s t a b . (Lens.Labels.HasLens f s t "finalResult" a b) =>
              Lens.Family2.LensLike f s t a b
finalResult
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "finalResult")
fullName ::
         forall f s t a b . (Lens.Labels.HasLens f s t "fullName" a b) =>
           Lens.Family2.LensLike f s t a b
fullName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fullName")
id ::
   forall f s t a b . (Lens.Labels.HasLens f s t "id" a b) =>
     Lens.Family2.LensLike f s t a b
id
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "id")
localPath ::
          forall f s t a b . (Lens.Labels.HasLens f s t "localPath" a b) =>
            Lens.Family2.LensLike f s t a b
localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "localPath")
maybe'computation ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'computation" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'computation")
maybe'finalResult ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'finalResult" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'finalResult
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'finalResult")
maybe'localPath ::
                forall f s t a b .
                  (Lens.Labels.HasLens f s t "maybe'localPath" a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'localPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'localPath")
maybe'proto ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'proto" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'proto
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'proto")
maybe'sparkStats ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "maybe'sparkStats" a b) =>
                   Lens.Family2.LensLike f s t a b
maybe'sparkStats
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'sparkStats")
maybe'targetPath ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "maybe'targetPath" a b) =>
                   Lens.Family2.LensLike f s t a b
maybe'targetPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'targetPath")
nodeId ::
       forall f s t a b . (Lens.Labels.HasLens f s t "nodeId" a b) =>
         Lens.Family2.LensLike f s t a b
nodeId
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "nodeId")
optimized ::
          forall f s t a b . (Lens.Labels.HasLens f s t "optimized" a b) =>
            Lens.Family2.LensLike f s t a b
optimized
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "optimized")
parentNodes ::
            forall f s t a b . (Lens.Labels.HasLens f s t "parentNodes" a b) =>
              Lens.Family2.LensLike f s t a b
parentNodes
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parentNodes")
parents ::
        forall f s t a b . (Lens.Labels.HasLens f s t "parents" a b) =>
          Lens.Family2.LensLike f s t a b
parents
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parents")
parsed ::
       forall f s t a b . (Lens.Labels.HasLens f s t "parsed" a b) =>
         Lens.Family2.LensLike f s t a b
parsed
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parsed")
physical ::
         forall f s t a b . (Lens.Labels.HasLens f s t "physical" a b) =>
           Lens.Family2.LensLike f s t a b
physical
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "physical")
proto ::
      forall f s t a b . (Lens.Labels.HasLens f s t "proto" a b) =>
        Lens.Family2.LensLike f s t a b
proto
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "proto")
rddId ::
      forall f s t a b . (Lens.Labels.HasLens f s t "rddId" a b) =>
        Lens.Family2.LensLike f s t a b
rddId
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "rddId")
rddInfo ::
        forall f s t a b . (Lens.Labels.HasLens f s t "rddInfo" a b) =>
          Lens.Family2.LensLike f s t a b
rddInfo
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "rddInfo")
repr ::
     forall f s t a b . (Lens.Labels.HasLens f s t "repr" a b) =>
       Lens.Family2.LensLike f s t a b
repr
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "repr")
results ::
        forall f s t a b . (Lens.Labels.HasLens f s t "results" a b) =>
          Lens.Family2.LensLike f s t a b
results
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "results")
sparkStats ::
           forall f s t a b . (Lens.Labels.HasLens f s t "sparkStats" a b) =>
             Lens.Family2.LensLike f s t a b
sparkStats
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "sparkStats")
status ::
       forall f s t a b . (Lens.Labels.HasLens f s t "status" a b) =>
         Lens.Family2.LensLike f s t a b
status
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "status")
targetPath ::
           forall f s t a b . (Lens.Labels.HasLens f s t "targetPath" a b) =>
             Lens.Family2.LensLike f s t a b
targetPath
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "targetPath")