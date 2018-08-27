"""
Python model "Buildings LI All.py"
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
    'ABS B0 Impact': 'abs_b0_impact',
    'ABS B1 Impact': 'abs_b1_impact',
    'ABS R1 Impact': 'abs_r1_impact',
    'B0 Derivative': 'b0_derivative',
    'B0 Identifier': 'b0_identifier',
    'B0 Impact': 'b0_impact',
    'B1 Derivative': 'b1_derivative',
    'B1 Identifier': 'b1_identifier',
    'B1 Impact': 'b1_impact',
    'Business Construction': 'business_construction',
    'Business Demolition': 'business_demolition',
    'Business Structures': 'business_structures',
    'Land Area': 'land_area',
    'Land Fraction Available': 'land_fraction_available',
    'Land Fraction Occupied': 'land_fraction_occupied',
    'Land Per Business Structure': 'land_per_business_structure',
    'Normal Business Construction Rate': 'normal_business_construction_rate',
    'Normal Business Demolition Rate': 'normal_business_demolition_rate',
    'R1 Derivative': 'r1_derivative',
    'R1 Identifier': 'r1_identifier',
    'R1 Impact': 'r1_impact',
    'Structures Rate of Change': 'structures_rate_of_change',
    'Total Impact Balancing': 'total_impact_balancing',
    'Total Impact Reinforcing': 'total_impact_reinforcing',
    'FINAL TIME': 'final_time',
    'INITIAL TIME': 'initial_time',
    'SAVEPER': 'saveper',
    'TIME STEP': 'time_step'
}

__pysd_version__ = "0.9.0"


@cache('step')
def abs_b0_impact():
    """
    Real Name: b'ABS B0 Impact'
    Original Eqn: b'abs(B0 Impact)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return abs(b0_impact())


@cache('step')
def abs_b1_impact():
    """
    Real Name: b'ABS B1 Impact'
    Original Eqn: b'abs(B1 Impact)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return abs(b1_impact())


@cache('step')
def abs_r1_impact():
    """
    Real Name: b'ABS R1 Impact'
    Original Eqn: b'abs(R1 Impact)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return abs(r1_impact())


@cache('step')
def b0_derivative():
    """
    Real Name: b'B0 Derivative'
    Original Eqn: b'(B0 Identifier-smooth(B0 Identifier,TIME STEP))/TIME STEP'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return (b0_identifier() - smooth_b0_identifier_time_step_b0_identifier_1()) / time_step()


@cache('step')
def b0_identifier():
    """
    Real Name: b'B0 Identifier'
    Original Eqn: b'Business Structures*Normal Business Demolition Rate'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return business_structures() * normal_business_demolition_rate()


@cache('step')
def b0_impact():
    """
    Real Name: b'B0 Impact'
    Original Eqn: b'-1*B0 Derivative/Structures Rate of Change'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return -1 * b0_derivative() / structures_rate_of_change()


@cache('step')
def b1_derivative():
    """
    Real Name: b'B1 Derivative'
    Original Eqn: b'(B1 Identifier-smooth(B1 Identifier,TIME STEP))/TIME STEP'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return (b1_identifier() - smooth_b1_identifier_time_step_b1_identifier_1()) / time_step()


@cache('step')
def b1_identifier():
    """
    Real Name: b'B1 Identifier'
    Original Eqn: b'Land Fraction Available'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return land_fraction_available()


@cache('step')
def b1_impact():
    """
    Real Name: b'B1 Impact'
    Original Eqn: b'R1 Identifier*B1 Derivative/Structures Rate of Change'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return r1_identifier() * b1_derivative() / structures_rate_of_change()


@cache('step')
def business_construction():
    """
    Real Name: b'Business Construction'
    Original Eqn: b'R1 Identifier*B1 Identifier'
    Units: b'structures/year'
    Limits: (None, None)
    Type: component

    b''
    """
    return r1_identifier() * b1_identifier()


@cache('step')
def business_demolition():
    """
    Real Name: b'Business Demolition'
    Original Eqn: b'B0 Identifier'
    Units: b'structures/year'
    Limits: (None, None)
    Type: component

    b''
    """
    return b0_identifier()


