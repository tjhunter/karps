# Karps-Haskell - Haskell bindings for Spark Datasets and Dataframes

The Haskell side of the [Karps project](). This repository contains:

- a client written in Haskell that sends pipelines to Spark for execution.

- an optimizing compiler that takes high-level graphs of computations and translates them into
  lower-level, simpler operations. In addition to type checking, this compiler makes a number of
   whole-program optimization and verification.

There is also a separate set of utilities to visualize such pipelines using
Jupyter notebooks and IHaskell.

This is a preview, the API may (will) change in the future.

Karps can also take advantage of the [Haskell kernel for Jupyter](https://github.com/gibiansky/IHaskell), which provides a better user
experience and comes with beautiful introspection tools courtesy of the
[TensorBoard server](https://www.tensorflow.org/how_tos/summaries_and_tensorboard/). Using
Tensorboard, you can visualize, drill down, introspect the graph of computations:

![image](https://github.com/krapsh/kraps-haskell/raw/master/notebooks/ihaskell-tensorboard.png)


## Examples.

Some notebooks that showcase the current capabilities are in the `notebooks`
directory. Some prerendered versions are also available. Chrome seems to provide
the best experience when playing interactively with the visualizations.

  - [Intro](https://rawgit.com/krapsh/kraps-haskell/master/notebooks/rendered/00_Intro.html)

  - [Datasets and observables](https://rawgit.com/krapsh/kraps-haskell/master/notebooks/rendered/01_Datasets_Dataframes_Observable_DynObservable.html)

  - [Organizing workflows with paths](https://rawgit.com/krapsh/kraps-haskell/master/notebooks/rendered/02_Organizing_workflows.html)

  - [Caching data](https://rawgit.com/krapsh/kraps-haskell/master/notebooks/rendered/03_Caching_data.html)

  - [Column operations](https://rawgit.com/krapsh/kraps-haskell/master/notebooks/rendered/06_Column_operations.html)

## Installation (for users)


_Connecting the Karps-Haskell client_ All the integration tests should be able
to connect to the server and execute some Spark commands:

```sh
stack build
stack test
```

You are now all set to run your first interactive program:

```sh
stack ghci
```

```haskell
import Spark.Core.Dataset
import Spark.Core.Context
import Spark.Core.Functions
let ds = dataset ([1 ,2, 3, 4]::[Int])
let c = count ds

createSparkSessionDef defaultConf
mycount <- exec1Def c
```

## Installation (GUI, for users)

IHaskell can be challenging to install, so a docker installation script is provided. You will need to install [Docker](https://www.docker.com/) on your computer to run Karps with IHaskell.

In the project directory, run:

```bash
docker build -t ihaskell-karps .
docker run -it --volume $(pwd)/notebooks:/karps/notebooks \
  --publish 8888:8888  ihaskell-karps
```

The `notebooks` directory contains some example notebooks that you can run.

Note that it still requires a running Spark server somewhere else: the docker
container only runs the Haskell part.

__MacOS users__ When running Docker with OSX, you may need to tell Docker how
to communicate from inside a container to the local machine (if you run Spark
outside Docker). Here is a command to launch Docker with the appropriate options:

```bash
docker run -it --volume $(pwd)/notebooks:/karps/notebooks \
  --publish 8888:8888 --add-host="localhost:10.0.2.2" ihaskell-karps
```

__Standalone linux installation__ The author cannot support the vagaries of
operating systems, especially when involving IHaskell, but here is a setup that
has shown some success:

In Ubuntu 16.04, install all the requirements of IHaskell (libgmp3-dev ghc ipython cabal-install, etc.)

In the `kraps-haskell directory`, run the following commands:

```bash
export STACK_YAML=$PWD/stack-ihaskell.yaml
stack setup 7.10.2
# This step may be required, depending on your version of stack.
# You will see it if you encounter some binary link issues.
stack exec -- ghc-pkg unregister cryptonite --force

stack update
stack install ipython-kernel-0.8.3.0
stack install ihaskell-0.8.3.0
stack install ihaskell-blaze-0.3.0.0
stack install ihaskell-basic-0.3.0.0
stack install

ihaskell install --stack
stack exec --allow-different-user -- jupyter notebook --NotebookApp.port=8888 '--NotebookApp.ip=*' --NotebookApp.notebook_dir=$PWD
```

## Status

This project has so far focused on solving the most challenging issues, at the
expense of breadth and functionality. That being said, the basic building blocks of
Spark are here:
 - dataframes, datasets and observables (the results of `collect`)
 - basic data types: ints, strings, arrays, structures (both nullable and strict)
 - basic arithmetic operators on columns of data
 - converting between the typed and untyped operations
 - grouping, joining

You can take a look at the notebooks in the `notebooks` directory to see what is
possible currently.

What is missing? A lot of things. In particular, users will most probably miss:
 - an input interface. The only way to use the bindings is currently to pass a list of data.
 - broadcasting observables (scalar * col). This one is interesting and is probably the next piece.
 - setting the number of partitions of the data

## Contributions

Contributions are most welcome. This is the author's _first_ Haskell project, so
all suggestions regarding style, idiomatic code, etc. will be gladly accepted.
Also, if someone wants to setup a style checker, it will be really helpful.

## Theory

The API and design goals are slightly more general than Spark's. A more thorough
explanation can be found in the `INTRO.md` file.

## Developer tools

Modifying the .proto files. These files are maintained in a separate project. Here are some steps to update the interface (from the base directory of karps-haskell)

```bash
rm -r src/Proto
protoc --plugin=protoc-gen-haskell=`which proto-lens-protoc`     --haskell_out=src/ -I $KARPS/src/main/protobuf $KARPS/src/main/protobuf/karps/proto/*.proto $KARPS/src/main/protobuf/tensorflow/core/framework/*.proto
```
