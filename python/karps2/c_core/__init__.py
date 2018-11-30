"""
The C library that does most of the work.
"""

import ctypes
from ctypes import cdll, byref
import logging
import os

from ..proto import api_internal_pb2 as api


__all__ = ['my_transform1', 'build_node_c', 'compile_graph_c']

logger = logging.getLogger('karps')


def init_module():
    current_dir = os.path.dirname(__file__)
    c_blob = os.path.join(current_dir, 'karps_c.so')
    logger.debug("Loading the C library")
    lib = cdll.LoadLibrary(c_blob)
    hs_init = getattr(lib, "hs_init")
    hs_exit = getattr(lib, "hs_exit")

    hs_init(0, 0)
    return lib


_lib = init_module()
f = getattr(_lib, "fibonacci_hs")


def expose_fun(fname, builder):
    fun = getattr(_lib, fname)
    CHARP = ctypes.POINTER(ctypes.c_char)

    fun.restype = CHARP

    def wrapper(obj):
        if isinstance(obj, bytes):
            bs = obj
        else:
            bs = obj.SerializeToString()
        len_bs = len(bs)
        t = ctypes.c_char * len_bs
        ba_in = bytearray(bs)
        buff_in = t.from_buffer(ba_in)
        out_len_c = ctypes.c_int32()
        out_ptr = fun(len_bs, buff_in, byref(out_len_c))
        out_len = int(out_len_c.value)
        out_bs = bytearray(out_ptr[:out_len])
        if builder:
            resp = builder()
            resp.ParseFromString(out_bs)
            return resp
        return out_bs
    return wrapper


my_transform1 = expose_fun("my_transform1", None)

build_node_c = expose_fun("build_node", api.NodeBuilderResponse)

compile_graph_c = expose_fun("compile_graph", api.GraphTransformResponse)
