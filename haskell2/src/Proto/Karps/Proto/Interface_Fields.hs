{- This file was auto-generated from karps/proto/interface.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Interface_Fields where
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
import qualified Proto.Karps.Proto.Io
import qualified Proto.Karps.Proto.Profiling

compilationGraph ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "compilationGraph" a b) =>
                   Lens.Family2.LensLike f s t a b
compilationGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "compilationGraph")
compilationResult ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "compilationResult" a b) =>
                    Lens.Family2.LensLike f s t a b
compilationResult
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "compilationResult")
computation ::
            forall f s t a b . (Lens.Labels.HasLens f s t "computation" a b) =>
              Lens.Family2.LensLike f s t a b
computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "computation")
computationTrace ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "computationTrace" a b) =>
                   Lens.Family2.LensLike f s t a b
computationTrace
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "computationTrace")
error ::
      forall f s t a b . (Lens.Labels.HasLens f s t "error" a b) =>
        Lens.Family2.LensLike f s t a b
error
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "error")
graph ::
      forall f s t a b . (Lens.Labels.HasLens f s t "graph" a b) =>
        Lens.Family2.LensLike f s t a b
graph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "graph")
maybe'compilationResult ::
                        forall f s t a b .
                          (Lens.Labels.HasLens f s t "maybe'compilationResult" a b) =>
                          Lens.Family2.LensLike f s t a b
maybe'compilationResult
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'compilationResult")
maybe'computation ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'computation" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'computation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'computation")
maybe'computationTrace ::
                       forall f s t a b .
                         (Lens.Labels.HasLens f s t "maybe'computationTrace" a b) =>
                         Lens.Family2.LensLike f s t a b
maybe'computationTrace
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'computationTrace")
maybe'graph ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'graph" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'graph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graph")
maybe'pinnedGraph ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'pinnedGraph" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'pinnedGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'pinnedGraph")
maybe'requestedComputation ::
                           forall f s t a b .
                             (Lens.Labels.HasLens f s t "maybe'requestedComputation" a b) =>
                             Lens.Family2.LensLike f s t a b
maybe'requestedComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'requestedComputation")
maybe'requestedSession ::
                       forall f s t a b .
                         (Lens.Labels.HasLens f s t "maybe'requestedSession" a b) =>
                         Lens.Family2.LensLike f s t a b
maybe'requestedSession
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'requestedSession")
maybe'results ::
              forall f s t a b .
                (Lens.Labels.HasLens f s t "maybe'results" a b) =>
                Lens.Family2.LensLike f s t a b
maybe'results
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'results")
maybe'session ::
              forall f s t a b .
                (Lens.Labels.HasLens f s t "maybe'session" a b) =>
                Lens.Family2.LensLike f s t a b
maybe'session
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'session")
maybe'startGraph ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "maybe'startGraph" a b) =>
                   Lens.Family2.LensLike f s t a b
maybe'startGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'startGraph")
pinnedGraph ::
            forall f s t a b . (Lens.Labels.HasLens f s t "pinnedGraph" a b) =>
              Lens.Family2.LensLike f s t a b
pinnedGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "pinnedGraph")
requestedComputation ::
                     forall f s t a b .
                       (Lens.Labels.HasLens f s t "requestedComputation" a b) =>
                       Lens.Family2.LensLike f s t a b
requestedComputation
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "requestedComputation")
requestedPaths ::
               forall f s t a b .
                 (Lens.Labels.HasLens f s t "requestedPaths" a b) =>
                 Lens.Family2.LensLike f s t a b
requestedPaths
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "requestedPaths")
requestedSession ::
                 forall f s t a b .
                   (Lens.Labels.HasLens f s t "requestedSession" a b) =>
                   Lens.Family2.LensLike f s t a b
requestedSession
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "requestedSession")
results ::
        forall f s t a b . (Lens.Labels.HasLens f s t "results" a b) =>
          Lens.Family2.LensLike f s t a b
results
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "results")
session ::
        forall f s t a b . (Lens.Labels.HasLens f s t "session" a b) =>
          Lens.Family2.LensLike f s t a b
session
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "session")
startGraph ::
           forall f s t a b . (Lens.Labels.HasLens f s t "startGraph" a b) =>
             Lens.Family2.LensLike f s t a b
startGraph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "startGraph")