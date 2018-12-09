"""
Python model "BusinessStructures.py"
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
    'TIME':
    'time',
    'Time':
    'time',
    'Actual Growth Rate':
    'actual_growth_rate',
    'Business Construction':
    'business_construction',
    'Business Demolition':
    'business_demolition',
    'Business Structures':
    'business_structures',
    'Demolition Fraction':
    'demolition_fraction',
    'Effect of Land Fraction Occupied on Growth Rate':
    'effect_of_land_fraction_occupied_on_growth_rate',
    'Initial Structures':
    'initial_structures',
    'Land Fraction Occupied':
    'land_fraction_occupied',
    'Land Required Per Business':
    'land_required_per_business',
    'Normal Growth Rate':
    'normal_growth_rate',
    'Total Available Land':
    'total_available_land',
    'FINAL TIME':
    'final_time',
    'INITIAL TIME':
    'initial_time',
    'SAVEPER':
    'saveper',
    'TIME STEP':
    'time_step'
}

__pysd_version__ = "0.9.0"


@cache('step')
def actual_growth_rate():
    """
    Real Name: b'Actual Growth Rate'
    Original Eqn: b'Normal Growth Rate*Effect of Land Fraction Occupied on Growth Rate'
    Units: b'1/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return normal_growth_rate() * effect_of_land_fraction_occupied_on_growth_rate()


@cache('step')
def business_construction():
    """
    Real Name: b'Business Construction'
    Original Eqn: b'Actual Growth Rate*Business Structures'
    Units: b'structure/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return actual_growth_rate() * business_structures()


@cache('step')
def business_demolition():
    """
    Real Name: b'Business Demolition'
    Original Eqn: b'Business Structures*Demolition Fraction'
    Units: b'structure/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return business_structures() * demolition_fraction()


@cache('step')
def business_structures():
    """
    Real Name: b'Business Structures'
    Original Eqn: b'INTEG ( Business Construction-Business Demolition, Initial Structures)'
    Units: b'structure'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_business_structures()


@cache('run')
def demolition_fraction():
    """
    Real Name: b'Demolition Fraction'
    Original Eqn: b'0.01'
    Units: b'1/Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.01


@cache('step')
def effect_of_land_fraction_occupied_on_growth_rate():
    """
    Real Name: b'Effect of Land Fraction Occupied on Growth Rate'
    Original Eqn: b'1-Land Fraction Occupied'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 - land_fraction_occupied()


@cache('run')
def initial_structures():
    """
    Real Name: b'Initial Structures'
    Original Eqn: b'1000'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1000


@cache('step')
def land_fraction_occupied():
    """
    Real Name: b'Land Fraction Occupied'
    Original Eqn: b'Business Structures*Land Required Per Business/Total Available Land'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return business_structures() * land_required_per_business() / total_available_land()


@cache('run')
def land_required_per_business():
    """
    Real Name: b'Land Required Per Business'
    Original Eqn: b'0.2'
    Units: b'sqkm/structure'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.2


@cache('run')
def normal_growth_rate():
    """
    Real Name: b'Normal Growth Rate'
    Original Eqn: b'0.13'
    Units: b'1/Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.13


@cache('run')
def total_available_land():
    """
    Real Name: b'Total Available Land'
    Original Eqn: b'10000'
    Units: b'sqkm'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 10000


@cache('run')
def final_time():
    """
    Real Name: b'FINAL TIME'
    Original Eqn: b'100'
    Units: b'Year'
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
    Units: b'Year'
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


integ_business_structures = functions.Integ(
    lambda: business_construction() - business_demolition(), lambda: initial_structures())
