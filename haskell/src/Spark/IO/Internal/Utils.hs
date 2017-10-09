{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}

module Spark.IO.Internal.Utils where

import qualified Data.Map.Strict as M
import qualified Data.Text as T
import Data.Text(Text)
import Data.String(IsString(..))

import Spark.Core.Try
import Spark.Core.Internal.Utilities(forceRight)
-- import Spark.Core.Internal.DatasetFunctions(asDF, emptyDataset, emptyLocalData)
import Spark.Core.Internal.TypesStructures(SQLType(..))
import Spark.Core.Internal.OpStructures
import qualified Proto.Karps.Proto.Io as PIO
