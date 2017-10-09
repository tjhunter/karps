{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}

module Spark.IO.Internal.OutputCommon(
  SaveMode(..),
  SaveOutput(..),
  OutputBucket,
  DynOutputBucket,
  OutputPartition,
  DynOutputPartition,
  SavingDescription(..),
  partition,
  partition',
  bucket,
  bucket',
  saveDefaults,
  saveCol
) where

import Spark.Core.Try
import Spark.Core.Column
import Spark.Core.Dataset

import Spark.Core.Internal.ColumnStructures(UnknownReference, UntypedColumnData)
import Spark.Core.Internal.ColumnFunctions(dropColReference)
import Spark.Core.Internal.OpStructures(HdfsPath)
import Spark.Core.Internal.Utilities
import Spark.IO.Internal.InputStructures

{-| The mode when saving the data.

There is no append mode.
-}
data SaveMode =
    Overwrite
  | Ignore
  | ErrorIfExists deriving(Eq, Show)

data OutputPartition ref = OutputPartition UntypedColumnData

type DynOutputPartition = Try (OutputPartition UnknownReference)

data OutputBucket ref = OutputBucket UntypedColumnData

type DynOutputBucket = Try (OutputBucket UnknownReference)

partition :: Column ref a -> OutputPartition ref
partition = OutputPartition . dropColType . dropColReference

partition' :: DynColumn -> DynOutputPartition
partition' = fmap partition

bucket :: Column ref a -> OutputBucket ref
bucket = OutputBucket . dropColType . dropColReference

bucket' :: DynColumn -> DynOutputBucket
bucket' = fmap bucket


data SavingDescription ref a = SavingDescription {
  partitions :: ![OutputPartition ref],
  buckets :: ![OutputBucket ref],
  savedCol :: !(Column ref a),
  saveFormat :: !DataFormat,
  savePath :: !HdfsPath
}

saveDefaults :: HdfsPath -> DataFormat -> Column ref a -> SavingDescription ref a
saveDefaults sp f c = SavingDescription {
  partitions = [],
  buckets = [],
  savedCol = c,
  saveFormat = f,
  savePath = sp
}

{-| Inserts an action to store the given dataframe in the graph of computations.

NOTE: Because of some limitations in Spark, all the columns used when forming
the buckets and the parttions must be present inside the column being written.
These columns will be appended to the column being written if they happen to be
missing. The consequence is that more data may be written than expected.

It returns true if the update was successful. The return type is subject to
 change.
-}
saveCol :: SavingDescription ref a -> LocalData Bool
saveCol _ = missing "saveCol"

{-| The outcomes of writing a dataset.

Multiple outcomes are available, depending on the subsequent steps in the
processing pipeline. Note that all operations are lazy, so one or more of these
outcomes can be used.
-}
data SaveOutput a = SaveOutput {
  -- | The written dataset.
  -- This operation is logically equivalent to writing the dataset to disk and
  -- then reading it again (it may be optimized).
  written :: !(Dataset a),
  -- | An observable that is available when the writing action has been
  -- completed.
  -- Note that this observable will always succeed with the 'true' value. In
  -- case of writing failure, an error is returned instead.
  writtenDone :: !(LocalData Bool),
  -- | The data that did not exist before and that is now present in the table.
  appended :: !(Dataset a),
  -- | The data that overwrote some existing portions of the data.
  overwriteOutput :: !(Dataset a)
}

save :: DataFormat -> HdfsPath -> Dataset a -> SaveOutput a
save = undefined
--
-- repeatDS :: Column ref Int -> Column ref a -> Dataset a
--
-- repeatFast :: Column ref Int -> Column ref a -> Dataset a
--
-- repeatScatter :: Int -> Column ref Int -> Column ref a -> Dataset a
