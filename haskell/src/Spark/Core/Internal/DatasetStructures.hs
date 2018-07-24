{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Spark.Core.Internal.DatasetStructures where

import Data.Vector(Vector)
import qualified Data.Vector as V
import qualified Data.Text as T

import Spark.Common.StructuresInternal
import Spark.Common.Try
import Spark.Core.Row
import Spark.Common.NodeStructures
import Spark.Common.OpStructures
import Spark.Common.TypesStructures

type Observable a = LocalData a


{-|
The dataframe type. Any dataset can be converted to a dataframe.

For the Spark users: this is different than the definition of the
dataframe in Spark, which is a dataset of rows. Because the support
for single columns is more akward in the case of rows, it is more
natural to generalize datasets to contain cells.
When communicating with Spark, though, single cells are wrapped
into rows with single field, as Spark does.
-}
type DataFrame = Try UntypedDataset

{-| Observable, whose type can only be infered at runtime and
that can fail to be computed at runtime.

Any observable can be converted to an untyped
observable.

Untyped observables are more flexible and can be combined in
arbitrary manner, but they will fail during the validation of
the Spark computation graph.

TODO(kps) rename to DynObservable
-}
type LocalFrame = Observable'
newtype Observable' = Observable' { unObservable' :: Try UntypedLocalData }

type UntypedNode' = Try UntypedNode


class CheckedLocalityCast loc where
  _validLocalityValues :: [TypedLocality loc]

-- Class to retrieve the locality associated to a type.
-- Is it better to use type classes?
class (CheckedLocalityCast loc) => IsLocality loc where
  _getTypedLocality :: TypedLocality loc

instance CheckedLocalityCast LocLocal where
  _validLocalityValues = [TypedLocality Local]

instance CheckedLocalityCast LocDistributed where
  _validLocalityValues = [TypedLocality Distributed]

-- LocLocal is a locality associated to Local
instance IsLocality LocLocal where
  _getTypedLocality = TypedLocality Local

-- LocDistributed is a locality associated to Distributed
instance IsLocality LocDistributed where
  _getTypedLocality = TypedLocality Distributed

instance CheckedLocalityCast LocUnknown where
  _validLocalityValues = [TypedLocality Distributed, TypedLocality Local]
