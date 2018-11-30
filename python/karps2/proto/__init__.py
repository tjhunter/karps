import os
os.putenv("PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION", 'python')


from .karps.proto import standard_pb2
from .karps.proto import api_internal_pb2
from .karps.proto import computation_pb2
from .karps.proto import graph_pb2
from .karps.proto import io_pb2
from .karps.proto import profiling_pb2
from .karps.proto import row_pb2
from .karps.proto import structured_transform_pb2
from .karps.proto import types_pb2


def check_proto_error(proto):
    if proto.error.message:
        raise ValueError(str(proto.error) + str(type(proto.error)) + str(proto))
