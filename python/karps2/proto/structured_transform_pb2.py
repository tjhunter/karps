# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: karps/proto/structured_transform.proto

import sys
_b=sys.version_info[0]<3 and (lambda x:x) or (lambda x:x.encode('latin1'))
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
from google.protobuf import descriptor_pb2
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


from karps.proto import types_pb2 as karps_dot_proto_dot_types__pb2
from karps.proto import row_pb2 as karps_dot_proto_dot_row__pb2


DESCRIPTOR = _descriptor.FileDescriptor(
  name='karps/proto/structured_transform.proto',
  package='karps.core',
  syntax='proto3',
  serialized_pb=_b('\n&karps/proto/structured_transform.proto\x12\nkarps.core\x1a\x17karps/proto/types.proto\x1a\x15karps/proto/row.proto\"\xa4\x02\n\x06\x43olumn\x12-\n\x06struct\x18\x01 \x01(\x0b\x32\x1b.karps.core.ColumnStructureH\x00\x12.\n\x08\x66unction\x18\x02 \x01(\x0b\x32\x1a.karps.core.ColumnFunctionH\x00\x12\x32\n\nextraction\x18\x03 \x01(\x0b\x32\x1c.karps.core.ColumnExtractionH\x00\x12:\n\tbroadcast\x18\x04 \x01(\x0b\x32%.karps.core.ColumnBroadcastObservableH\x00\x12,\n\x07literal\x18\x05 \x01(\x0b\x32\x19.karps.core.ColumnLiteralH\x00\x12\x12\n\nfield_name\x18\n \x01(\tB\t\n\x07\x63ontent\"5\n\x19\x43olumnBroadcastObservable\x12\x18\n\x10observable_index\x18\x01 \x01(\x05\":\n\rColumnLiteral\x12)\n\x07\x63ontent\x18\x01 \x01(\x0b\x32\x18.karps.core.CellWithType\"5\n\x0f\x43olumnStructure\x12\"\n\x06\x66ields\x18\x01 \x03(\x0b\x32\x12.karps.core.Column\"w\n\x0e\x43olumnFunction\x12\x15\n\rfunction_name\x18\x01 \x01(\t\x12\"\n\x06inputs\x18\x02 \x03(\x0b\x32\x12.karps.core.Column\x12*\n\rexpected_type\x18\x03 \x01(\x0b\x32\x13.karps.core.SQLType\" \n\x10\x43olumnExtraction\x12\x0c\n\x04path\x18\x01 \x03(\t\"\x8e\x01\n\x0b\x41ggregation\x12-\n\x02op\x18\x01 \x01(\x0b\x32\x1f.karps.core.AggregationFunctionH\x00\x12\x32\n\x06struct\x18\x02 \x01(\x0b\x32 .karps.core.AggregationStructureH\x00\x12\x12\n\nfield_name\x18\x03 \x01(\tB\x08\n\x06\x61gg_op\"\x86\x01\n\x13\x41ggregationFunction\x12\x15\n\rfunction_name\x18\x01 \x01(\t\x12,\n\x06inputs\x18\x02 \x03(\x0b\x32\x1c.karps.core.ColumnExtraction\x12*\n\rexpected_type\x18\x03 \x01(\x0b\x32\x13.karps.core.SQLType\"?\n\x14\x41ggregationStructure\x12\'\n\x06\x66ields\x18\x01 \x03(\x0b\x32\x17.karps.core.Aggregationb\x06proto3')
  ,
  dependencies=[karps_dot_proto_dot_types__pb2.DESCRIPTOR,karps_dot_proto_dot_row__pb2.DESCRIPTOR,])




_COLUMN = _descriptor.Descriptor(
  name='Column',
  full_name='karps.core.Column',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='struct', full_name='karps.core.Column.struct', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='function', full_name='karps.core.Column.function', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='extraction', full_name='karps.core.Column.extraction', index=2,
      number=3, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='broadcast', full_name='karps.core.Column.broadcast', index=3,
      number=4, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='literal', full_name='karps.core.Column.literal', index=4,
      number=5, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='field_name', full_name='karps.core.Column.field_name', index=5,
      number=10, type=9, cpp_type=9, label=1,
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
    _descriptor.OneofDescriptor(
      name='content', full_name='karps.core.Column.content',
      index=0, containing_type=None, fields=[]),
  ],
  serialized_start=103,
  serialized_end=395,
)


_COLUMNBROADCASTOBSERVABLE = _descriptor.Descriptor(
  name='ColumnBroadcastObservable',
  full_name='karps.core.ColumnBroadcastObservable',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='observable_index', full_name='karps.core.ColumnBroadcastObservable.observable_index', index=0,
      number=1, type=5, cpp_type=1, label=1,
      has_default_value=False, default_value=0,
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
  serialized_start=397,
  serialized_end=450,
)


