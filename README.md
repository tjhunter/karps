# Karps - Optimizing library for Spark dataframes.

This project is an exploration vehicle for developing composable, robust and fast
data pipelines over Apache Spark while maximizing user productivity.
It consists in multiple sub-projects:
- a specification to describe data pipelines in a language-agnostic manner,
  and a communication protocol to submit these pipelines to Spark. The
  specification is currently specified in [this repository](https://github.com/tjhunter/karps/src/main/proto), using
   [Protocol Buffers 3](https://developers.google.com/protocol-buffers/docs/proto3) (
    which is also compatible with JSON).
- a thin [python client](https://github.com/tjhunter/karps-python) that emulates a subset of the
  API for Spark and Pandas.
- a serving library, called
  [karps-server](https://github.com/krapsh/karps), that implements this specification on top of Spark.
  It is written in Scala and is loaded as a standard Spark package.
- an [optimizing compiler](https://github.com/tjhunter/karps-haskell), that takes descriptions of
  data pipeline in the above specification and produces improved, lower-level representations more
  amenable to Spark or Pandas.
- a [Haskell client](https://github.com/tjhunter/karps-haskell), which generates such computation
  graphs using a DSL. This is the reference client.

There is also a separate set of utilities to visualize such pipelines using
Jupyter notebooks, IPython and IHaskell.

The name is a play on a tasty fish of the family Cyprinidae, and an anagram of Spark. The programming model is strongly influenced by the
[TensorFlow project](https://www.tensorflow.org/) and follows a similar design.


 > This is a preview, the API may (will) change in the future.

## Server part overview

This is the server part for the Karps project. It implement a [gRPC server]() on top of Spark and
serves requests to evaluate graphs of computations. Users should not build graphs themselves and
are strongly encouraged to use the [python client]() or the [Haskell client](). Developers can
look at the implementation of the Python client to add support for another language.

## User instructions

To run the server, you need:
 - a distribution of Spark >= 2.1
 - the karps compiler in you PATH. If you are using MacOs or Linux, the easiest is to download the
 latest prebuilt version following the [instructions here]().

The simplest way to run the server is to use the published Spark package:

## Developer instructions

The spark package has been tested with Spark 2.0, Spark 2.1 and Spark 2.2. Due to some bugs
in Spark 2.0, using Spark 2.1 is strongly recommended.

```
./build/sbt ks_testing/assembly && $SPARK_HOME/bin/spark-submit \
    ./target/testing/scala-2.11/ks_testing-assembly-0.2.0.jar --name karps-server\
     --class org.karps.Boot --master "local[1]" -v
```


Modifying the .proto files. These files are maintained in a separate project. Here are some steps to update the interface (from the base directory of karps-haskell)

```bash
rm -r haskell/src/Proto
protoc --plugin=protoc-gen-haskell=`which proto-lens-protoc`     --haskell_out=./haskell/src -I ./src/main/protobuf ./src/main/protobuf/karps/proto/*.proto ./src/main/protobuf/tensorflow/core/framework/*.proto
```

```bash
rm -r haskell/src/Proto
protoc --plugin=protoc-gen-haskell=./haskell/.stack-work/install/x86_64-osx/lts-11.15/8.2.2/bin/proto-lens-protoc     --haskell_out=./haskell/src -I ./src/main/protobuf ./src/main/protobuf/karps/proto/*.proto ./src/main/protobuf/tensorflow/core/framework/*.proto
```
