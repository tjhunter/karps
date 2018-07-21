# This is the main makefile from which the different targets are built

# The main targets for the users

karps-py:
	echo "karps-py"
	

karps-spark:
	echo "karps-spark"

dev-clean:
	rm -f lib/karps-eta.jar
	rm -rf haskell/src/Proto
	cd eta && etlas clean

# The development targets

protos:
	echo "updating the proto"

eta: lib/karps-eta.jar

haskell/src/Proto:
	echo "proto"
	protoc --plugin=protoc-gen-haskell=`which proto-lens-protoc`     --haskell_out=./haskell/src -I ./src/main/protobuf ./src/main/protobuf/karps/proto/*.proto ./src/main/protobuf/tensorflow/core/framework/*.proto


lib/karps-eta.jar:  haskell/src/Proto haskell/src
	echo "recompiling karps-eta"
	cd eta && etlas build
	cp eta/dist/build/eta-0.8.0.3/karps-eta-0.1.0.0/build/karps-eta-0.1.0.0-inplace.jar lib/karps-eta.jar

dist/karps-spark.jar:
	sbt ks_testing/assembly
	