_COLUMNLITERAL = _descriptor.Descriptor(
  name='ColumnLiteral',
  full_name='karps.core.ColumnLiteral',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='content', full_name='karps.core.ColumnLiteral.content', index=0,
      number=1, type=11, cpp_type=10, label=1,
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
  serialized_start=452,
  serialized_end=510,
)


_COLUMNSTRUCTURE = _descriptor.Descriptor(
  name='ColumnStructure',
  full_name='karps.core.ColumnStructure',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='fields', full_name='karps.core.ColumnStructure.fields', index=0,
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
  serialized_start=512,
  serialized_end=565,
)


_COLUMNFUNCTION = _descriptor.Descriptor(
  name='ColumnFunction',
  full_name='karps.core.ColumnFunction',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='function_name', full_name='karps.core.ColumnFunction.function_name', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='inputs', full_name='karps.core.ColumnFunction.inputs', index=1,
      number=2, type=11, cpp_type=10, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='expected_type', full_name='karps.core.ColumnFunction.expected_type', index=2,
      number=3, type=11, cpp_type=10, label=1,
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
  serialized_start=567,
  serialized_end=686,
)


_COLUMNEXTRACTION = _descriptor.Descriptor(
  name='ColumnExtraction',
  full_name='karps.core.ColumnExtraction',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='path', full_name='karps.core.ColumnExtraction.path', index=0,
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
  serialized_start=688,
  serialized_end=720,
)


_AGGREGATION = _descriptor.Descriptor(
  name='Aggregation',
  full_name='karps.core.Aggregation',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='op', full_name='karps.core.Aggregation.op', index=0,
      number=1, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='struct', full_name='karps.core.Aggregation.struct', index=1,
      number=2, type=11, cpp_type=10, label=1,
      has_default_value=False, default_value=None,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='field_name', full_name='karps.core.Aggregation.field_name', index=2,
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
    _descriptor.OneofDescriptor(
      name='agg_op', full_name='karps.core.Aggregation.agg_op',
      index=0, containing_type=None, fields=[]),
  ],
  serialized_start=723,
  serialized_end=865,
)


_AGGREGATIONFUNCTION = _descriptor.Descriptor(
  name='AggregationFunction',
  full_name='karps.core.AggregationFunction',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='function_name', full_name='karps.core.AggregationFunction.function_name', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='inputs', full_name='karps.core.AggregationFunction.inputs', index=1,
      number=2, type=11, cpp_type=10, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='expected_type', full_name='karps.core.AggregationFunction.expected_type', index=2,
      number=3, type=11, cpp_type=10, label=1,
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
  serialized_start=868,
  serialized_end=1002,
)


_AGGREGATIONSTRUCTURE = _descriptor.Descriptor(
  name='AggregationStructure',
  full_name='karps.core.AggregationStructure',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='fields', full_name='karps.core.AggregationStructure.fields', index=0,
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
  serialized_start=1004,
  serialized_end=1067,
)

_COLUMN.fields_by_name['struct'].message_type = _COLUMNSTRUCTURE
_COLUMN.fields_by_name['function'].message_type = _COLUMNFUNCTION
_COLUMN.fields_by_name['extraction'].message_type = _COLUMNEXTRACTION
_COLUMN.fields_by_name['broadcast'].message_type = _COLUMNBROADCASTOBSERVABLE
_COLUMN.fields_by_name['literal'].message_type = _COLUMNLITERAL
_COLUMN.oneofs_by_name['content'].fields.append(
  _COLUMN.fields_by_name['struct'])
_COLUMN.fields_by_name['struct'].containing_oneof = _COLUMN.oneofs_by_name['content']
_COLUMN.oneofs_by_name['content'].fields.append(
  _COLUMN.fields_by_name['function'])
_COLUMN.fields_by_name['function'].containing_oneof = _COLUMN.oneofs_by_name['content']
_COLUMN.oneofs_by_name['content'].fields.append(
  _COLUMN.fields_by_name['extraction'])
_COLUMN.fields_by_name['extraction'].containing_oneof = _COLUMN.oneofs_by_name['content']
_COLUMN.oneofs_by_name['content'].fields.append(
  _COLUMN.fields_by_name['broadcast'])
_COLUMN.fields_by_name['broadcast'].containing_oneof = _COLUMN.oneofs_by_name['content']
_COLUMN.oneofs_by_name['content'].fields.append(
  _COLUMN.fields_by_name['literal'])
_COLUMN.fields_by_name['literal'].containing_oneof = _COLUMN.oneofs_by_name['content']
_COLUMNLITERAL.fields_by_name['content'].message_type = karps_dot_proto_dot_row__pb2._CELLWITHTYPE
_COLUMNSTRUCTURE.fields_by_name['fields'].message_type = _COLUMN
_COLUMNFUNCTION.fields_by_name['inputs'].message_type = _COLUMN
_COLUMNFUNCTION.fields_by_name['expected_type'].message_type = karps_dot_proto_dot_types__pb2._SQLTYPE
_AGGREGATION.fields_by_name['op'].message_type = _AGGREGATIONFUNCTION
_AGGREGATION.fields_by_name['struct'].message_type = _AGGREGATIONSTRUCTURE
_AGGREGATION.oneofs_by_name['agg_op'].fields.append(
  _AGGREGATION.fields_by_name['op'])
