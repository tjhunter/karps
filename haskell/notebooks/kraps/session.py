
import requests
import pandas as pd
from pandas.io.json import json_normalize

from .types import _parse_augmented_datatype_json_value, _normalize, _to_pandas

class KrapsSession(object):

  def __init__(self, address, port, name):
    self._address = address
    self._port = port
    self.name = name

  def __repr__(self):
    return "KrapsSession:{}".format(self.name)

  def _value(self, path, computation = None):
    """ Returns a pair of (adt, value), or throws an exception.

    The value is normalized: it is a dictionary with the name of the fields.
    """
    if computation is None:
       computation = -1
    while path and path.startswith("/"):
      path = path[1:]
    p = "http://{}:{}/computations_status/{}/{}/{}".format(
      self._address, self._port, self.name, computation, path)
    r = requests.get(p)
    js = r.json()
    if js['status'] == 'finished_success':
      adt = _parse_augmented_datatype_json_value(js['finalResult']['type'])
      x = js['finalResult']['content']
      n = _normalize(adt.sparkDatatype, x)
      return (adt, n)
    raise ValueError('Cannot parse status', js['status'])

  def value(self, path, computation = None):
    """ Retrieves a single value with the given path.

    If no computation is specified, it will try to retrieve the latest 
    value that corresponds to this path.
    """
    return self._value(path, computation)[1]

  def pandas(self, path, computation = None):
    """ Retrieves a single value with the given path, and returns it as 
    a Pandas dataframe.

    If the data is scalar, it is returned as a scala. If the data is a
    collection of scalar values, they are returned as a Pandas Series.
    Otherwise, they are returned as a Pandas dataframe.
    """
    (adt, n) = self._value(path, computation)
    return _to_pandas(adt, n)

def connectSession(name, port = 8081, address = "127.0.0.1"):
  return KrapsSession(address, port, name)

