# -*- coding: utf-8 -*-

from bnz.defs cimport *
from bnz.coordinates.grid cimport GridData
from bnz.coordinates.coord cimport GridCoord

cdef class BnzIntegr

# grid BC function pointer
ctypedef void (*GridBCFunc)(GridData,GridCoord*, BnzIntegr, int1d)
ctypedef void (*PackFunc)(GridData,GridCoord*, int1d, real1d, int,int)
ctypedef void (*UnpackFunc)(GridData,GridCoord*, int1d, real1d, int,int)


cdef class GridBC:

  # BC flags
  # 0 - periodic; 1 - outflow; 2 - reflective; 3 - user-defined
  cdef int bc_flags[3][2]

  # array of grid BC function pointers
  cdef GridBCFunc grid_bc_funcs[3][2]

  # exchange BC for currents / particle feedback
  cdef GridBCFunc exch_bc_funcs[3][2]

  cdef real2d sendbuf, recvbuf    # send/receive buffers for boundary conditions
  cdef long recvbuf_size, sendbuf_size   # buffer sizes

  cdef void apply_grid_bc(self, GridData,GridCoord*, BnzIntegr, int1d)
  IF MHDPIC:
    cdef void apply_exch_bc(self, GridData,GridCoord*, BnzIntegr, int1d)
