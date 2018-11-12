"""
Python model "SIR.py"
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
    'Contact Rate': 'contact_rate',
    'Infected': 'infected',
    'Infectivity': 'infectivity',
    'IR': 'ir',
    'Net Flow': 'net_flow',
    'R Delay': 'r_delay',
    'R0': 'r0',
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


@cache('run')
def contact_rate():
    """
    Real Name: b'Contact Rate'
    Original Eqn: b'4'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 4


@cache('step')
def infected():
    """
    Real Name: b'Infected'
    Original Eqn: b'INTEG ( IR-RR, 1)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_infected()


@cache('run')
def infectivity():
    """
    Real Name: b'Infectivity'
    Original Eqn: b'0.25'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.25


@cache('step')
def ir():
    """
    Real Name: b'IR'
    Original Eqn: b'Contact Rate*Susceptible*(Infected/Total Population)*Infectivity'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return contact_rate() * susceptible() * (infected() / total_population()) * infectivity()


@cache('step')
def net_flow():
    """
    Real Name: b'Net Flow'
    Original Eqn: b'IR-RR'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return ir() - rr()


@cache('run')
def r_delay():
    """
    Real Name: b'R Delay'
    Original Eqn: b'2'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 2


@cache('step')
def r0():
    """
    Real Name: b'R0'
    Original Eqn: b'Contact Rate*Infectivity*R Delay'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return contact_rate() * infectivity() * r_delay()


@cache('step')
def recovered():
    """
    Real Name: b'Recovered'
    Original Eqn: b'INTEG ( RR, 0)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_recovered()


@cache('step')
def rr():
    """
    Real Name: b'RR'
    Original Eqn: b'Infected/R Delay'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return infected() / r_delay()


@cache('step')
def susceptible():
    """
    Real Name: b'Susceptible'
    Original Eqn: b'INTEG ( -IR, 9999)'
    Units: b''
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
    Units: b''
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
    Original Eqn: b'0.0078125'
    Units: b'Month'
    Limits: (0.0, None)
    Type: constant

    b'The time step for the simulation.'
    """
    return 0.0078125


integ_infected = functions.Integ(lambda: ir() - rr(), lambda: 1)

integ_recovered = functions.Integ(lambda: rr(), lambda: 0)

integ_susceptible = functions.Integ(lambda: -ir(), lambda: 9999)
