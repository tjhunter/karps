from ctypes import *
import ctypes

lib = cdll.LoadLibrary('./_mytest.so')
hs_init = getattr(lib, "hs_init")
hs_exit = getattr(lib, "hs_exit")

hs_init(0,0)

f = getattr(lib, "fibonacci_hs")
CHARP = ctypes.POINTER(ctypes.c_char)

def expose_fun(fname):
  fun = getattr(lib, fname)
  fun.restype = CHARP

  def wrapper(bs):
    len_bs = len(bs)
    t = ctypes.c_char * len_bs
    ba_in = bytearray(bs)
    buff_in = t.from_buffer(ba_in)
    out_len_c = ctypes.c_int32()
    out_ptr = fun(len_bs, buff_in, byref(out_len_c))
    out_len = int(out_len_c.value)
    ptr = ctypes.cast(out_ptr, CHARP)
    out_bs = bytearray(out_ptr[:out_len])
    return out_bs
  return wrapper

input_hs = getattr(lib, "input_hs")
input_hs.restype = CHARP

my_transform1 = expose_fun("my_transform1")


print("f(10)", f(10))


bs = "a汉字".encode("utf-8")

len_bs = len(bs)
t = ctypes.c_char * len_bs
ba_in = bytearray(bs)
buff_in = t.from_buffer(ba_in)
out_len_c = ctypes.c_int32()
out_ptr = input_hs(len_bs, buff_in, byref(out_len_c))
out_len = int(out_len_c.value)
print("out_len:after", out_len)
print("out_ptr", out_ptr, type(out_ptr))
ptr = ctypes.cast(out_ptr, CHARP)
out_bs = bytearray(out_ptr[:out_len])
out_s = out_bs.decode("utf-8")
print("ptr",ptr)
#print(ptr[0], type(ptr[1]))
#print("ptr",ptr[:out_len])
print("out_s",out_s)

out = my_transform1(bs)
print(out.decode("utf-8"))

# ret_type = ctypes.POINTER(ctypes.c_char * out_len)
# out_arr = ctypes.cast(out_ptr, ret_type)
# print("out_arr", out_arr)
# out_bs = bytes(out_arr)
# print("out_bs", out_bs)
# out_s = out_bs.decode("utf-8")
# print("out_s", out_s)
