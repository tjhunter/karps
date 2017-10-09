{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
-- Required by old versions
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE Strict #-}

module Spark.Core.Internal.Arithmetics(
  GeneralizedHomoReturn,
  GeneralizedHomo2,
  HomoColOp2,
  -- | Developer API
  performOp,
  ) where

import Debug.Trace(trace)

import Spark.Core.Internal.ColumnFunctions
import Spark.Core.Internal.ColumnStructures
import Spark.Core.Internal.DatasetStructures
import Spark.Core.Internal.FunctionsInternals(projectColFunction2')
import Spark.Core.Internal.Utilities

{-| All the automatic conversions supported when lifting a -}
type family GeneralizedHomoReturn x1 x2 where
  GeneralizedHomoReturn (Column ref x1) (Column ref x1) = Column ref x1
  GeneralizedHomoReturn (Column ref x1) Column' = Column'
  GeneralizedHomoReturn (Column ref x1) (LocalData x1) = Column ref x1
  GeneralizedHomoReturn (Column ref x1) LocalFrame = Column'
  GeneralizedHomoReturn Column' (Column ref x1) = Column'
  GeneralizedHomoReturn Column' Column' = Column'
  GeneralizedHomoReturn Column' (LocalData x1) = Column'
  GeneralizedHomoReturn Column' LocalFrame = Column'
  GeneralizedHomoReturn (LocalData x1) (Column ref x1) = Column ref x1
  GeneralizedHomoReturn (LocalData x1) Column' = Column'
  GeneralizedHomoReturn (LocalData x1) (LocalData x1) = LocalData x1
  GeneralizedHomoReturn (LocalData x1) LocalFrame = LocalFrame
  GeneralizedHomoReturn LocalFrame (Column ref x1) = Column'
  GeneralizedHomoReturn LocalFrame LocalFrame = LocalFrame

-- The type of an homogeneous operation.
-- TODO it would be nice to enforce this contstraint at the type level,
-- but it is a bit more complex to do.
type HomoColOp2 = UntypedColumnData -> UntypedColumnData -> UntypedColumnData

{-| The class of types that can be lifted to operations onto Karps types.

This is the class for operations on homogeneous types (the inputs and the
output have the same underlying type).

At its core, it takes a broadcasted operation that works on columns, and
makes that operation available on other shapes.
-}
class GeneralizedHomo2 x1 x2 where
  _projectHomo :: x1 -> x2 -> HomoColOp2 -> GeneralizedHomoReturn x1 x2

{-| Performs an operation, using a reference operation defined on columns.
-}
performOp :: (GeneralizedHomo2 x1 x2) =>
  HomoColOp2 ->
  x1 ->
  x2 ->
  GeneralizedHomoReturn x1 x2
performOp f x1 x2 =
  let x1' = trace "performOp: x1'" x1
      x2' = trace "performOp: x2'" x2
      f' = trace "performOp: f" f
  in _projectHomo x1' x2' f'

-- ******* INSTANCES *********

instance GeneralizedHomo2 Column' Column' where
  _projectHomo = _performDynDyn

instance GeneralizedHomo2 (Column ref x) (Column ref x) where
  _projectHomo = _performCC

instance GeneralizedHomo2 Column' (Column ref x) where
  _projectHomo dc1 c2 = _performDynDyn dc1 (untypedCol c2)

instance GeneralizedHomo2 (Column ref x) Column' where
  _projectHomo c1 = _performDynDyn (untypedCol c1)

instance GeneralizedHomo2 (Column ref x) (LocalData x) where
  _projectHomo c1 o2 = _projectHomo c1 (broadcast o2 c1)

instance GeneralizedHomo2 (LocalData x) (Column ref x) where
  _projectHomo o1 c2 = _projectHomo (broadcast o1 c2) c2

instance GeneralizedHomo2 (Column ref x) LocalFrame where
  _projectHomo c1 o2' = _projectHomo c1 (broadcast' o2' (untypedCol c1))

instance GeneralizedHomo2 LocalFrame (Column ref x) where
  _projectHomo o1' c2 = _projectHomo (broadcast' o1' (untypedCol c2)) c2

instance GeneralizedHomo2 LocalFrame LocalFrame where
  _projectHomo o1' o2' f =
    let f' x y = column' $ f <$> unColumn' x <*> unColumn' y
    in projectColFunction2' f' o1' o2'


_performDynDyn ::
  Column' -> Column' -> HomoColOp2 -> Column'
_performDynDyn dc1 dc2 f = column' $ trace "_performDynDyn" $ do
  c1 <- trace "_performDynDyn:c1" $ unColumn' dc1
  c2 <- trace "_performDynDyn:c2" $ unColumn' dc2
  -- TODO: add type guard
  let c = f c1 c2
  -- TODO: add dynamic check on the type of the return
  return (dropColType c)

_performCC :: (HasCallStack) =>
  Column ref x -> Column ref x -> HomoColOp2 -> Column ref x
_performCC c1 c2 f =
  let sqlt = colType c1
      c = f (iUntypedColData c1) (iUntypedColData c2)
      c' = forceRight $ castCol (colRef c1) sqlt (untypedCol c)
  in c'

_performCO :: (HasCallStack) =>
  Column ref x -> LocalData x -> HomoColOp2 -> Column ref x
_performCO c1 o2 = _performCC c1 (broadcast o2 c1)
