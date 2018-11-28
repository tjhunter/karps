"""
The basic objects of the Karps API: DataFrames, Columns, Observables.
"""

from typing import List

from .proto import structured_transform_pb2 as st
from .proto import graph_pb2 as gpb
from .proto import types_pb2
from .proto import api_internal_pb2 as api
from .types import DataType
from .utils import Path
from .c_core import build_node_c


class HasArithmeticOps(object):
    """ Dispatches arithmetic operations to the functions standard library.

    This class is inherited by Column, DataFrame and Observable.
    """
    pass


class AbstractColumn(object):
    """ A column of data.

    This is an abstraction for a potentially unbounded list of cells, all of the same types.

    The difference between columns and dataframes is that dataframes can exist on their own,
    while columns have a refering dataframe.

    Users should never have to create manually columns or dataframes, but rely on the framework
    for doing so.
    """
    pass

    def kp_as_dataframe(self): pass


class AbstractNode(object):
    """ The base class for observables or dataframes.
    """

    def __init__(self,
                 node_p: gpb.Node,
                 parents,  # type: List[AbstractNode]
                 deps,  # type: List[AbstractNode]
                 session
                 ):
        self._node_p = node_p
        self._parents = parents
        self._logical_dependencies = deps
        self._session = session

    @property
    def kp_node_proto(self) -> gpb.Node:
        """
        Returns a proto
        """
        return self._node_p

    @property
    def kp_path(self):
        return Path(self._node_p.path)

    @property
    def kp_op_name(self):
        return self._node_p.op_name

    @property
    def kp_type(self):
        """ The data type of this column """
        return DataType(self._node_p.infered_type)

    @property
    def kp_is_distributed(self):
        return self._node_p.locality == "DISTRIBUTED"

    @property
    def kp_is_local(self):
        return self._node_p.locality == "DISTRIBUTED"

    @property
    def kp_op_extra(self):
        """ Returns a proto """
        return self._node_p.op_extra

    @property
    def kp_parents(self):
        """ Returns the parents (other nodes). """
        return self._parents

    @property
    def kp_logical_dependencies(self):
        """ The logical dependencies """
        return self._logical_dependencies

    @property
    def kp_session(self):
        return self._session

    def __repr__(self):
        return "{p}{l}{o}:{dt}".format(
            p=str(self.kp_path),
            l="!" if self.kp_is_local else "@",
            o=self.kp_op_name,
            dt=str(self.kp_type))


class Column(AbstractColumn, HasArithmeticOps):
    """ A column of data isolated from a dataframe.
    """

    def __init__(self,
                 ref,  # type: DataFrame
                 column_p: st.Column,
                 dt: DataType,
                 field_name: str = None):
        AbstractColumn.__init__(self)
        HasArithmeticOps.__init__(self)
        self._ref = ref
        self._column_p = column_p
        self._dt = dt
        self._field_name = field_name

    def __repr__(self):
        return "{}:{}<-{}".format(self._field_name, self.kp_reference, self.kp_type)

    @property
    def kp_reference(self):
        """ The referring dataframe """
        return self._ref

    @property
    def kp_type(self):
        """ The data type of this column """
        return self._dt

    def kp_as_column(self):
        """ A column, seen as a column.
        """
        return self

    def kp_as_dataframe(self, name_hint=None):
        """ A column, seen as a dataframe (referring to itself).
        """
        pass


class DataFrame(AbstractColumn, AbstractNode, HasArithmeticOps):
    """ A dataframe.
    """

    def __init__(self,
                 node_p: gpb.Node,
                 parents,  # type: List[AbstractNode]
                 deps,  # type: List[AbstractNode]
                 session
                 ):
        AbstractNode.__init__(self, node_p, parents, deps, session)
        AbstractColumn.__init__(self)
        HasArithmeticOps.__init__(self)

    @property
    def kp_reference(self):  # type DataFrame
        """ The referring dataframe (itself). """
        return self

    def kp_as_column(self) -> Column:
        """ A dataframe, seen as a column.
        """
        pass
        # return build_col_extract(
        #     ref=self,
        #     type_p=self._type_p,
        #     path=[])

    def kp_as_dataframe(self):
        """ A dataframe, seen as a dataframe. """
        return self


class Observable(AbstractNode, HasArithmeticOps):
    """ An observable.

    Do not call the constructor, use build_observable() instead.
    """


def make_dataframe(
    session,
    op_name: str,
    op_type: DataType,
    extra=None,
    parents=None,
    deps=None):
    parents = parents or []
    deps = deps or []
    if isinstance(op_type, DataType):
        op_type = op_type.to_proto
    assert isinstance(op_type, types_pb2.SQLType), (op_type, type(op_type))
    content = extra.SerializeToString() if extra else None
    content_str = str(extra) if extra else None
    oe_p = gpb.OpExtra(content=content, content_debug=content_str)
    node_p = gpb.Node(
        locality=gpb.DISTRIBUTED,
        path=gpb.Path(path=['TODO']),
        op_name=op_name,
        op_extra=oe_p,
        infered_type=op_type)
    return DataFrame(node_p, parents, deps, session)


def call_op(op_name, extra=None, parents=None, deps=None, session=None):
    def clean(obj):
        if not isinstance(obj, AbstractNode):
            raise ValueError("{}:{}".format(type(obj), obj))
        return obj
    parents = parents or []
    parents = [clean(obj) for obj in parents]
    deps = deps or []
    deps = [clean(obj) for obj in deps]
    assert session or parents
    session = session or parents[0].kp_session
    for p in parents:
        assert session is p.kp_session, (session, p.kp_session, p)
    content = extra.SerializeToString() if extra else None
    content_str = str(extra) if extra else None
    oe_p = gpb.OpExtra(content=content, content_debug=content_str)
    req = api.NodeBuilderRequest(op_name=op_name,
                                 extra=oe_p,
                                 parents=[p.kp_node_proto for p in parents])
    resp0 = build_node_c(req.SerializeToString())
    resp = api.NodeBuilderResponse()
    resp.ParseFromString(resp0)
    if resp.error.message:
        raise ValueError(str(resp.error) + str(type(resp.error)) + str(resp))
    assert resp.success, resp
    n_p = resp.success
    if n_p.locality == gpb.DISTRIBUTED:
        return DataFrame(n_p, parents, deps, session)
    else:
        return Observable(n_p, parents, deps, session)


