from .proto import types_pb2 as pb
from .utils import AbstractProtoWrapper

__all__ = ['DataType', 'IntegerType', 'DoubleType', 'BooleanType',
           'ArrayType', 'StructField', 'StructType',
           'merge_proto_types', 'merge_types']


class DataType(AbstractProtoWrapper):

    def __init__(self, _proto: pb.SQLType):
        assert _proto
        # The underlying representation uses the proto interface.
        self._proto = _proto

    def __repr__(self):
        return _repr_proto(self._proto)

    @property
    def strict(self):
        return not self._proto.nullable

    @property
    def nullable(self):
        return self._proto.nullable

    # Properties for array type

    @property
    def is_array_type(self):
        return self._proto.HasField("array_type")

    @property
    def inner_type(self):
        assert self.is_array_type, self
        return DataType(self._proto.array_type)

    @property
    def is_struct_type(self):
        return self._proto.HasField("struct_type")

    @property
    def struct_fields(self):
        assert self.is_struct_type, self
        return [StructField(x) for x in self._proto.struct_type.fields]

    @property
    def to_proto(self) -> pb.SQLType:
        return self._proto


class _StructField(AbstractProtoWrapper):
    """ A field in a struct.
    """

    def __init__(self, proto):
        assert proto
        self._proto = proto

    @property
    def name(self):
        return self._proto.field_name

    @property
    def type(self):
        return DataType(self._proto.field_type)


def StructField(dt, field_name=None):
    if isinstance(dt, DataType):
        dt = dt._proto
    sf = pb.StructField()
    if isinstance(dt, pb.StructField):
        sf.CopyFrom(dt)
    else:
        assert isinstance(dt, pb.SQLType), dt
        sf.field_type.CopyFrom(dt)
    if field_name is not None:
        assert field_name, field_name
        sf.field_name = field_name
    return _StructField(sf)


def IntegerType(strict=True):
    return DataType(pb.SQLType(basic_type=pb.SQLType.INT, nullable=not strict))


def DoubleType(strict=True):
    return DataType(pb.SQLType(basic_type=pb.SQLType.DOUBLE, nullable=not strict))


def BooleanType(strict=True):
    return DataType(pb.SQLType(basic_type=pb.SQLType.BOOL, nullable=not strict))


def ArrayType(inner, strict=True):
    """ The type for arrays in Karps.
    """
    _inner = inner._proto
    return DataType(pb.SQLType(
        array_type=_inner,
        nullable=not strict))


def StructType(l, strict=True):
    l2 = []
    for x in l:
        if isinstance(x, _StructField):
            l2.append(x._proto)
        elif isinstance(x, pb.StructField):
            l2.append(x)
        else:
            assert False, (type(x), x)
    assert l2, l  # No empty struct, forbidden by Karps.
    return DataType(pb.SQLType(
        struct_type=pb.StructType(fields=l2), nullable=not strict))


def make_tuple(*fields):
    """ Takes a list of data types or fields
    """
    fields2 = []
    for (idx, f) in zip(range(len(fields)), fields):
        if isinstance(f, (_StructField, pb.StructField)):
            fields2.append(f)
        if isinstance(f, pb.SQLType):
            fields2.append(pb.StructField(
                field_name="_%s" % str(idx),
                field_type=f))
        raise ValueError("Could not understand type %s for %s" % (type(f), f))
    return StructType(fields2)


def merge_types(tp1, tp2):
    """ Merges two types together.
    """
    return DataType(merge_proto_types(tp1._proto, tp2._proto))


_none_proto_type = pb.SQLType()


def merge_proto_types(tp1, tp2):
    """ Attempts to merge two types (in proto)
    """
    if tp1 is None and tp2 is None:
        return _none_proto_type
    if tp1 is None:
        return tp2
    if tp2 is None:
        return tp1
    if tp1 == _none_proto_type and tp2 == _none_proto_type:
        return _none_proto_type
    if tp2 == _none_proto_type:
        return tp1
    if tp1 == _none_proto_type:
        return tp2
    if tp1 == tp2:
        return tp1
    if tp1.HasField("basic_type") and tp2.HasField("basic_type"):
        assert tp1.basic_type == tp2.basic_type, (tp1, tp2)
        return pb.SQLType(
            basic_type=tp1.basic_type,
            nullable=tp1.nullable or tp2.nullable)
    if tp1.HasField('array_type'):
        assert tp2.HasField('array_type'), (tp1, tp2)
        return pb.SQLType(
            array_type=merge_proto_types(tp1.array_type, tp2.array_type),
            nullable=tp1.nullable or tp2.nullable)
    if tp1.HasField('struct_type'):
        assert tp2.HasField('struct_type'), (tp1, tp2)
        l1 = tp1.struct_type.fields
        l2 = tp2.struct_type.fields
        assert len(l1) == len(l2), (l1, l2)
        l = []
        for (f1, f2) in zip(l1, l2):
            assert f1.field_name == f2.field_name, (f1, f2)
            l.append(pb.StructField(field_name=f1.field_name,
                                    field_type=merge_proto_types(f1.field_type, f2.field_type)))
        return pb.SQLType(
            struct_type=pb.StructType(fields=l),
            nullable=tp1.nullable or tp2.nullable)
    raise Exception("Cannot merge incompatible types %s and %s" % (tp1, tp2))


def _repr_proto(p):
    x = None
    if p.basic_type == pb.SQLType.INT:
        x = "int"
    elif p.basic_type == pb.SQLType.DOUBLE:
        x = "double"
    elif p.basic_type == pb.SQLType.STRING:
        x = "string"
    elif p.basic_type == pb.SQLType.BOOL:
        x = "bool"
    elif p.array_type != _none_proto_type:
        x = "[" + _repr_proto(p.array_type) + "]"
    elif p.HasField("struct_type"):
        x = "{" + ", ".join([_repr_proto_field(f) for f in p.struct_type.fields]) + "}"
    assert x, p
    if p.nullable:
        x += "?"
    return x


def _repr_proto_field(p):
    return "{}:{}".format(p.field_name, _repr_proto(p.field_type))
