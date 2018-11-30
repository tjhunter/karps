""" Some standard utiltilies for defining functions.

These are developer functions that are not covered by API guarantees.
"""


import pandas as pd

from ..column import DataFrame, Column, build_col_broadcast, build_col_fun, build_col_literal
from ..proto import types_pb2
from ..proto import structured_transform_pb2 as st_pb2
from .base import *
from .error import *


def check_df(df, name_hint=None):
  """ Checks if the input is a dataframe, or turns it into a dataframe
  if necessary (if it is a column).
  """
  if isinstance(df, DataFrame):
    return df
  if isinstance(df, Column):
    return df.as_dataframe(name_hint=name_hint)
  raise CreationError("Trying to cast %s as a dataframe, which is of type %s" % (df, type(df)))

def check_type_number(dt):
  p = dt.to_proto
  if p.HasField("basic_type") and p.basic_type in [types_pb2.SQLType.DOUBLE, types_pb2.SQLType.INT]:
    return dt
  raise CreationError("Expected type to be a type number: %s" % dt)

def make_aggregator_sql(sqlname, typefun, pdfun=None, spfun=None):
  """
  sqlname: the name of the sql function
  typefun: datatype -> datatype

  Returns a function of type (df-like, name: string) -> observable
  """
  def function_karps(df, name):
    df = check_df(df)
    type_out = typefun(df.type)
    # the proto that defines the aggregation.
    p = std_pb2.StructuredReduce(agg_op=st_pb2.Aggregation(
      op=st_pb2.AggregationFunction(
        function_name=sqlname,
        inputs=[st_pb2.ColumnExtraction(path=[])]
        ),
      field_name=name))
    return build_observable("org.spark.StructuredReduce", type_out,
      parents=[df],
      op_extra=p,
      name_hint=sqlname,
      path_extra=name)
  def function_pandas(df):
    # Takes the input (assumed to be a pandas dataframe or series) and
    # performs the pandas operation on it.
    s = _convert_pd_series(df)
    return pdfun(s)
  def function(df, name=None):
    if isinstance(df, (DataFrame, Column)):
      return function_karps(df, name)
    # TODO: check for Spark
    # Assume this is a python object, pass it to python:
    return function_pandas(df)
  # Useful for visualization of the function
  function.__name__ = sqlname
  return function

def make_transform_sql1(sqlname, typefun, pyfun=None, spfun=None):
  """ Makes a sql transformer that accepts only one argument.

  sqlname: the name of the sql function.
  typefun: a function that accepts one datatype and returns a datatype.

  Returns a function of type (input: col-like, name: string) -> col-like, with the following rules:
   - observable -> observable
   - column -> column
   - dataframe -> dataframe
   - python object -> python object
  """
  def function_karps(obj1, name):
    type_in = obj1.type
    type_out = typefun(type_in)
    # Get the column input for the data.
    if isinstance(obj1, Column):
      return Column(
        ref = obj1.reference,
        type_p = type_out,
        function_name=sqlname,
        function_deps=[obj1])
    elif isinstance(obj1, (DataFrame, Observable)):
      proto_in = st_pb2.Column(
        extraction=st_pb2.ColumnExtraction(path=[]))
      proto_out = st_pb2.Column(
        function=st_pb2.ColumnFunction(
          function_name=sqlname,
          inputs=[proto_in]),
        field_name="%s()" % sqlname) # TODO: fix the name
    else:
      raise CreationError("Does not understand object of type %s" % (type(obj1)))
    if isinstance(obj1, DataFrame):
      p = std_pb2.StructuredTransform(
        col_op=proto_out)
      return build_dataframe(
        op_name="org.spark.StructuredTransform",
        type_p=type_out,
        op_extra=p,
        parents=[obj1],
        name_hint=sqlname,
        path_extra=name)
    if isinstance(obj1, Observable):
      p = std_pb2.LocalStructuredTransform(
        col_op=proto_out)
      return build_observable(
        op_name="org.spark.LocalStructuredTransform",
        type_p=type_out,
        op_extra=p,
        parents=[obj1],
        name_hint=sqlname,
        path_extra=name)
  def function(df, name=None):
    if isinstance(df, (DataFrame, Column, Observable)):
      return function_karps(df, name)
    # TODO: check for Spark
    # Assume this is a python object, pass it to python:
    return pyfun(df)
  # Useful for visualization of the function
  function.__name__ = sqlname
  return function

def make_transform_sql2(sqlname, typefun, pyfun=None):
  """ Makes a sql transformer that accepts two arguments.

  sqlname: the name of the sql function.
  typefun: a function that accepts a list of datatypes and returns a datatype.
  numargs: the number of arguments accepted by this transformer.
  pyfun: a python function that can perform the equivalent operation (if possible).
  spfun: a spark function that does the equivalent operation.

  Returns a function of type (input: col-like, name: string) -> col-like, with the following rules:
   - observable -> observable
   - column -> column
   - dataframe -> dataframe
   - python object -> python object
  """
  return make_transform_sql(sqlname, typefun, numArgs=2, pyfun=pyfun)

