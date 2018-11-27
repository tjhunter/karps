{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Spark.Common.ProtoUtils(ToProto(..), FromProto(..), extractMaybe, extractMaybe') where

import Data.ProtoLens.Message(Message(messageName))
import Lens.Family2 ((^.), FoldLike)
import Data.ProtoLens.TextFormat(showMessageShort)
import Formatting
import Data.CallStack(HasCallStack)
import Data.Text(Text)
import Data.Proxy

import Spark.Common.Try(Try, tryError)

{-| The class of types that can be read from a proto description. -}
class FromProto p x | x -> p where
  fromProto :: (Message p, HasCallStack) => p -> Try x

{-| The class of types that can be exported to a proto type. -}
class ToProto p x | x -> p where
  toProto :: (Message p) => x -> p

extractMaybe :: forall m a1 a' b. (Message m, HasCallStack) => m -> FoldLike (Maybe a1) m a' (Maybe a1) b -> Text -> Try a1
extractMaybe msg fun ctx =
  case msg ^. fun of
    Just x' -> return x'
    Nothing -> tryError $ sformat ("extractMaybe: extraction failed in context "%shown%" for message of type:"%shown%" value:"%shown) ctx txt msg' where
      p = Proxy :: Proxy m
      txt = messageName p
      msg' = showMessageShort msg

extractMaybe' :: (Message m, Message m1, FromProto m1 a1, HasCallStack) => m -> FoldLike (Maybe m1) m a' (Maybe m1) b -> Text -> Try a1
extractMaybe' msg fun ctx = extractMaybe msg fun ctx >>= fromProto
