import logging
import os

from .proto import types_pb2
from .types import DataType
from .row import as_cell
from .objects import make_dataframe

__all__ = ['Session', 'ProcessContext']

logger = logging.getLogger('karps')


class Session(object):
    """ A session in Karps.

    A session encapsulates all the state that is communicated between the frontend and the backend.
    """

    def __init__(self, work_dir, spark=None):
        self._work_dir = work_dir
        self._spark = spark
        if not os.path.exists(work_dir):
            logger.debug("Creating dir {}", work_dir)
            os.makedirs(work_dir)

    def dataframe(self, obj, schema=None):
        """
        Creates a new dataframe from the given object
        """
        cwt = _build_cwt(obj, schema)
        # In the case of the dataframe, the top level should be an array.
        assert cwt.type.is_array_type, cwt.type
        ct_proto = cwt.type.inner_type._proto
        return make_dataframe(self, "org.karps.Literal",
                              ct_proto, cwt._proto)


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
