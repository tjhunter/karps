import gevent
from gevent.event import Event
import logging

from ..proto import graph_pb2

__all__ = ['execute_graph']


logger = logging.getLogger('karps')


class AsyncNode(object):

    def __init__(self, n, deps, spark):
        self.node = n
        self.path = _path_str(n.path.path)
        self._deps = deps
        self._spark = spark
        self.event = Event()
        self.result = None
        print("Path {} has been created".format(self.path))

    def trigger(self):
        print("Path {} has been triggered".format(self.path))
        for d in self._deps:
            d.event.wait()
        print("Path {} is executing for node {}".format(self.path, self.node))
        self.result = 1
        self.event.set()
        return self


def _path_str(path):
    return "/" + "/".join(path)


def execute_graph(actions: [graph_pb2.Node], spark, returns):
    def can_execute(n: graph_pb2.Node, done):
        parents = n.parents or []
        ll = [_path_str(p.path) not in done for p in parents]
        if any(ll):
            return None
        return [done[_path_str(p.path)] for p in parents]

    def make_futures(todo: [graph_pb2.Node], done):
        if not todo:
            return done
        available = []
        rem = []
        for n in todo:
            parents = can_execute(n, done)
            if parents is not None:
                an = AsyncNode(n, parents, spark)
                available.append(an)
            else:
                rem.append(n)
        assert available, (todo, done)
        new = dict(done)
        new.update(dict([(an.path, an) for an in available]))
        return make_futures(rem, new)

    nodes = make_futures(actions, {})
    nodes = nodes.values()
    gevent.joinall([gevent.spawn(n.trigger) for n in nodes])
    d = dict([(an.path, an.result) for an in nodes])
    return dict([(p, d[p]) for p in returns])


