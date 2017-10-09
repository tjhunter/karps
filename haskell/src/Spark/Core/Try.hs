
{-|
Useful classes and functions to deal with failures
within the Karps framework.

This is a developer API. Users should not have to invoke functions
from this module.
-}
module Spark.Core.Try(
  NodeError,
  Try,
  tryError,
  tryEither,
  tryMaybe,
  eMessage,
  eCallStack,
  nodeError,
  forceTry
  ) where

import qualified Data.Text as T
import Data.Function(on)
import Control.Arrow((&&&))
import GHC.Stack(CallStack, HasCallStack, callStack)

-- | An error associated to a particular node (an observable or a dataset).
data NodeError = Error {
  _eStack :: !CallStack,
  _ePath :: [T.Text],
  _eMessage :: T.Text
} deriving (Show)

instance Eq NodeError where
  (==) = (==) `on` (_eMessage &&& _ePath)

-- | The common result of attempting to build something.
-- TODO: should hide the type
type Try = Either NodeError

{-| For the occasions we know that the result should be a success,
this forces the result.
-}
forceTry :: (HasCallStack) => Try a -> a
forceTry (Right x) = x
forceTry (Left e) = error (show e)

eCallStack :: NodeError -> CallStack
eCallStack = _eStack

eMessage :: NodeError -> T.Text
eMessage = _eMessage

nodeError :: (HasCallStack) => T.Text -> NodeError
nodeError = Error callStack []

-- TODO: rename to tryError
_error :: CallStack -> T.Text -> Try a
_error cs txt = Left Error {
    _eStack = cs,
    _ePath = [],
    _eMessage = txt
  }

tryMaybe :: HasCallStack => Maybe a -> T.Text -> Try a
tryMaybe (Just a) _ = pure a
tryMaybe Nothing msg = tryError msg

-- | Returns an error object given a text clue.
tryError :: HasCallStack => T.Text -> Try a
tryError = _error callStack

-- | Returns an error object given a string clue.
--Remove this method
--tryError' :: String -> Try a
--tryError' = _error . T.pack

-- | (internal)
-- Given a potentially errored object, converts it to a Try.
tryEither :: HasCallStack => Either T.Text a -> Try a
tryEither (Left msg) = tryError msg
tryEither (Right x) = Right x
