# karps-python
Python bindings for the Karps project

## Development note.

The proto interface is generated this way (from the root of the karps-python project):

PYTHONPATH="" python3 -m grpc_tools.protoc -I$KARPS/src/main/protobuf/ --python_out=. --grpc_python_out=. \
$KARPS/src/main/protobuf/karps/proto/api_internal.proto \
$KARPS/src/main/protobuf/karps/proto/computation.proto \
$KARPS/src/main/protobuf/karps/proto/graph.proto \
$KARPS/src/main/protobuf/karps/proto/interface.proto \
$KARPS/src/main/protobuf/karps/proto/io.proto \
$KARPS/src/main/protobuf/karps/proto/row.proto \
$KARPS/src/main/protobuf/karps/proto/std.proto \
$KARPS/src/main/protobuf/karps/proto/structured_transform.proto \
$KARPS/src/main/protobuf/karps/proto/types.proto \
$KARPS/src/main/protobuf/tensorflow/core/framework/attr_value.proto \
$KARPS/src/main/protobuf/tensorflow/core/framework/graph.proto \
$KARPS/src/main/protobuf/tensorflow/core/framework/node_def.proto

How to run:

```bash
PYTHONPATH=$PWD pipenv run ipython notebook
```
