import gevent
from gevent.event import Event
import logging
import pandas as pd
import os
import tempfile

from ..proto import graph_pb2, standard_pb2 as std

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
        logger.debug("Path {} has been created".format(self.path))

    def trigger(self):
        logger.debug("Path {} has been triggered".format(self.path))
        for d in self._deps:
            d.event.wait()
        # logger.debug("Path {} is executing for node {}".format(self.path, self.node))
        action = _actions[self.node.op_name]
        action(self._spark, self, self._deps)
        self.event.set()
        logger.debug("Path {} is done executing".format(self.path))
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


def _table_name(node):
    return "ks_" + str(node.node_id.value[:8])


def _collect_pandas(spark, anode, parents):
    parent_table = _table_name(parents[0].node)
    query = "select * from {}".format(parent_table)
    logger.debug("_collect_pandas: Running statement: {}".format(query))
    sdf = spark.sql(query)
    logger.debug("_collect_pandas: got table {}".format(sdf))
    pdf = sdf.toPandas()
    anode.result = pdf


def _materialize_pandas(spark, anode, parents):
    assert not parents, anode
    msg = std.DataLiteral()
    msg.ParseFromString(anode.node.op_extra.content)
    pdf = _pandas_from_proto(msg)
    sdf = spark.createDataFrame(pdf)
    table = _table_name(anode.node)
    sdf.registerTempTable(table)


def _pandas_from_proto(proto: std.DataLiteral) -> pd.DataFrame:
    d = tempfile.mkdtemp()
    fname = os.path.join(d, "data.parquet")
    with open(fname, 'wb') as f:
        f.write(bytes(proto.parquet))
    pdf = pd.read_parquet(fname)
    return pdf


_actions = {
    'spark.CollectPandas': _collect_pandas,
    'spark.MaterializePandas': _materialize_pandas
}