@cache('step')
def business_structures():
    """
    Real Name: b'Business Structures'
    Original Eqn: b'INTEG ( Business Construction-Business Demolition, 200)'
    Units: b'structures'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_business_structures()


@cache('run')
def land_area():
    """
    Real Name: b'Land Area'
    Original Eqn: b'1000'
    Units: b'km*km'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1000


@cache('step')
def land_fraction_available():
    """
    Real Name: b'Land Fraction Available'
    Original Eqn: b'1-Land Fraction Occupied'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 - land_fraction_occupied()


@cache('step')
def land_fraction_occupied():
    """
    Real Name: b'Land Fraction Occupied'
    Original Eqn: b'Business Structures*Land Per Business Structure/Land Area'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return business_structures() * land_per_business_structure() / land_area()


@cache('run')
def land_per_business_structure():
    """
    Real Name: b'Land Per Business Structure'
    Original Eqn: b'0.2'
    Units: b'km*km/structures'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.2


@cache('run')
def normal_business_construction_rate():
    """
    Real Name: b'Normal Business Construction Rate'
    Original Eqn: b'0.1'
    Units: b'1/year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.1


@cache('run')
def normal_business_demolition_rate():
    """
    Real Name: b'Normal Business Demolition Rate'
    Original Eqn: b'0.05'
    Units: b'1/year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.05


@cache('step')
def r1_derivative():
    """
    Real Name: b'R1 Derivative'
    Original Eqn: b'(R1 Identifier-smooth(R1 Identifier,TIME STEP))/TIME STEP'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return (r1_identifier() - smooth_r1_identifier_time_step_r1_identifier_1()) / time_step()


@cache('step')
def r1_identifier():
    """
    Real Name: b'R1 Identifier'
    Original Eqn: b'Business Structures*Normal Business Construction Rate'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return business_structures() * normal_business_construction_rate()


@cache('step')
def r1_impact():
    """
    Real Name: b'R1 Impact'
    Original Eqn: b'B1 Identifier*R1 Derivative/Structures Rate of Change'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return b1_identifier() * r1_derivative() / structures_rate_of_change()


@cache('step')
def structures_rate_of_change():
    """
    Real Name: b'Structures Rate of Change'
    Original Eqn: b'Business Construction-Business Demolition'
    Units: b'structures/year'
    Limits: (None, None)
    Type: component

    b''
    """
    return business_construction() - business_demolition()


@cache('step')
def total_impact_balancing():
    """
    Real Name: b'Total Impact Balancing'
    Original Eqn: b'ABS B0 Impact+ABS B1 Impact'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return abs_b0_impact() + abs_b1_impact()


@cache('step')
def total_impact_reinforcing():
    """
    Real Name: b'Total Impact Reinforcing'
    Original Eqn: b'ABS R1 Impact'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return abs_r1_impact()


@cache('run')
def final_time():
    """
    Real Name: b'FINAL TIME'
    Original Eqn: b'100'
    Units: b'year'
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
    Units: b'year'
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
    Units: b'year'
    Limits: (0.0, None)
    Type: component

    b'The frequency with which output is stored.'
    """
    return time_step()


@cache('run')
def time_step():
    """
    Real Name: b'TIME STEP'
    Original Eqn: b'0.02'
    Units: b'year'
    Limits: (0.0, None)
    Type: constant

    b'The time step for the simulation.'
    """
    return 0.02


smooth_b0_identifier_time_step_b0_identifier_1 = functions.Smooth(
    lambda: b0_identifier(), lambda: time_step(), lambda: b0_identifier(), lambda: 1)

smooth_b1_identifier_time_step_b1_identifier_1 = functions.Smooth(
    lambda: b1_identifier(), lambda: time_step(), lambda: b1_identifier(), lambda: 1)

integ_business_structures = functions.Integ(
    lambda: business_construction() - business_demolition(), lambda: 200)

smooth_r1_identifier_time_step_r1_identifier_1 = functions.Smooth(
    lambda: r1_identifier(), lambda: time_step(), lambda: r1_identifier(), lambda: 1)
