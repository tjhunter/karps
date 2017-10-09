{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE OverloadedStrings #-}


{-| A collection of small utility functions.
-}
module Spark.Core.Internal.Utilities(
  HasCallStack,
  UnknownType,
  myGroupBy,
  myGroupBy',
  missing,
  failure,
  failure',
  forceRight,
  throwError',
  show',
  error',
  withContext,
  strictList,
  traceHint,
  SF.sh,
  (<&>),
  (<>),
  -- NonEmpty( (:|) ),
  NonEmpty(..)
) where

import qualified Data.Text as T
import qualified Formatting.ShortFormatters as SF
import qualified Data.List.NonEmpty as N
import qualified Data.Map.Strict as M
import Control.Monad.Except(MonadError(throwError))
import Control.Arrow ((&&&))
import Data.List
import Data.Function
import Data.Text(Text)
import Data.Maybe(mapMaybe)
import Formatting
import Debug.Trace(trace)
import Data.Semigroup((<>))
import  Data.List.NonEmpty( NonEmpty( (:|) ) )
import GHC.Stack(HasCallStack, prettyCallStack, callStack)

-- import qualified Spark.Core.Internal.LocatedBase as LB

(<&>) :: Functor f => f a -> (a -> b) -> f b
(<&>) = flip fmap

-- | A type that is is not known and that is not meant to be exposed to the
-- user.
data UnknownType

-- | group by
myGroupBy' :: (Ord b) => (a -> b) -> [a] -> [(b, NonEmpty a)]
myGroupBy' f l = l4 where
  g :: NonEmpty (u,v) -> (u, NonEmpty v)
  g ((h,t) :| r) = (h, t :| (snd <$> r))
  l0 = (f &&& id) <$> l
  l1 = groupBy ((==) `on` fst) l0
  l2 = mapMaybe N.nonEmpty l1
  l3 = g <$> l2
  l4 = sortBy (compare `on` fst) l3

throwError' :: (HasCallStack, MonadError Text m) => Text -> m a
throwError' txt = throwError (T.pack (prettyCallStack callStack) <> txt)

-- | group by
-- This implementation is not great, but it should respect the general contract.
myGroupBy :: (Ord a) => [(a, b)] -> M.Map a (NonEmpty b)
myGroupBy l = foldl' f M.empty l' where
  f = M.unionWith (<>)
  l' = g <$> l where
    g (a, b) = M.singleton a (b :| [])


error' :: (HasCallStack) => Text -> a
error' = error . T.unpack

-- | Missing implementations in the code base.
missing :: (HasCallStack) => Text -> a
missing msg = error' $ T.concat ["MISSING IMPLEMENTATION: ", msg]

{-| The function that is used to trigger exception due to internal programming
errors.

Currently, all programming errors simply trigger an exception. All these
impure functions are tagged with an implicit call stack argument.
-}
failure :: (HasCallStack) => Text -> a
failure msg = error' (T.concat ["FAILURE in Spark. Hint: ", msg])

failure' :: (HasCallStack) => Format Text (a -> Text) -> a -> c
failure' x = failure . sformat x


{-| Given a DataFrame or a LocalFrame, attempts to get the value,
or throws the error.

This function is not total.
-}
forceRight :: (HasCallStack, Show a) => Either a b -> b
forceRight (Right b) = b
forceRight (Left a) = error' $
  sformat ("Failure from either, got instead a left: "%shown) a

-- | Force the complete evaluation of a list to WNF.
strictList :: (Show a) => [a] -> [a]
strictList [] = []
strictList (h : t) = let !t' = strictList t in (h : t')

-- | (internal) prints a hint with a value
traceHint :: (Show a) => Text -> a -> a
traceHint hint x = trace (T.unpack hint ++ show x) x

-- | show with Text
show' :: (Show a) => a -> Text
show' x = T.pack (show x)

withContext :: Text -> Either Text a -> Either Text a
withContext _ (Right x) = Right x
withContext msg (Left other) = Left (msg <> "\n>>" <> other)
