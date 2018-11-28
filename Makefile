# This is the main makefile from which the different targets are built

# The main targets for the users

karps: protos python/karps2/c_core/karps_c.so
	echo "karps-py"
	

clean:
	rm -f haskell2/src/Lib.hi
	rm -f haskell2/src/Lib.o
	rm -f haskell2/src/Lib_stub.h
	rm -f python/karps2/c_core/karps_c.so


dev-clean: clean
	rm -rf haskell2/src/Proto
	rm -rf python/karps2/proto/karps
	rm -rf python/karps2/proto/tensorflow
	touch python/karps2/proto/__init__.py
	touch Makefile

# The development targets

protos: haskell2/src/Proto python/karps2/proto/karps
	echo "updating the proto"

haskell2/src/Proto:
	protoc --plugin=protoc-gen-haskell=`which proto-lens-protoc`     --haskell_out=./haskell2/src -I ./protobuf ./protobuf/karps/proto/*.proto ./protobuf/tensorflow/core/framework/*.proto

python/karps2/proto/karps:
	mkdir -p python/karps2/proto/
	protoc --python_out=python/karps2/proto/ --proto_path=./protobuf -I ./protobuf ./protobuf/karps/proto/*.proto ./protobuf/tensorflow/core/framework/*.proto

python/karps2/c_core/karps_c.so: haskell2/src/Proto
	cd haskell2 && stack build
	cd haskell2 && stack ghc -- -XScopedTypeVariables -XFlexibleContexts -XMultiParamTypeClasses -XOverloadedStrings -c -dynamic -fPIC src/Lib.hs 
	cd haskell2 && stack ghc --package karps -- -o karps_c.so -shared -dynamic -fPIC src/Lib.o -lHSrts-ghc8.4.4
	mv haskell2/karps_c.so python/karps2/c_core/karps_c.so




