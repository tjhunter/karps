""" Some basic functions that are used as building blocks 
for other functions.

They are not expected to be called by users, but are exposed
for developers.
"""
from ..column import Observable, build_dataframe, build_observable, build_col_struct
from ..types import make_tuple, StructField, StructType
from ..proto import std_pb2, graph_pb2
from .error import create_error

########### FUNCTIONS ON COLUMNS #########

def struct(cols, field_name=None):
  """ Makes a new structure of columns, with some optional name for the
  columns.
  """
  if len(cols) == 0:
    create_error("No column (forbidden in Karps)")
  cols0 = [c.alias(fname) for (fname, c) in cols]
  l = [StructField(c.type, c._field_name) for c in cols0]
  dt = StructType(l)
  return build_col_struct(cols[0][1].reference, dt, cols0, field_name=field_name)


########### FUNCTIONS ON COMPUTE NODES #######
# These functions do not operate on columns, but work on datasets or 
# observables.

def placeholder_like(on, name=None):
  """ Returns a new placeholder node that has the same shape as the given
  node `on`.
  """
  extra = std_pb2.Placeholder(data_type=on.type._proto)
  if isinstance(on, Observable):
    extra.locality = graph_pb2.LOCAL
    # Local placeholder.
    return build_observable(
      op_name="org.spark.Placeholder",
      type_p=on.type,
      op_extra=extra,
      name_hint="local_placeholder",
      path_extra=name)
  else:
    extra.locality = graph_pb2.DISTRIBUTED
    # Local placeholder.
    return build_dataframe(
      op_name="org.spark.Placeholder",
      type_p=on.type,
      op_extra=extra,
      name_hint="placeholder",
      path_extra=name)

# TODO this is not required.
def pack_local(*observables):
  """ Takes a list of observables and returns a tuple of all 
  the observables together.
  """
  if not observables:
    create_error("List of observables cannot be empty")
  for obs in observables:
    if not isinstance(obs, Observable):
      create_error("Expected input to be of type observable, but got type %s instead for %s" % (type(obs),
                                                                                     obs))
  tpe = make_tuple(*[obs.type for obs in observables])
  return build_observable(
    op_name="org.spark.PackLocal",
    type_p=tpe._proto,
    parents=observables)

