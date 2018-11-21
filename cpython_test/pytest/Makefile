stack build
stack ghc -- -c -dynamic -fPIC src/Lib.hs 
stack ghc -- -c -dynamic -fPIC src/wrapper.c
stack ghc --package pytest -- -o _mytest.so -shared -dynamic -fPIC src/Lib.o -lHSrts-ghc8.4.4

rm _mytest.so
rm src/*hi
rm src/*.o

