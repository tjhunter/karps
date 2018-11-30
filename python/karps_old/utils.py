from .proto import graph_pb2

__all__ = ['_current_global_path', 'scope', 'Path', 'get_and_increment_counter',
 'AbstractProtoWrapper']

class AbstractProtoWrapper(object):
  """ Basic equality functions.

  Assumes a _proto field with a proto.
  """
  def __eq__(self, other):
    return self._proto == other._proto

  def __ne__(self, other):
    return self._proto != other._proto

  def __hash__(self):
    return self._proto.SerializeToString().__hash__()


########### Paths ########

def scope(s):
  return Scope(_current_global_path.push(s))

def current_path(extra=None):
  return _current_global_path.push(extra)

def get_and_increment_counter():
  global _current_global_counter
  x = _current_global_counter
  _current_global_counter += 1
  return x

class Path(AbstractProtoWrapper):
  """ A path to an object.
  """

  def __init__(self, p=None):
    p = p or graph_pb2.Path()
    self._proto = p

  def __repr__(self):
    return "/" + "/".join(self.to_list())

  def to_list(self):
    return list(self._proto.path)

  def push(self, x):
    if x is None:
      x = []
    if isinstance(x, str):
      x = x.split("/")
    x = list(x)
    p2 = list(self._proto.path) + x
    res = Path(graph_pb2.Path(path=p2))
    return res

class Scope(object):

  def __init__(self, new_path):
    self.new_path = new_path

  def __enter__(self):
    global _current_global_path
    self.old = _current_global_path
    _current_global_path = self.new_path

  def __exit__(self, _1, _2, _3):
    global _current_global_path
    _current_global_path = self.old

_current_global_path = Path()
_current_global_counter = 0
