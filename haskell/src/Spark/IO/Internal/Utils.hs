{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}

module Spark.IO.Internal.Utils where

import qualified Data.Map.Strict as M
import qualified Data.Text as T
import Data.Text(Text)
import Data.String(IsString(..))

import Spark.Common.Try
import Spark.Common.Utilities(forceRight)
-- import Spark.Core.Internal.DatasetFunctions(asDF, emptyDataset, emptyLocalData)
import Spark.Common.TypesStructures(SQLType(..))
import Spark.Core.Internal.OpStructures
import qualified Proto.Karps.Proto.Io as PIO
