# This is the main makefile from which the different targets are built

# The main targets for the users

karps-py: haskell2/src/Proto python/karps2/c_core/karps_c.so
	echo "karps-py"
	

dev-clean:
	rm -rf haskell2/src/Proto

# The development targets

protos:
	echo "updating the proto"

haskell2/src/Proto:
	echo "proto"
	protoc --plugin=protoc-gen-haskell=`which proto-lens-protoc`     --haskell_out=./haskell2/src -I ./protobuf ./protobuf/karps/proto/*.proto ./protobuf/tensorflow/core/framework/*.proto

python/karps2/c_core/karps_c.so:
	cd haskell2 && stack build
	cd haskell2 && stack ghc -- -c -dynamic -fPIC src/Lib.hs 
	cd haskell2 && stack ghc --package pytest -- -o karps_c.so -shared -dynamic -fPIC src/Lib.o -lHSrts-ghc8.4.4
	mv haskell2/karps_c.so python/karps2/c_core/karps_c.so




