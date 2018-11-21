from ctypes import *

lib = cdll.LoadLibrary('./_mytest.so')
hs_init = getattr(lib, "hs_init")
hs_exit = getattr(lib, "hs_exit")

hs_init(0,0)

f = getattr(lib, "fibonacci_hs")
f(10)
