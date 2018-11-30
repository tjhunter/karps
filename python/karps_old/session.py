

import grpc
import logging

from .proto import interface_pb2_grpc
from .proto import interface_pb2
from .proto import graph_pb2
from .proto import computation_pb2
from .proto.computation_pb2 import SessionId
from .computation import Computation
from .column import AbstractNode

__all__ = ['Session', 'session']

logger = logging.getLogger('karps')


class Session(object):
  """ A session in Karps.

  A session encapsulates all the state that is communicated between the frontend and the backend.
  """

  def __init__(self, name, stub):
    self._stub = stub
    self.name = name
    self.computation_counter = 0

  def __repr__(self):
    return "Session:{}".format(self.name)

  # def value(self, path, computation = None):
  #   """ Retrieves a single value with the given path.
  #   If no computation is specified, it will try to retrieve the latest 
  #   value that corresponds to this path.
  #   """
  #   pass

  def eval(self, fetches, return_mode="pandas"):
    """ Blocks until all the fetches are executed.

    Return modes (string):
     - proto: returns a row.CellWithType object, which is the most precise, but not
              very user friendly
     - python: converts the results to python data structures (basic types, lists, dictionaries)
     - pandas: returns a pandas dataframe (or a single value if the value is a scalar).
    """
    computation = self.compute(fetches, return_mode)
    return computation.values()

  def compute(self, fetches, return_mode="proto"):
    """ Executes the fetches in an asynchronous manner: it returns a computation object that can be queried later
    for the results, or for detailed information about Spark and the computations.

    return_mode: see run()

    """
    # Build and quickly validate the graph of computations.
    # This is a lightweight client, nothing fancy is done on the python side.
    (fetches, final_unpack) = _check_list(fetches)
    for fetch in fetches:
      assert isinstance(fetch, AbstractNode), (type(fetch), fetch)
    accepted_modes = ['proto', 'python', 'pandas']
    if return_mode not in accepted_modes:
      raise ValueError(
        "Provided return mode ({}) is not one of the accepted modes: {}".format(
          return_mode, accepted_modes))
    paths = [an.path for an in fetches]
    paths_proto = [an.path._proto for an in fetches]
    g = _build_graph(fetches)
    logger.debug("compute graph: %s", str(g))
    # The data looks good, opening a channel with the backend.
    self.computation_counter += 1
    session_id = SessionId(id=self.name)
    computation_id = computation_pb2.ComputationId(id=str(self.computation_counter))
    channel = self._stub.StreamCreateComputation(interface_pb2.CreateComputationRequest(
      session=session_id,
      requested_computation=computation_id,
      requested_paths=paths_proto,
      graph=g))
    return Computation(session_id, computation_id, channel, paths, final_unpack, return_mode)

def session(name, port = 8082, address = "localhost"):
  """ Creates a new remote session that uses the GRPC interface to communicate with the frontend.
  """
  channel = grpc.insecure_channel('{}:{}'.format(address, str(port)))
  stub = interface_pb2_grpc.KarpsMainStub(channel)
  session_id = SessionId(id=name)
  # Make sure that the session exists before returning it.
  z = stub.CreateSession(interface_pb2.CreateSessionRequest(
    requested_session=session_id))
  return Session(name, stub)

def _check_list(x):
  if isinstance(x, list):
    return (x, False)
  if isinstance(x, tuple):
    return (list(x), False)
  return ([x], True)

def _build_node(an):
  # an: an AbstractNode
  extra_bytes = an.op_extra.SerializeToString() if an.op_extra is not None else None
  extra_str = str(an.op_extra).replace("\n", "") if an.op_extra is not None else None
  extra = graph_pb2.OpExtra(
    content=extra_bytes,
    content_debug=extra_str)
  return graph_pb2.Node(
    locality=graph_pb2.DISTRIBUTED if an.is_distributed else graph_pb2.LOCAL,
    path = an.path._proto,
    op_name=an.op_name,
    op_extra=extra,
    parents=[an2.path._proto for an2 in an.parents],
    logical_dependencies=[an2.path._proto for an2 in an.logical_dependencies],
    infered_type=an.type._proto)


def _build_graph(fringe):
  """ fringe: list of AbstractNode objects, found_nodes: map of path -> AbstractNode
  """
  found_nodes = {}
  while fringe:
    an = fringe[0]
    fringe = fringe[1:]
    if an.path in found_nodes:
      pass
    else:
      fringe = fringe + an.parents
      found_nodes[an.path] = an
  # We are done, make a graph with all the elements:
  return graph_pb2.Graph(
    nodes=[_build_node(an) for an in found_nodes.values()])



