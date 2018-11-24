""" Utilities to express rows of data with Karps.
"""
import pandas as pd

from .proto import types_pb2
from .proto import row_pb2
from .types import *

__all__ = ['CellWithType', 'as_cell', 'as_python_object', 'as_pandas_object']


class CellWithType(object):
    """ A cell of data, with its type information.

    This is usually constructed with one of the helper functions.
    """

    def __init__(self, proto):
        assert proto
        self._proto = proto  # type: row_pb2.CellWithType

    def __repr__(self):
        return repr((self.type, self._proto.cell))

    def __eq__(self, other):
        return self._proto == other._proto

    def __ne__(self, other):
        return self._proto != other._proto

    @property
    def type(self):
        """ The data type associated to this cell.
        """
        if self._proto.cell_type:
            return DataType(self._proto.cell_type)
        return None


def as_cell(obj, schema=None):
    """ Converts a python object as a cell, potentially with the help of extra type hints.

    If the type is not provided, it will be inferred
    The object can be any of the following:
     - None
     - a primitive
     - an iterable or a tuple. They are considered array types, unless a struct type is provided as a
       hint
     - a dictionary. It is considered a struct, with all the fields sorted in alphabetical order.
     - a pandas type
     - a Spark row
     - a numpy row
    """
    cwt_proto = _as_cell(obj, schema._proto if schema else None)
    return CellWithType(cwt_proto)


def as_python_object(cwt: CellWithType):
    """ Converts a CellWithType object to a python object (best effort).
    """
    return _as_python(cwt._proto.cell, cwt._proto.cell_type)


def as_pandas_object(cwt: CellWithType):
    """Converts a CellWithType object to a pandas object (best effort)"""
    pobj = as_python_object(cwt)
    if isinstance(pobj, list):
        # This is a list, try to convert it to a pandas dataframe.
        return pd.DataFrame(pobj)
    return pobj


def _as_python(c_proto, tpe_proto):
    # The type is still required for dictionaries.
    if c_proto.HasField('int_value'):
        return int(c_proto.int_value)
    if c_proto.HasField('string_value'):
        return str(c_proto.string_value)
    if c_proto.HasField('double_value'):
        return float(c_proto.double_value)
    if c_proto.HasField('array_value'):
        return [_as_python(x, tpe_proto.array_type) for x in c_proto.array_value.values]
    if c_proto.HasField('struct_value'):
        fields = tpe_proto.struct_type.fields
        field_names = [f.field_name for f in fields]
        field_types = [f.field_type for f in fields]
        values = [_as_python(x, t) for (x, t) in zip(c_proto.struct_value, field_types)]
        return dict(zip(field_names, values))


def _as_cell_infer(obj):
    """ Converts a python object to a proto CellWithType object, and attemps to infer the data type
    at the same time.
    """
    if obj is None:
        # No type, empty data.
        return row_pb2.CellWithType(cell=row_pb2.Cell(), cell_type=None)
    if isinstance(obj, int):
        # Strict int
        return _as_cell(obj, types_pb2.SQLType(basic_type=types_pb2.SQLType.INT, nullable=False))
    if isinstance(obj, float):
        # Strict float -> double
        return _as_cell(obj, types_pb2.SQLType(basic_type=types_pb2.SQLType.DOUBLE, nullable=False))
    if isinstance(obj, str):
        # Strict string
        return _as_cell(obj, types_pb2.SQLType(basic_type=types_pb2.SQLType.STRING, nullable=False))
    if isinstance(obj, list):
        # Something that looks like a list.
        obj = list(obj)
        # Get the inner content, and check that the types are mergeable after that.
        l = [_as_cell_infer(x) for x in obj]
        inner_type = _merge_proto_types([cwt.cell_type for cwt in l])
        cells = [cwt.cell for cwt in l]
        return row_pb2.CellWithType(
            cell=row_pb2.Cell(
                array_value=row_pb2.ArrayCell(
                    values=cells)),
            cell_type=types_pb2.SQLType(
                array_type=inner_type))
    if isinstance(obj, tuple):
        # A tuple is interpreted as a dictionary with some implicit names:
        field_names = ["_" + str(idx + 1) for idx in range(len(obj))]
        dct = dict(zip(field_names, obj))
        return _as_cell_infer(dct)
    if isinstance(obj, dict):
        # It is a dictionary. This is easy, we just build a structure from the inner data.
        cells = [_as_cell(x, None) for (_, x) in obj.items()]
        keys = [k for (k, _) in obj.items()]
        return _struct(cells, keys, sort=True)
    raise Exception("Cannot understand object of type %s: %s" % (type(obj), obj))


_none_proto_type = types_pb2.SQLType()


