"""
Python model "Population.py"
Translated using PySD version 0.9.0
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
    'Growth Fraction': 'growth_fraction',
    'Initial Population': 'initial_population',
    'Number Added': 'number_added',
    'Population': 'population',
    'FINAL TIME': 'final_time',
    'INITIAL TIME': 'initial_time',
    'SAVEPER': 'saveper',
    'TIME STEP': 'time_step'
}

__pysd_version__ = "0.9.0"


@cache('run')
def growth_fraction():
    """
    Real Name: b'Growth Fraction'
    Original Eqn: b'0.015'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.015


@cache('run')
def initial_population():
    """
    Real Name: b'Initial Population'
    Original Eqn: b'3000'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 3000


@cache('step')
def number_added():
    """
    Real Name: b'Number Added'
    Original Eqn: b'Growth Fraction*Population'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return growth_fraction() * population()


@cache('step')
def population():
    """
    Real Name: b'Population'
    Original Eqn: b'INTEG ( Number Added, Initial Population)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_population()


@cache('run')
def final_time():
    """
    Real Name: b'FINAL TIME'
    Original Eqn: b'2010'
    Units: b'Year'
    Limits: (None, None)
    Type: constant

    b'The final time for the simulation.'
    """
    return 2010


@cache('run')
def initial_time():
    """
    Real Name: b'INITIAL TIME'
    Original Eqn: b'1960'
    Units: b'Year'
    Limits: (None, None)
    Type: constant

    b'The initial time for the simulation.'
    """
    return 1960


@cache('step')
def saveper():
    """
    Real Name: b'SAVEPER'
    Original Eqn: b'TIME STEP'
    Units: b'Year'
    Limits: (0.0, None)
    Type: component

    b'The frequency with which output is stored.'
    """
    return time_step()


@cache('run')
def time_step():
    """
    Real Name: b'TIME STEP'
    Original Eqn: b'0.125'
    Units: b'Year'
    Limits: (0.0, None)
    Type: constant

    b'The time step for the simulation.'
    """
    return 0.125


integ_population = functions.Integ(lambda: number_added(), lambda: initial_population())
