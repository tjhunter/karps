{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Spark.Core.Internal.DatasetStructures where

import Spark.Common.Try
import Spark.Core.Row
import Spark.Common.NodeStructures
import Spark.Common.OpStructures

{-| Phantom type for locality.
-}
data LocLocal
data LocDistributed


{-| A typed collection of distributed data.

Most operations on datasets are type-checked by the Haskell
compiler: the type tag associated to this dataset is guaranteed
to be convertible to a proper Haskell type. In particular, building
a Dataset of dynamic cells is guaranteed to never happen.

If you want to do untyped operations and gain
some flexibility, consider using UDataFrames instead.

Computations with Datasets and observables are generally checked for
correctness using the type system of Haskell.
-}
type Dataset a = ComputeNode LocDistributed a

{-|
A unit of data that can be accessed by the user.

This is a typed unit of data. The type is guaranteed to be a proper
type accessible by the Haskell compiler (instead of simply a Cell
type, which represents types only accessible at runtime).

TODO(kps) rename to Observable
-}
type LocalData a = ComputeNode LocLocal a

type Observable a = LocalData a

-- (internal) A dataset for which we have dropped type information.
-- Used internally by columns.
type UntypedDataset = Dataset Cell

{-| (internal) An observable which has no associated type information. -}
type UntypedLocalData = LocalData Cell



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
