# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: karps/proto/graph.proto

import sys
_b=sys.version_info[0]<3 and (lambda x:x) or (lambda x:x.encode('latin1'))
from google.protobuf.internal import enum_type_wrapper
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
from google.protobuf import descriptor_pb2
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


from karps.proto import types_pb2 as karps_dot_proto_dot_types__pb2
from tensorflow.core.framework import graph_pb2 as tensorflow_dot_core_dot_framework_dot_graph__pb2


DESCRIPTOR = _descriptor.FileDescriptor(
  name='karps/proto/graph.proto',
  package='karps.core',
  syntax='proto3',
  serialized_pb=_b('\n\x17karps/proto/graph.proto\x12\nkarps.core\x1a\x17karps/proto/types.proto\x1a%tensorflow/core/framework/graph.proto\"\x84\x02\n\x04Node\x12&\n\x08locality\x18\x01 \x01(\x0e\x32\x14.karps.core.Locality\x12\x1e\n\x04path\x18\x02 \x01(\x0b\x32\x10.karps.core.Path\x12\x0f\n\x07op_name\x18\x03 \x01(\t\x12%\n\x08op_extra\x18\x04 \x01(\x0b\x32\x13.karps.core.OpExtra\x12!\n\x07parents\x18\x05 \x03(\x0b\x32\x10.karps.core.Path\x12.\n\x14logical_dependencies\x18\x06 \x03(\x0b\x32\x10.karps.core.Path\x12)\n\x0cinfered_type\x18\x07 \x01(\x0b\x32\x13.karps.core.SQLType\"(\n\x05Graph\x12\x1f\n\x05nodes\x18\x01 \x03(\x0b\x32\x10.karps.core.Node\"\x14\n\x04Path\x12\x0c\n\x04path\x18\x01 \x03(\t\"I\n\x07OpExtra\x12\x0f\n\x07\x63ontent\x18\x01 \x01(\x0c\x12\x15\n\rcontent_debug\x18\x02 \x01(\t\x12\x16\n\x0e\x63ontent_base64\x18\x03 \x01(\t\"\xad\x01\n\x15\x43ompilationPhaseGraph\x12\x12\n\nphase_name\x18\x01 \x01(\t\x12 \n\x05graph\x18\x02 \x01(\x0b\x32\x11.karps.core.Graph\x12\x1e\n\x16graph_tensorboard_repr\x18\x03 \x01(\t\x12\x15\n\rerror_message\x18\x04 \x01(\t\x12\'\n\tgraph_def\x18\x05 \x01(\x0b\x32\x14.tensorflow.GraphDef*&\n\x08Locality\x12\t\n\x05LOCAL\x10\x00\x12\x0f\n\x0b\x44ISTRIBUTED\x10\x01\x62\x06proto3')
  ,
  dependencies=[karps_dot_proto_dot_types__pb2.DESCRIPTOR,tensorflow_dot_core_dot_framework_dot_graph__pb2.DESCRIPTOR,])

_LOCALITY = _descriptor.EnumDescriptor(
  name='Locality',
  full_name='karps.core.Locality',
  filename=None,
  file=DESCRIPTOR,
  values=[
    _descriptor.EnumValueDescriptor(
      name='LOCAL', index=0, number=0,
      options=None,
      type=None),
    _descriptor.EnumValueDescriptor(
      name='DISTRIBUTED', index=1, number=1,
      options=None,
      type=None),
  ],
  containing_type=None,
  options=None,
  serialized_start=681,
  serialized_end=719,
)
_sym_db.RegisterEnumDescriptor(_LOCALITY)

Locality = enum_type_wrapper.EnumTypeWrapper(_LOCALITY)
LOCAL = 0
DISTRIBUTED = 1



_NODE = _descriptor.Descriptor(
  name='Node',
  full_name='karps.core.Node',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='locality', full_name='karps.core.Node.locality', index=0,
      number=1, type=14, cpp_type=8, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='path', full_name='karps.core.Node.path', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='op_name', full_name='karps.core.Node.op_name', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='op_extra', full_name='karps.core.Node.op_extra', index=3,
      number=4, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='parents', full_name='karps.core.Node.parents', index=4,
      number=5, type=11, cpp_type=10, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='logical_dependencies', full_name='karps.core.Node.logical_dependencies', index=5,
      number=6, type=11, cpp_type=10, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='infered_type', full_name='karps.core.Node.infered_type', index=6,
      number=7, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=104,
  serialized_end=364,
)


_GRAPH = _descriptor.Descriptor(
  name='Graph',
  full_name='karps.core.Graph',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='nodes', full_name='karps.core.Graph.nodes', index=0,
      number=1, type=11, cpp_type=10, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=366,
  serialized_end=406,
)


