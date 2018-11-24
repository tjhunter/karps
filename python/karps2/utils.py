from .proto import graph_pb2

__all__ = ['Path', 'AbstractProtoWrapper']


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

