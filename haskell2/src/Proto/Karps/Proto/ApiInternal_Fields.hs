{- This file was auto-generated from karps/proto/api_internal.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.ApiInternal_Fields where
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
import qualified Proto.Karps.Proto.Spark
import qualified Proto.Tensorflow.Core.Framework.Graph

computation ::
            forall f s t a b . (Lens.Labels.HasLens f s t "computation" a b) =>
              Lens.Family2.LensLike f s t a b
computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "computation")
content ::
        forall f s t a b . (Lens.Labels.HasLens f s t "content" a b) =>
          Lens.Family2.LensLike f s t a b
content
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "content")
error ::
      forall f s t a b . (Lens.Labels.HasLens f s t "error" a b) =>
        Lens.Family2.LensLike f s t a b
error
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "error")
extra ::
      forall f s t a b . (Lens.Labels.HasLens f s t "extra" a b) =>
        Lens.Family2.LensLike f s t a b
extra
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "extra")
file ::
     forall f s t a b . (Lens.Labels.HasLens f s t "file" a b) =>
       Lens.Family2.LensLike f s t a b
file
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "file")
function ::
         forall f s t a b . (Lens.Labels.HasLens f s t "function" a b) =>
           Lens.Family2.LensLike f s t a b
function
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "function")
functionalGraph ::
                forall f s t a b .
                  (Lens.Labels.HasLens f s t "functionalGraph" a b) =>
                  Lens.Family2.LensLike f s t a b
functionalGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "functionalGraph")
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
hsStack ::
        forall f s t a b . (Lens.Labels.HasLens f s t "hsStack" a b) =>
          Lens.Family2.LensLike f s t a b
hsStack
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "hsStack")
level ::
      forall f s t a b . (Lens.Labels.HasLens f s t "level" a b) =>
        Lens.Family2.LensLike f s t a b
level
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "level")
maybe'computation ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'computation" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'computation")
maybe'error ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'error" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'error
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'error")
maybe'extra ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'extra" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'extra
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'extra")
maybe'functionalGraph ::
                      forall f s t a b .
                        (Lens.Labels.HasLens f s t "maybe'functionalGraph" a b) =>
                        Lens.Family2.LensLike f s t a b
maybe'functionalGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'functionalGraph")
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
maybe'node ::
           forall f s t a b . (Lens.Labels.HasLens f s t "maybe'node" a b) =>
             Lens.Family2.LensLike f s t a b
maybe'node
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'node")
maybe'path ::
           forall f s t a b . (Lens.Labels.HasLens f s t "maybe'path" a b) =>
             Lens.Family2.LensLike f s t a b
maybe'path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'path")
maybe'pinnedGraph ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'pinnedGraph" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'pinnedGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'pinnedGraph")
maybe'relevantId ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "maybe'relevantId" a b) =>
                   Lens.Family2.LensLike f s t a b
maybe'relevantId
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'relevantId")
maybe'requestedScope ::
                     forall f s t a b .
                       (Lens.Labels.HasLens f s t "maybe'requestedScope" a b) =>
                       Lens.Family2.LensLike f s t a b
maybe'requestedScope
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'requestedScope")
maybe'session ::
              forall f s t a b .
                (Lens.Labels.HasLens f s t "maybe'session" a b) =>
                Lens.Family2.LensLike f s t a b
maybe'session
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'session")
maybe'spark ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'spark" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'spark
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'spark")
maybe'success ::
              forall f s t a b .
                (Lens.Labels.HasLens f s t "maybe'success" a b) =>
                Lens.Family2.LensLike f s t a b
maybe'success
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'success")
message ::
        forall f s t a b . (Lens.Labels.HasLens f s t "message" a b) =>
          Lens.Family2.LensLike f s t a b
message
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "message")
messages ::
         forall f s t a b . (Lens.Labels.HasLens f s t "messages" a b) =>
           Lens.Family2.LensLike f s t a b
messages
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "messages")
module' ::
        forall f s t a b . (Lens.Labels.HasLens f s t "module'" a b) =>
          Lens.Family2.LensLike f s t a b
module'
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "module'")
node ::
     forall f s t a b . (Lens.Labels.HasLens f s t "node" a b) =>
       Lens.Family2.LensLike f s t a b
node
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "node")
opName ::
       forall f s t a b . (Lens.Labels.HasLens f s t "opName" a b) =>
         Lens.Family2.LensLike f s t a b
opName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "opName")
package ::
        forall f s t a b . (Lens.Labels.HasLens f s t "package" a b) =>
          Lens.Family2.LensLike f s t a b
package
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "package")
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
phase ::
      forall f s t a b . (Lens.Labels.HasLens f s t "phase" a b) =>
        Lens.Family2.LensLike f s t a b
phase
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "phase")
pinnedGraph ::
            forall f s t a b . (Lens.Labels.HasLens f s t "pinnedGraph" a b) =>
              Lens.Family2.LensLike f s t a b
pinnedGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "pinnedGraph")
relevantId ::
           forall f s t a b . (Lens.Labels.HasLens f s t "relevantId" a b) =>
             Lens.Family2.LensLike f s t a b
relevantId
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "relevantId")
requestedPaths ::
               forall f s t a b .
                 (Lens.Labels.HasLens f s t "requestedPaths" a b) =>
                 Lens.Family2.LensLike f s t a b
requestedPaths
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "requestedPaths")
requestedScope ::
               forall f s t a b .
                 (Lens.Labels.HasLens f s t "requestedScope" a b) =>
                 Lens.Family2.LensLike f s t a b
requestedScope
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "requestedScope")
session ::
        forall f s t a b . (Lens.Labels.HasLens f s t "session" a b) =>
          Lens.Family2.LensLike f s t a b
session
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "session")
spark ::
      forall f s t a b . (Lens.Labels.HasLens f s t "spark" a b) =>
        Lens.Family2.LensLike f s t a b
spark
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "spark")
stackTracePretty ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "stackTracePretty" a b) =>
                   Lens.Family2.LensLike f s t a b
stackTracePretty
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "stackTracePretty")
startCol ::
         forall f s t a b . (Lens.Labels.HasLens f s t "startCol" a b) =>
           Lens.Family2.LensLike f s t a b
startCol
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "startCol")
startLine ::
          forall f s t a b . (Lens.Labels.HasLens f s t "startLine" a b) =>
            Lens.Family2.LensLike f s t a b
startLine
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "startLine")
steps ::
      forall f s t a b . (Lens.Labels.HasLens f s t "steps" a b) =>
        Lens.Family2.LensLike f s t a b
steps
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "steps")
success ::
        forall f s t a b . (Lens.Labels.HasLens f s t "success" a b) =>
          Lens.Family2.LensLike f s t a b
success
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "success")