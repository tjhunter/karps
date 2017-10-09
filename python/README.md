# karps-python
Python bindings for the Karps project.

This project implements a small module that interfaces with the Karps server through the Grpc protocol. It is the
reference client implementation for Karps. It provides convenient integration with Jupyter/IPython, and some
developer tools for other interactive environments such as Databricks notebooks.

## User instructions

Users should use the version published in pypi. TODO.

See the notebooks in the [notebooks directory](notebooks/) for some examples. See the main readme for instructions
on how to run the server.

## Development note.

The proto interface is generated this way (from the root of the karps-python project):

```bash
python3 -m grpc_tools.protoc -I../src/main/protobuf/ --python_out=. --grpc_python_out=. \
../src/main/protobuf/karps/proto/api_internal.proto \
../src/main/protobuf/karps/proto/computation.proto \
../src/main/protobuf/karps/proto/graph.proto \
../src/main/protobuf/karps/proto/interface.proto \
../src/main/protobuf/karps/proto/io.proto \
../src/main/protobuf/karps/proto/row.proto \
../src/main/protobuf/karps/proto/std.proto \
../src/main/protobuf/karps/proto/structured_transform.proto \
../src/main/protobuf/karps/proto/types.proto
```

The easiest is to use `pipenv` to set up all the dependencies and run the project.

```
pipenv install
```

```bash
PYTHONPATH=$PWD pipenv run ipython notebook
```
