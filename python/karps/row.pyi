from typing import Optional, Any
from .types import DataType
from .proto import row_pb2

class CellWithType(object):

    def __init__(self, proto: row_pb2.CellWithType): ...

    # @property
    # def _proto(self) -> row_pb2.CellWithType: ...

    @property
    def type(self) -> Optional[DataType]: ...

def as_cell(obj: Any, schema=None) -> CellWithType: ...

def as_python_object(cwt: CellWithType) -> Any: ...