_AGGREGATION.fields_by_name['op'].containing_oneof = _AGGREGATION.oneofs_by_name['agg_op']
_AGGREGATION.oneofs_by_name['agg_op'].fields.append(
  _AGGREGATION.fields_by_name['struct'])
_AGGREGATION.fields_by_name['struct'].containing_oneof = _AGGREGATION.oneofs_by_name['agg_op']
_AGGREGATIONFUNCTION.fields_by_name['inputs'].message_type = _COLUMNEXTRACTION
_AGGREGATIONFUNCTION.fields_by_name['expected_type'].message_type = karps_dot_proto_dot_types__pb2._SQLTYPE
_AGGREGATIONSTRUCTURE.fields_by_name['fields'].message_type = _AGGREGATION
DESCRIPTOR.message_types_by_name['Column'] = _COLUMN
DESCRIPTOR.message_types_by_name['ColumnBroadcastObservable'] = _COLUMNBROADCASTOBSERVABLE
DESCRIPTOR.message_types_by_name['ColumnLiteral'] = _COLUMNLITERAL
DESCRIPTOR.message_types_by_name['ColumnStructure'] = _COLUMNSTRUCTURE
DESCRIPTOR.message_types_by_name['ColumnFunction'] = _COLUMNFUNCTION
DESCRIPTOR.message_types_by_name['ColumnExtraction'] = _COLUMNEXTRACTION
DESCRIPTOR.message_types_by_name['Aggregation'] = _AGGREGATION
DESCRIPTOR.message_types_by_name['AggregationFunction'] = _AGGREGATIONFUNCTION
DESCRIPTOR.message_types_by_name['AggregationStructure'] = _AGGREGATIONSTRUCTURE
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

Column = _reflection.GeneratedProtocolMessageType('Column', (_message.Message,), dict(
  DESCRIPTOR = _COLUMN,
  __module__ = 'karps.proto.structured_transform_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.Column)
  ))
_sym_db.RegisterMessage(Column)

ColumnBroadcastObservable = _reflection.GeneratedProtocolMessageType('ColumnBroadcastObservable', (_message.Message,), dict(
  DESCRIPTOR = _COLUMNBROADCASTOBSERVABLE,
  __module__ = 'karps.proto.structured_transform_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.ColumnBroadcastObservable)
  ))
_sym_db.RegisterMessage(ColumnBroadcastObservable)

ColumnLiteral = _reflection.GeneratedProtocolMessageType('ColumnLiteral', (_message.Message,), dict(
  DESCRIPTOR = _COLUMNLITERAL,
  __module__ = 'karps.proto.structured_transform_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.ColumnLiteral)
  ))
_sym_db.RegisterMessage(ColumnLiteral)

ColumnStructure = _reflection.GeneratedProtocolMessageType('ColumnStructure', (_message.Message,), dict(
  DESCRIPTOR = _COLUMNSTRUCTURE,
  __module__ = 'karps.proto.structured_transform_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.ColumnStructure)
  ))
_sym_db.RegisterMessage(ColumnStructure)

ColumnFunction = _reflection.GeneratedProtocolMessageType('ColumnFunction', (_message.Message,), dict(
  DESCRIPTOR = _COLUMNFUNCTION,
  __module__ = 'karps.proto.structured_transform_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.ColumnFunction)
  ))
_sym_db.RegisterMessage(ColumnFunction)

ColumnExtraction = _reflection.GeneratedProtocolMessageType('ColumnExtraction', (_message.Message,), dict(
  DESCRIPTOR = _COLUMNEXTRACTION,
  __module__ = 'karps.proto.structured_transform_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.ColumnExtraction)
  ))
_sym_db.RegisterMessage(ColumnExtraction)

Aggregation = _reflection.GeneratedProtocolMessageType('Aggregation', (_message.Message,), dict(
  DESCRIPTOR = _AGGREGATION,
  __module__ = 'karps.proto.structured_transform_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.Aggregation)
  ))
_sym_db.RegisterMessage(Aggregation)

AggregationFunction = _reflection.GeneratedProtocolMessageType('AggregationFunction', (_message.Message,), dict(
  DESCRIPTOR = _AGGREGATIONFUNCTION,
  __module__ = 'karps.proto.structured_transform_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.AggregationFunction)
  ))
_sym_db.RegisterMessage(AggregationFunction)

AggregationStructure = _reflection.GeneratedProtocolMessageType('AggregationStructure', (_message.Message,), dict(
  DESCRIPTOR = _AGGREGATIONSTRUCTURE,
  __module__ = 'karps.proto.structured_transform_pb2'
  # @@protoc_insertion_point(class_scope:karps.core.AggregationStructure)
  ))
_sym_db.RegisterMessage(AggregationStructure)


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