def _as_cell(obj, tpe_proto):
    """ Converts a python object to a proto CellWithType object.

    obj: python object
    tpe_proto: a proto.Type object
    """
    # This is one of the most complex functions, because it tries to do the 'right' thing from
    # the perspective of the user, which is a fuzzy concept.
    if tpe_proto is None or tpe_proto == _none_proto_type:
        return _as_cell_infer(obj)
    if obj is None:
        assert tpe_proto.nullable, (obj, tpe_proto)
        # empty value, potentially no type either.
        return row_pb2.CellWithType(cell=row_pb2.Cell(), cell_type=tpe_proto)
    if isinstance(obj, int):
        assert tpe_proto.basic_type == types_pb2.SQLType.INT, (type(tpe_proto), tpe_proto)
        return row_pb2.CellWithType(
            cell=row_pb2.Cell(int_value=int(obj)),
            cell_type=tpe_proto)
    if isinstance(obj, float):
        assert tpe_proto.basic_type == types_pb2.SQLType.DOUBLE, (type(tpe_proto), tpe_proto)
        return row_pb2.CellWithType(
            cell=row_pb2.Cell(double_value=float(obj)),
            cell_type=tpe_proto)
    if isinstance(obj, str):
        assert tpe_proto.basic_type == types_pb2.SQLType.STRING, (type(tpe_proto), tpe_proto)
        return row_pb2.CellWithType(
            cell=row_pb2.Cell(string_value=str(obj)),
            cell_type=tpe_proto)
    # Something that looks like a list
    if isinstance(obj, (list, tuple)) and tpe_proto.HasField("array_type"):
        obj = list(obj)
        cwt_ps = [_as_cell(x, tpe_proto.array_type) for x in obj]
        c_ps = [cwt_p.cell for cwt_p in cwt_ps]
        # Try to merge together the types of the inner cells. We may have some surprises here.
        merge_type = tpe_proto.array_type
        for cwt_p in cwt_ps:
            merge_type = merge_proto_types(merge_type, cwt_p.cell_type)
        return row_pb2.CellWithType(
            cell=row_pb2.Cell(array_value=row_pb2.ArrayCell(values=c_ps)),
            cell_type=types_pb2.SQLType(
                array_type=merge_type,
                nullable=tpe_proto.nullable))
    if isinstance(obj, dict) and tpe_proto.HasField("struct_type"):
        fields = tpe_proto.struct_type.fields
        assert len(obj) == len(fields), (tpe_proto, obj)
        cells = []
        new_fields = []
        for field in fields:
            assert field.field_name in obj, (field, obj)
            # The inner type may be None, in which case, it
            f_cwt = _as_cell(obj[field.field_name], field.field_type)
            cells.append(f_cwt.cell)
            # The type may also have been updated if something got infered.
            f = types_pb2.StructField(
                field_name=field.field_name,
                field_type=f_cwt.cell_type)
            new_fields.append(f)
        return row_pb2.CellWithType(
            cell=row_pb2.Cell(struct_value=row_pb2.Row(values=cells)),
            cell_type=types_pb2.SQLType(
                struct_type=types_pb2.StructType(fields=new_fields),
                nullable=tpe_proto.nullable))
    if isinstance(obj, (list, tuple)) and tpe_proto.HasField("struct_type"):
        # Treat it as a dictionary, for which the user has not specified the name of the fields.
        obj = list(obj)
        fields = tpe_proto.struct_type.fields
        assert len(obj) == len(fields), (tpe_proto, obj)
        cells = []
        new_fields = []
        for field, x in zip(fields, obj):
            # The inner type may be None, in which case, it
            f_cwt = _as_cell(x, field.field_type)
            assert f_cwt, (x, field)
            cells.append(f_cwt.cell)
            # The type may also have been updated if something got infered.
            f = types_pb2.StructField(
                field_name=field.field_name,
                field_type=f_cwt.cell_type)
            new_fields.append(f)
        return row_pb2.CellWithType(
            cell=row_pb2.Cell(struct_value=row_pb2.Row(values=cells)),
            cell_type=types_pb2.SQLType(
                struct_type=types_pb2.StructType(fields=new_fields),
                nullable=tpe_proto.nullable))


def _merge_proto_types(l):
    res = None
    for t_p in l:
        if res is None:
            res = t_p
        else:
            res = merge_proto_types(res, t_p)
    return res


def _struct(cwts, field_names, sort=False):
    assert len(cwts) == len(field_names)
    if sort:
        z = sorted(zip(field_names, cwts), key=lambda k: k[0])
        return _struct([c for (_, c) in z], [k for (k, _) in z])
    sfields = [types_pb2.StructField(
        field_name=fname,
        field_type=cwt.cell_type) for (cwt, fname) in zip(cwts, field_names)]
    vals = [cwt.cell for cwt in cwts]
    return row_pb2.CellWithType(
        cell=row_pb2.Cell(array_value=row_pb2.ArrayCell(values=vals)),
        cell_type=types_pb2.SQLType(
            struct_type=types_pb2.StructType(
                fields=sfields)
        )
    )
