""" An asynchronous computation.
"""
import logging
from tensorflow.core.framework import graph_pb2
from google.protobuf.json_format import MessageToJson

from .proto import computation_pb2
from .utils import Path
from .row import CellWithType, as_python_object, as_pandas_object

__all__ = ['Computation']

logger = logging.getLogger('karps')


class Computation(object):
  """ An asynchronous computation.

  This object provides access to the different lifetimes of a computation:
   - original computation graph (with functional attributes)
   - static computation graph (after unrolling of the functions)
   - pinned graph (after optimization, which will be provided to the backend)
   - results and stats (including for spark, the detail of the various plans)
  """

  def __init__(self, session_id_p, computation_id_p,
    channel, target_fetch_paths, final_unpack, return_mode):
    # The proto of the session id.
    self._session_id_p = session_id_p
    # The proto of the computation id
    self._computation_id_p = computation_id_p
    # The GRPC channel
    self._channel = channel
    # The paths to fetch (list of strings)
    self._target_fetch_paths = target_fetch_paths
    # Bool, indicates wether the head of the list should be returned.
    self._final_unpack = final_unpack
    # The return mode for deserializing the data.
    self._return_mode = return_mode
    # All the results that we have received so far.
    self._results = {}
    # The compilation phases.
    self._compilation_phases = []
    # The extra phases that we can also access.
    # They are all the phases related to Spark.
    # Type: string -> graph_pb2
    self._extra_phases = {}
    # Quick lookup to access the nodes of the phases for in-place updates.
    # Type: (string, string) -> NodeDef
    # key is (phase, node name)
    self._extra_by_name = {}
    # The final profiling trace. This is expected once at the end of the computation.
    self._profiling_trace = None

  def values(self):
    """ Returns the fetches (or the unique fetch if there is only one).

    Blocks until the fetches are available or until an error is raised.
    """
    while not self._values():
      self._progress()
    return self._values()

  def compiler_step(self, step_name):
    """ Returns the given compiler phase.
    """
    while not self._compilation_phases:
      self._progress()
    for comp_phase in self._compilation_phases:
      if comp_phase.phase_name.lower() == step_name.lower():
        return comp_phase
    for (spark_phase_name, spark_phase_graph) in self._extra_phases.items():
      if spark_phase_name.lower() == step_name.lower():
        return spark_phase_graph
    step_names = [comp_phase.phase_name for comp_phase in self._compilation_phases]
    extra_step_names = list(self._extra_phases.keys())
    logger.warning("Could not find compiler step %s. Available steps are %s and %s",
      step_name, step_names, extra_step_names)
    return None

  def profiling_trace(self):
    """ Profiling traces to understand the running time of this computation.

    :return: an object that can be understood by standard profiler.
    """
    while self._profiling_trace is None:
      self._progress()
    return self._profiling_trace

  def dump_profile(self, filename=None):
    """Writes the profile in a file (or returns it as a string if no file is provided)

    The profile can be read in Google Chrome, using the 'about://tracing' inspector.
    """
    trace_data = self.profiling_trace()
    ss = ",\n".join([MessageToJson(x) for x in trace_data.chrome_events])
    ss = """{
      "traceEvents": [""" + ss + "]}"
    if filename is not None:
      with open(filename, mode="w") as f:
        f.write(ss)
    else:
      return ss

  def _values(self):
    # Returns the values if they are all done, None otherwise.
    res = []
    for p in self._target_fetch_paths:
      if p not in self._results:
        return None
      cr = self._results[p]
      if cr.status in (computation_pb2.SCHEDULED, computation_pb2.RUNNING, computation_pb2.UNUSED):
        return None
      assert cr.status in [computation_pb2.FINISHED_SUCCESS, computation_pb2.FINISHED_FAILURE], (cr.status, cr)
      if cr.final_error:
        raise Exception(cr.final_error)
      elif cr.final_result:
        res.append(CellWithType(cr.final_result))
      else:
        return None
    if self._final_unpack:
      res = res[0]
    if self._return_mode == 'proto':
      return res
    if self._return_mode == 'python':
      return as_python_object(res)
    if self._return_mode == 'pandas':
      return as_pandas_object(res)

  def _progress(self):
    """ Attempts to make progress by blocking on the connection until an update is received.
    """
    logger.debug("Calling _progress")
    # Read one more value from the channel.
    # type: ComputationStreamResponse
    csr = next(self._channel)
    logger.debug("channel: got value %s: %s", type(csr), str(csr))
    if csr.HasField("start_graph"):
      logger.debug("channel: received graph (discarding)")
    if csr.HasField("pinned_graph"):
      logger.debug("channel: received pinned graph (discarding)")
    if csr.HasField("compilation_result"):
      logger.debug("channel: received compilation results")
      # Did we receive some steps?
      if csr.compilation_result.compilation_graph:
        logger.debug("channel: received compilation steps")
        self._compilation_phases = csr.compilation_result.compilation_graph
    if csr.HasField("computation_trace"):
      logger.debug("channel: received profiling results")
      self._profiling_trace = csr.computation_trace
    if csr.results:
      # Type: ComputationResult
      for res in csr.results.results:
        assert res.local_path, (res, csr)
        path = Path(res.local_path)
        logger.debug("channel: received result for %s: %s" % (path, res))
        if path not in self._results:
          self._results[path] = computation_pb2.ComputationResult()
        current = self._results[path]
        current.MergeFrom(res)
        if res.spark_stats:
          for sti in res.spark_stats.parsed:
            self._progress_extra_phase("parsed", sti.proto)
          for sti in res.spark_stats.physical:
            self._progress_extra_phase("physical", sti.proto)
          for rddi in res.spark_stats.rdd_info:
            self._progress_extra_phase("rdd", rddi.proto)

  def _progress_extra_phase(self, phase_name, node_def):
    if not node_def.name:
      return
    # Find the graph
    if phase_name not in self._extra_phases:
      self._extra_phases[phase_name] = graph_pb2.GraphDef()
    graph = self._extra_phases[phase_name]

    # Find the node
    key = (phase_name, node_def.name)
    if key not in self._extra_by_name:
      self._extra_by_name[key] = node_def
      graph.node.extend([node_def])
      return # No update necessary
    node_def_orig = self._extra_by_name[key]

    node_def_orig.MergeFrom(node_def)
