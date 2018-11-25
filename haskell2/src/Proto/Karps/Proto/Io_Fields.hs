{- This file was auto-generated from karps/proto/io.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Karps.Proto.Io_Fields where
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

boolValue ::
          forall f s t a b . (Lens.Labels.HasLens f s t "boolValue" a b) =>
            Lens.Family2.LensLike f s t a b
boolValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "boolValue")
data' ::
      forall f s t a b . (Lens.Labels.HasLens f s t "data'" a b) =>
        Lens.Family2.LensLike f s t a b
data'
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "data'")
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
key ::
    forall f s t a b . (Lens.Labels.HasLens f s t "key" a b) =>
      Lens.Family2.LensLike f s t a b
key
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "key")
maybe'boolValue ::
                forall f s t a b .
                  (Lens.Labels.HasLens f s t "maybe'boolValue" a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'boolValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'boolValue")
maybe'doubleValue ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'doubleValue" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'doubleValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'doubleValue")
maybe'intValue ::
               forall f s t a b .
                 (Lens.Labels.HasLens f s t "maybe'intValue" a b) =>
                 Lens.Family2.LensLike f s t a b
maybe'intValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'intValue")
maybe'schema ::
             forall f s t a b .
               (Lens.Labels.HasLens f s t "maybe'schema" a b) =>
               Lens.Family2.LensLike f s t a b
maybe'schema
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'schema")
maybe'stringValue ::
                  forall f s t a b .
                    (Lens.Labels.HasLens f s t "maybe'stringValue" a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'stringValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'stringValue")
maybe'value ::
            forall f s t a b . (Lens.Labels.HasLens f s t "maybe'value" a b) =>
              Lens.Family2.LensLike f s t a b
maybe'value
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'value")
options ::
        forall f s t a b . (Lens.Labels.HasLens f s t "options" a b) =>
          Lens.Family2.LensLike f s t a b
options
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "options")
path ::
     forall f s t a b . (Lens.Labels.HasLens f s t "path" a b) =>
       Lens.Family2.LensLike f s t a b
path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")
schema ::
       forall f s t a b . (Lens.Labels.HasLens f s t "schema" a b) =>
         Lens.Family2.LensLike f s t a b
schema
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "schema")
source ::
       forall f s t a b . (Lens.Labels.HasLens f s t "source" a b) =>
         Lens.Family2.LensLike f s t a b
source
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "source")
stamp ::
      forall f s t a b . (Lens.Labels.HasLens f s t "stamp" a b) =>
        Lens.Family2.LensLike f s t a b
stamp
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "stamp")
stringValue ::
            forall f s t a b . (Lens.Labels.HasLens f s t "stringValue" a b) =>
              Lens.Family2.LensLike f s t a b
stringValue
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "stringValue")
uri ::
    forall f s t a b . (Lens.Labels.HasLens f s t "uri" a b) =>
      Lens.Family2.LensLike f s t a b
uri
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "uri")