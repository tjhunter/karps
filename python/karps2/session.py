import logging
import os
import pandas as pd
import tempfile

from .proto import types_pb2, check_proto_error, api_internal_pb2 as api, graph_pb2, standard_pb2 as std
from .types import DataType, as_sql_type
from .row import as_cell
from .objects import call_op, DataFrame, Observable, AbstractNode
from .std import collect
from .c_core import compile_graph_c
from .spark import execute_graph

__all__ = ['Session', 'ProcessContext']

logger = logging.getLogger('karps')


class Session(object):
    """ A session in Karps.

    A session encapsulates all the state that is communicated between the frontend and the backend.
    """

    def __init__(self, work_dir, spark=None, spark_db='karps_default'):
        self._work_dir = work_dir
        self._spark = spark
        self._spark_db = spark_db
        if not os.path.exists(work_dir):
            logger.debug("Creating dir {}", work_dir)
            os.makedirs(work_dir)

    def dataframe(self, obj, schema=None):
        """
        Creates a new dataframe from the given object
        """
        if isinstance(obj, pd.DataFrame):
            proto = _pandas_proto(obj)
            return call_op("org.karps.DataLiteral",
                           extra=proto, session=self, add_debug=False)
        cwt = _build_cwt(obj, schema)
        # In the case of the dataframe, the top level should be an array.
        assert cwt.type.is_array_type, cwt.type
        return call_op("org.karps.DistributedLiteral", extra=cwt._proto, session=self)

    def eval_pandas(self, df):
        if isinstance(df, pd.DataFrame):
            return df
        return self._eval(df, return_pandas=True)

    def _eval(self, obj, return_pandas):
        if return_pandas:
            assert isinstance(obj, DataFrame)
            obj = collect(obj)
        else:
            assert isinstance(obj, Observable)
        nodes = _collect_graph(obj)
        nodes_proto = [n.kp_node_proto for n in nodes]
        print("_eval:nodes_proto:", nodes_proto)
        req = api.GraphTransformRequest(
            functional_graph=graph_pb2.Graph(nodes=nodes_proto),
            requested_paths=[obj.kp_path.as_proto]
        )
        resp = compile_graph_c(req)
        check_proto_error(resp)
        print("_eval:resp:", resp.pinned_graph.nodes)
        res = execute_graph(resp.pinned_graph.nodes, self._spark, [str(obj.kp_path)])
        return list(res.values())[0]


def set_default_context(session: Session):
    _kp_context.default_session(session)


class ProcessContext(object):
    """
    A number of variables that form an implicit state in the process and that are managed from this unique place.
    """

    def __init__(self):
        self._default_session = None  # type: Session

    def default_session(self, session: Session):
        self._default_session = session


_kp_context = ProcessContext()


def _build_cwt(obj, schema):
    # If we are provided with something schema-like, use it:
    if schema is not None:
        # Build an object that can be used as a schema.
        # This schema may be invalid but this is fine here.
        if isinstance(schema, str):
            schema = [schema]
        if isinstance(schema, list):
            # Take this list of assumed strings, and put them into a structure.
            def f(elt):
                assert isinstance(elt, str), (type(elt), elt)
                # Unknown field type, but we fix the field name.
                return types_pb2.StructField(field_name=elt, field_type=None)

            st_p = types_pb2.StructType(fields=[f(s) for s in schema])
            schema_p = types_pb2.SQLType(
                array_type=types_pb2.SQLType(struct_type=st_p, nullable=False),
                nullable=False)
            schema = DataType(schema_p)
        assert isinstance(schema, DataType), (type(schema), schema)
        cwt = as_cell(obj, schema=schema)
    else:
        # Use full inference to get the type of the data.
        # In this case, we must have at least one element.
        # assert len(obj) > 0, "object has zero length: %s" % obj
        cwt = as_cell(obj, schema=None)
    return cwt


def _pandas_proto(pdf: pd.DataFrame) -> std.DataLiteral:
    tpe = list(zip(list(pdf.dtypes.index), list(pdf.dtypes)))
    pdt = as_sql_type(tpe)
    d = tempfile.mkdtemp()
    f = os.path.join(d, "data.parquet")
    pdf.to_parquet(f, compression='snappy')
    with open(f, 'rb') as o:
        ba = bytes(o.read())
    return std.DataLiteral(
        data_type=pdt.to_proto,
        parquet=ba
    )


def _collect_graph(start: AbstractNode):
    current = {}

    def explore(n: AbstractNode):
        nid = id(n)
        if nid in current:
            return
        current[nid] = n
        for p in n.kp_parents:
            explore(p)
    explore(start)
    return current.values()