_PATH = _descriptor.Descriptor(
  name='Path',
  full_name='karps.core.Path',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='path', full_name='karps.core.Path.path', index=0,
      number=1, type=9, cpp_type=9, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=408,
  serialized_end=428,
)


_OPEXTRA = _descriptor.Descriptor(
  name='OpExtra',
  full_name='karps.core.OpExtra',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='content', full_name='karps.core.OpExtra.content', index=0,
      number=1, type=12, cpp_type=9, label=1,
      has_default_value=False, default_value=_b(""),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='content_debug', full_name='karps.core.OpExtra.content_debug', index=1,
      number=2, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='content_base64', full_name='karps.core.OpExtra.content_base64', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=430,
  serialized_end=503,
)


_COMPILATIONPHASEGRAPH = _descriptor.Descriptor(
  name='CompilationPhaseGraph',
  full_name='karps.core.CompilationPhaseGraph',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='phase_name', full_name='karps.core.CompilationPhaseGraph.phase_name', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='graph', full_name='karps.core.CompilationPhaseGraph.graph', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='graph_tensorboard_repr', full_name='karps.core.CompilationPhaseGraph.graph_tensorboard_repr', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='error_message', full_name='karps.core.CompilationPhaseGraph.error_message', index=3,
      number=4, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='graph_def', full_name='karps.core.CompilationPhaseGraph.graph_def', index=4,
      number=5, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=506,
  serialized_end=679,
)

_NODE.fields_by_name['locality'].enum_type = _LOCALITY
_NODE.fields_by_name['path'].message_type = _PATH
_NODE.fields_by_name['op_extra'].message_type = _OPEXTRA
_NODE.fields_by_name['parents'].message_type = _PATH
_NODE.fields_by_name['logical_dependencies'].message_type = _PATH
_NODE.fields_by_name['infered_type'].message_type = karps_dot_proto_dot_types__pb2._SQLTYPE
_GRAPH.fields_by_name['nodes'].message_type = _NODE
_COMPILATIONPHASEGRAPH.fields_by_name['graph'].message_type = _GRAPH
_COMPILATIONPHASEGRAPH.fields_by_name['graph_def'].message_type = tensorflow_dot_core_dot_framework_dot_graph__pb2._GRAPHDEF
DESCRIPTOR.message_types_by_name['Node'] = _NODE
DESCRIPTOR.message_types_by_name['Graph'] = _GRAPH
DESCRIPTOR.message_types_by_name['Path'] = _PATH
DESCRIPTOR.message_types_by_name['OpExtra'] = _OPEXTRA
DESCRIPTOR.message_types_by_name['CompilationPhaseGraph'] = _COMPILATIONPHASEGRAPH
DESCRIPTOR.enum_types_by_name['Locality'] = _LOCALITY
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

Node = _reflection.GeneratedProtocolMessageType('Node', (_message.Message,), dict(
  DESCRIPTOR = _NODE,
  __module__ = 'karps.proto.graph_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.Node)
  ))
_sym_db.RegisterMessage(Node)

Graph = _reflection.GeneratedProtocolMessageType('Graph', (_message.Message,), dict(
  DESCRIPTOR = _GRAPH,
  __module__ = 'karps.proto.graph_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.Graph)
  ))
_sym_db.RegisterMessage(Graph)

Path = _reflection.GeneratedProtocolMessageType('Path', (_message.Message,), dict(
  DESCRIPTOR = _PATH,
  __module__ = 'karps.proto.graph_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.Path)
  ))
_sym_db.RegisterMessage(Path)

OpExtra = _reflection.GeneratedProtocolMessageType('OpExtra', (_message.Message,), dict(
  DESCRIPTOR = _OPEXTRA,
  __module__ = 'karps.proto.graph_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.OpExtra)
  ))
_sym_db.RegisterMessage(OpExtra)

CompilationPhaseGraph = _reflection.GeneratedProtocolMessageType('CompilationPhaseGraph', (_message.Message,), dict(
  DESCRIPTOR = _COMPILATIONPHASEGRAPH,
  __module__ = 'karps.proto.graph_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.CompilationPhaseGraph)
  ))
_sym_db.RegisterMessage(CompilationPhaseGraph)


try:
  # THESE ELEMENTS WILL BE DEPRECATED.
  # Please use the generated *_pb2_grpc.py files instead.
  import grpc
  from grpc.beta import implementations as beta_implementations
  from grpc.beta import interfaces as beta_interfaces
  from grpc.framework.common import cardinality
  from grpc.framework.interfaces.face import utilities as face_utilities
except ImportError:
  pass
# @@protoc_insertion_point(module_scope)
