""" The Augmented Data Type: a data type with extra nullability information.
"""

import pandas as pd
from pandas.io.json import json_normalize

from .pyspark.types import *
from .pyspark.types import _parse_datatype_json_value

__all__ = ['AugmentedDataType']

class AugmentedDataType(object):
  """ A Spark data type and some extra information about nullability
  and metadata.
  """

  def __init__(self, dt, isNullable):
    self.sparkDatatype = dt
    self.nullable = isNullable

  def isScalar(self):
    if isinstance(self.dataType, ArrayType):
      return False
    if isinstance(self.dataType, StructType):
      return False
    return True

  def __repr__(self):
    if self.nullable:
      return "?" + repr(self.sparkDatatype)
    else:
      return "!" + repr(self.sparkDatatype)

def _parse_augmented_datatype_json_value(js):
  dt = _parse_datatype_json_value(js['dt'])
  nul = bool(js['nullable'])
  return AugmentedDataType(dt, nul)


def _isScalar(dt):
    if isinstance(dt, ArrayType):
        return False
    if isinstance(dt, StructType):
        return False
    return True

def _normalize(dt, data):
    """ Takes some data that is encoded in the compact form, 
    and adds the name of the fields to the objects.
    """
    # TODO: this is a shortcut, we should be able to catch some errors here.
    if data is None:
        return None
    if isinstance(dt, ArrayType):
        dt2 = dt.elementType
        return [_normalize(dt2, x) for x in data]
    if isinstance(dt, StructType):
        # Go after each field.
        l = [(f.name, _normalize(f.dataType, x)) for (f, x) in zip(dt.fields, data)]
        return dict(l)
    # For all the other structures, return themselves
    return data
            

def _to_pandas(adt, normalized):
    # Handle nullability at the top level.
    if normalized is None:
        return None
    dt = adt.sparkDatatype
    if isinstance(adt.sparkDatatype, ArrayType):
        elt = dt.elementType
        if isinstance(elt, StructType):
            # This is exactly the pandas structure here.
            return json_normalize(normalized)
        else:
            # This is going to be a series:
            return pd.Series(normalized)
    # It is a scalar, just return the value
    return normalized