def make_transform_sql(sqlname, typefun,
  numArgs=None, pyfun=None, spfun=None):
  """ Makes a sql transformer that accepts a fixed number of arguments (greater than one).

  sqlname: the name of the sql function.
  typefun: a function that accepts a list of datatypes and returns a datatype.
  numargs: the number of arguments accepted by this transformer.
  pyfun: a python function that can perform the equivalent operation (if possible).
  spfun: a spark function that does the equivalent operation.

  Returns a function of type (input: col-like, name: string) -> col-like, with the following rules:
   - observable -> observable
   - column -> column
   - dataframe -> dataframe
   - python object -> python object
  """
  if numArgs is not None and numArgs == 0:
    raise CreationError("Only for sql functions that accept arguments")
  # Implementation for a list of columns.
  # The result is a column with the same reference.
  def function_karps_col(cols, name):
    types_in = [col.type for col in cols]
    type_out = typefun(*types_in)
    return build_col_fun(cols[0].reference, type_out, sqlname, cols)
  def function_karps_obs(obss, name):
    types_in = [obs.type for obs in obss]
    type_out = typefun(*types_in)
    def f(idx):
      return st_pb2.Column(
        broadcast=st_pb2.ColumnBroadcastObservable(
          observable_index=idx),
        field_name="_%s"%str(idx))
    return build_observable(
      "org.spark.LocalStructuredTransform", type_out,
      op_extra=std_pb2.LocalStructuredTransform(
        col_op=st_pb2.Column(
          function=st_pb2.ColumnFunction(
            function_name=sqlname,
            inputs=[f(idx) for idx in range(len(obss))]))),
      parents=obss,
      name_hint=sqlname,
      path_extra=name)
  # def function(*objs, name=None): # TODO: this is python3 only
  def function(*objs, **kwargs):
    name = kwargs['name'] if 'name' in kwargs else None
    if len(objs) == 0 or (numArgs is not None and len(objs) != numArgs):
      raise CreationError("%s needs %s argument(s)" % (sqlname, str(numArgs)))
    # We accept a couple of cases for Karps:
    #  - == 1 dataframe, >= 0 columns, >= 0 observables >= other -> dataframe
    #  - >= 1 columns, >= 0 observables, >= other -> columns
    #  - >= 1 observables, >= other -> obs
    #  - >= 1 other -> python call
    dfs = [obj for obj in objs if isinstance(obj, DataFrame)]
    cols = [obj for obj in objs if isinstance(obj, Column)]
    obss = [obj for obj in objs if isinstance(obj, Observable)]
    comps = [obj for obj in objs if is_compatible_karps(obj)]
    num_df = len(dfs)
    num_col = len(cols)
    num_obs = len(obss)
    num_comps = len(comps)
    # We cannot mix and match things for now.
    if not dfs and not cols and not obss:
      # No spark stuff, we call the python argument for now.
      pyfun(*objs)
    if num_obs + num_col + num_df + num_comps != len(objs):
      raise CreationError("Mixing karps objects with non karps objects")
    # Same origin
    bc_obj_ids = set([id(x) for x in (dfs + [col.reference for col in cols])])
    if len(bc_obj_ids) > 1:
      raise CreationError("More than one dataframes are being refered in this transform: dataframes: {} columns: {}".format(dfs, cols))
    # If we are dealing with observables only, take a separate path, there is no reference in this case.
    if not dfs and not cols:
      # Using observables. All the values are translated as observables.
      def convert(obs):
        from ..column import observable
        if isinstance(obs, Observable):
          return obs
        if is_compatible_karps(obs):
          return observable(obs)
        assert False, (type(obs), obs)
      obss2 = [convert(o) for o in objs]
      return function_karps_obs(obss2, name)
    # Dealing with columns or dataframes.
    assert dfs or cols
    # Find the unique reference
    if dfs:
      ref = dfs[0]
    else:
      ref = cols[0].reference
    def make_col(obj):
      if isinstance(obj, DataFrame):
        return obj.as_column()
      if isinstance(obj, Column):
        return obj
      if isinstance(obj, Observable):
        return build_col_broadcast(ref, obj.type, obj)
      if is_compatible_karps(obj):
        return build_col_literal(ref, obj)
      assert False, obj
    all_cols = [make_col(obj) for obj in objs]
    col = function_karps_col(all_cols, name)
    if dfs:
      # If we have datframes mixed in, return a dataframe
      return col.as_dataframe()
    else:
      return col
  # Useful for visualization of the function
  function.__name__ = sqlname
  return function

def is_compatible_karps(pyobj):
  # True if the object can be turned into an observable.
  # For now, it is limited to primitives.
  # We lack type info with null objects.
  if pyobj is None:
    return False
  return isinstance(pyobj, (float, str, bool, int))

def _convert_pd_series(obj):
  if isinstance(obj, pd.Series):
    return obj
  if isinstance(obj, pd.DataFrame):
    df = obj
    cols = list(df.columns)
    if len(cols) > 1:
      raise ValueError("Expected one column but the following column: {}".format(cols))
    return df[cols[0]]

