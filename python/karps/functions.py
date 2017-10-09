""" The standard library of dataframe functions in Karps.

All these functions operate on Karps dataframes and Pandas dataframes, and return the same results regardless of
the input.
"""

import builtins as _b
import pandas as pd
import numpy as np
from pandas import Series as PS

from .types import IntegerType, DoubleType, BooleanType, ArrayType
from .functions_std.utils import *
from .functions_std.error import *

#__all__ = ['as_double', 'collect', 'count', 'inv', 'max']

def _check_same_2(dt1, dt2):
  # TODO: take nullability into account
  if dt1 != dt2:
    raise CreationError("Types %s and %s are not compatible" %(dt1, dt2))
  return dt1

def _check_cmp(dt1, dt2):
  """ Comparison check.
  """
  _check_same_2(dt1, dt2)
  return BooleanType()

############ Aggregators #############

collect = make_aggregator_sql("collect_list", ArrayType, _b.list)

max = make_aggregator_sql("max", check_type_number, PS.max)

count = make_aggregator_sql("count", lambda x: IntegerType(), PS.count)

sum = make_aggregator_sql("sum", check_type_number, PS.sum)


############ Universal functions ##########

inv = make_transform_sql1("inverse", check_type_number, lambda x: 1/x)

plus = make_transform_sql2("plus", _check_same_2, lambda x1, x2: x1+x2)

minus = make_transform_sql2("minus", _check_same_2, lambda x1, x2: x1-x2)

multiply = make_transform_sql2("multiply", _check_same_2, lambda x1, x2: x1*x2)

divide = make_transform_sql2("divide", _check_same_2, lambda x1, x2: x1/x2)

def _cast_double(dt):
  if dt == DoubleType() or dt == IntegerType():
    return DoubleType()
  raise CreationError("Cannot cast type {} to double".format(dt))

def _cast_double_py(x):
  if isinstance(x, pd.Series):
    return PS.astype(x, np.double)
  return float(x)

as_double = make_transform_sql1("cast_double", _cast_double, _cast_double_py)

greater_equal = make_transform_sql2("greater_equal", _check_cmp, lambda x1, x2: x1==x2)


########### FUNCTIONS ON DATASETS #########
# These functions only operate on datasets.

def autocache(df, name=None):
  # The autocache function.
  df = check_df(df)
  return build_dataframe(
    op_name="org.spark.Autocache",
    type_p=df.type,
    parents=[df],
    name_hint="autocache",
    path_extra=name)

def filter(filter_col, col, name=None):
  """ Returns a dataframe with all the values from `col` subject to 
  a predicate that is verified in `filter_col`.
  """
  df = check_df(
    struct([("filter", filter_col), ("value", col)]),
    name_hint="filter_pre")
  return build_dataframe(
    op_name="org.spark.Filter",
    type_p=col.type,
    parents=[df],
    name_hint="filter",
    path_extra=name)

def groupby(key_col, value_col):
  pass

def agg(group, agg_obj):
  pass