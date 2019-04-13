"""
Python model "01 SIR Aggregate.py"
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
    'Beta': 'beta',
    'DelayI': 'delayi',
    'R0': 'r0',
    'Infected': 'infected',
    'IR': 'ir',
    'Lambda': 'lambda_1',
    'Recovered': 'recovered',
    'RR': 'rr',
    'Susceptible': 'susceptible',
    'Total Population': 'total_population',
    'FINAL TIME': 'final_time',
    'INITIAL TIME': 'initial_time',
    'SAVEPER': 'saveper',
    'TIME STEP': 'time_step'
}

__pysd_version__ = "0.9.0"


@cache('step')
def beta():
    """
    Real Name: b'Beta'
    Original Eqn: b'R0/(DelayI*Total Population)'
    Units: b'1/(Person*Day)'
    Limits: (None, None)
    Type: component

    b''
    """
    return r0() / (delayi() * total_population())


@cache('run')
def delayi():
    """
    Real Name: b'DelayI'
    Original Eqn: b'2'
    Units: b'Day'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 2


@cache('run')
def r0():
    """
    Real Name: b'R0'
    Original Eqn: b'1.3'
    Units: b'Person/Person/Day'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1.3


@cache('step')
def infected():
    """
    Real Name: b'Infected'
    Original Eqn: b'INTEG ( IR-RR, 1)'
    Units: b'Person'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_infected()


@cache('step')
def ir():
    """
    Real Name: b'IR'
    Original Eqn: b'Lambda*Susceptible'
    Units: b'Person/Day'
    Limits: (None, None)
    Type: component

    b''
    """
    return lambda_1() * susceptible()


@cache('step')
def lambda_1():
    """
    Real Name: b'Lambda'
    Original Eqn: b'Beta*Infected'
    Units: b'1/Day'
    Limits: (None, None)
    Type: component

    b''
    """
    return beta() * infected()


@cache('step')
def recovered():
    """
    Real Name: b'Recovered'
    Original Eqn: b'INTEG ( RR, 0)'
    Units: b'Person'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_recovered()


@cache('step')
def rr():
    """
    Real Name: b'RR'
    Original Eqn: b'Infected/DelayI'
    Units: b'Person/Day'
    Limits: (None, None)
    Type: component

    b''
    """
    return infected() / delayi()


@cache('step')
def susceptible():
    """
    Real Name: b'Susceptible'
    Original Eqn: b'INTEG ( -IR, 9999)'
    Units: b'Person'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_susceptible()


@cache('run')
def total_population():
    """
    Real Name: b'Total Population'
    Original Eqn: b'10000'
    Units: b'Person'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 10000


@cache('run')
def final_time():
    """
    Real Name: b'FINAL TIME'
    Original Eqn: b'50'
    Units: b'Day'
    Limits: (None, None)
    Type: constant

    b'The final time for the simulation.'
    """
    return 50


@cache('run')
def initial_time():
    """
    Real Name: b'INITIAL TIME'
    Original Eqn: b'0'
    Units: b'Day'
    Limits: (None, None)
    Type: constant

    b'The initial time for the simulation.'
    """
    return 0


@cache('run')
def saveper():
    """
    Real Name: b'SAVEPER'
    Original Eqn: b'0.5'
    Units: b'Day'
    Limits: (0.0, None)
    Type: constant

    b'The frequency with which output is stored.'
    """
    return 0.5


@cache('run')
def time_step():
    """
    Real Name: b'TIME STEP'
    Original Eqn: b'0.0625'
    Units: b'Day'
    Limits: (0.0, None)
    Type: constant

    b'The time step for the simulation.'
    """
    return 0.0625


integ_infected = functions.Integ(lambda: ir() - rr(), lambda: 1)

integ_recovered = functions.Integ(lambda: rr(), lambda: 0)

integ_susceptible = functions.Integ(lambda: -ir(), lambda: 9999)
