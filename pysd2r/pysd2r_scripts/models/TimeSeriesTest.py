"""
Python model "TimeSeriesTest.py"
Translated using PySD version 0.10.0
"""
from __future__ import division
import numpy as np
from pysd import utils
import xarray as xr

from pysd.py_backend.functions import cache
from pysd.py_backend import functions

_subscript_dict = {}

_namespace = {
    'TIME': 'time',
    'Time': 'time',
    'Inflow': 'inflow',
    'Stock': 'stock',
    'TS': 'ts',
    'FINAL TIME': 'final_time',
    'INITIAL TIME': 'initial_time',
    'SAVEPER': 'saveper',
    'TIME STEP': 'time_step'
}

__pysd_version__ = "0.10.0"

__data = {'scope': None, 'time': lambda: 0}


def _init_outer_references(data):
    for key in data:
        __data[key] = data[key]


def time():
    return __data['time']()


@cache('step')
def inflow():
    """
    Real Name: b'Inflow'
    Original Eqn: b'A FUNCTION OF( TS)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return functions.incomplete()


@cache('step')
def stock():
    """
    Real Name: b'Stock'
    Original Eqn: b'A FUNCTION OF( Inflow)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return functions.incomplete()


@cache('step')
def ts():
    """
    Real Name: b'TS'
    Original Eqn: b'A FUNCTION OF( )'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return functions.incomplete()


@cache('run')
def final_time():
    """
    Real Name: b'FINAL TIME'
    Original Eqn: b'100'
    Units: b'Month'
    Limits: (None, None)
    Type: constant

    b'The final time for the simulation.'
    """
    return 100


@cache('run')
def initial_time():
    """
    Real Name: b'INITIAL TIME'
    Original Eqn: b'0'
    Units: b'Month'
    Limits: (None, None)
    Type: constant

    b'The initial time for the simulation.'
    """
    return 0


@cache('step')
def saveper():
    """
    Real Name: b'SAVEPER'
    Original Eqn: b'TIME STEP'
    Units: b'Month'
    Limits: (0.0, None)
    Type: component

    b'The frequency with which output is stored.'
    """
    return time_step()


@cache('run')
def time_step():
    """
    Real Name: b'TIME STEP'
    Original Eqn: b'1'
    Units: b'Month'
    Limits: (0.0, None)
    Type: constant

    b'The time step for the simulation.'
    """
    return 1
