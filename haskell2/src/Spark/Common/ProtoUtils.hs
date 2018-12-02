{-# LANGUAGE FunctionalDependencies #-}

module Spark.Common.ProtoUtils(ToProto(..), FromProto(..), extractMaybe, extractMaybe') where

import Data.ProtoLens.Message(Message(messageName))
import Lens.Family2 ((&), (.~), (^.), FoldLike)
import Data.ProtoLens.TextFormat(showMessageShort)
import Formatting
import Data.CallStack(HasCallStack, SrcLoc(..), CallStack)
import Data.Text(Text, pack)
import Data.Proxy
import Data.ProtoLens(def)

import Spark.Common.Try
import qualified Proto.Karps.Proto.ApiInternal as PI
import qualified Proto.Karps.Proto.ApiInternal_Fields as PI


{-| The class of types that can be read from a proto description. -}
class FromProto p x | x -> p where
  fromProto :: (HasCallStack) => p -> Try x

{-| The class of types that can be exported to a proto type. -}
class ToProto p x | x -> p where
  toProto :: x -> p

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

instance ToProto PI.ErrorMessage'StackElement (String, SrcLoc) where
  toProto (fun_name, sl) = (def :: PI.ErrorMessage'StackElement)
      & PI.function .~ pack fun_name
      & PI.package .~ pack (srcLocPackage sl)
      & PI.module' .~ pack (srcLocModule sl)
      & PI.file .~ pack (srcLocFile sl)
      & PI.startLine .~ fromIntegral (srcLocStartLine sl)

instance ToProto PI.ErrorMessage NodeError where
  toProto ne = (def :: PI.ErrorMessage) & PI.message .~ (eMessage ne) & PI.hsStack .~ (toProto <$> (eCallStack ne))
