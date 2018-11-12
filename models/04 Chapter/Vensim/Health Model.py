"""
Python model "Health Model.py"
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
    '"Percentage 0-14"': 'percentage_014',
    '"Percentage 15-39"': 'percentage_1539',
    '"Percentage 40-64"': 'percentage_4064',
    '"Percentage 65+"': 'percentage_65',
    'Net Flow Delivery': 'net_flow_delivery',
    'Workyear Ratio': 'workyear_ratio',
    'Productivity Ratio': 'productivity_ratio',
    'Average Delay': 'average_delay',
    'Dependency Ratio': 'dependency_ratio',
    'Productivity': 'productivity',
    '"GPV 65+"': 'gpv_65',
    'Standard Annual Completed Visits': 'standard_annual_completed_visits',
    'D1': 'd1',
    'D2': 'd2',
    'Effect of System Pressure on Productivity': 'effect_of_system_pressure_on_productivity',
    'Effect of System Pressure on Work Year': 'effect_of_system_pressure_on_work_year',
    'Completed Visits': 'completed_visits',
    'Target Completion Time': 'target_completion_time',
    'Extra Demand Flag': 'extra_demand_flag',
    'Productivity Flag': 'productivity_flag',
    'Rate C2 to C3': 'rate_c2_to_c3',
    'Rate C3 to C4': 'rate_c3_to_c4',
    'Workyear Flag': 'workyear_flag',
    'Desired Completed Visits': 'desired_completed_visits',
    'System Pressure': 'system_pressure',
    'Potential Completed Visits': 'potential_completed_visits',
    'Rate C1 to C2': 'rate_c1_to_c2',
    'Workyear': 'workyear',
    'Adjustment for GPs': 'adjustment_for_gps',
    'Adjustment Time': 'adjustment_time',
    'Average Career Duration': 'average_career_duration',
    'Birth Fraction': 'birth_fraction',
    'Births': 'births',
    'CERR': 'cerr',
    'DC': 'dc',
    'Death Fraction': 'death_fraction',
    'Deaths': 'deaths',
    'Desired GPs': 'desired_gps',
    'Desired GPs Per Thousand of Population': 'desired_gps_per_thousand_of_population',
    'Discrepancy': 'discrepancy',
    'Expected Retirement rate': 'expected_retirement_rate',
    'Flows On Flag': 'flows_on_flag',
    'General Practitioners': 'general_practitioners',
    'Standard GP Productivity': 'standard_gp_productivity',
    '"GPV 0-14"': 'gpv_014',
    '"GPV 15-39"': 'gpv_1539',
    '"GPV 40-64"': 'gpv_4064',
    'Patient Visits': 'patient_visits',
    'Patients Being Treated': 'patients_being_treated',
    '"Population Aged 0-14"': 'population_aged_014',
    '"Population Aged 15-39"': 'population_aged_1539',
    '"Population Aged 40-64"': 'population_aged_4064',
    '"Population Aged 65+"': 'population_aged_65',
    'Recruitment Rate': 'recruitment_rate',
    'Standard Work Year': 'standard_work_year',
    'Retirement Rate': 'retirement_rate',
    'Total GP Demand': 'total_gp_demand',
    '"Total GP Visits 0-14"': 'total_gp_visits_014',
    '"Total GP Visits 15-39"': 'total_gp_visits_1539',
    '"Total GP Visits 40-64"': 'total_gp_visits_4064',
    '"Total GP Visits 65+"': 'total_gp_visits_65',
    'Total Population': 'total_population',
    'FINAL TIME': 'final_time',
    'INITIAL TIME': 'initial_time',
    'SAVEPER': 'saveper',
    'TIME STEP': 'time_step'
}

__pysd_version__ = "0.9.0"


@cache('step')
def percentage_014():
    """
    Real Name: b'"Percentage 0-14"'
    Original Eqn: b'100*"Population Aged 0-14"/Total Population'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return 100 * population_aged_014() / total_population()


@cache('step')
def percentage_1539():
    """
    Real Name: b'"Percentage 15-39"'
    Original Eqn: b'100*"Population Aged 15-39"/Total Population'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return 100 * population_aged_1539() / total_population()


@cache('step')
def percentage_4064():
    """
    Real Name: b'"Percentage 40-64"'
    Original Eqn: b'100*"Population Aged 40-64"/Total Population'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return 100 * population_aged_4064() / total_population()


@cache('step')
def percentage_65():
    """
    Real Name: b'"Percentage 65+"'
    Original Eqn: b'100*"Population Aged 65+"/Total Population'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return 100 * population_aged_65() / total_population()


@cache('step')
def net_flow_delivery():
    """
    Real Name: b'Net Flow Delivery'
    Original Eqn: b'Patient Visits-Completed Visits'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return patient_visits() - completed_visits()


@cache('step')
def workyear_ratio():
    """
    Real Name: b'Workyear Ratio'
    Original Eqn: b'Workyear/Standard Work Year'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return workyear() / standard_work_year()


@cache('step')
def productivity_ratio():
    """
    Real Name: b'Productivity Ratio'
    Original Eqn: b'Productivity/Standard GP Productivity'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return productivity() / standard_gp_productivity()


@cache('step')
def average_delay():
    """
    Real Name: b'Average Delay'
    Original Eqn: b'Patients Being Treated/Completed Visits'
    Units: b'Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return patients_being_treated() / completed_visits()


@cache('step')
def dependency_ratio():
    """
    Real Name: b'Dependency Ratio'
    Original Eqn: b'100*("Population Aged 0-14"+"Population Aged 65+")/("Population Aged 15-39"+"Population Aged 40-64"\\\\ )'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return 100 * (population_aged_014() + population_aged_65()) / (
        population_aged_1539() + population_aged_4064())


@cache('step')
def productivity():
    """
    Real Name: b'Productivity'
    Original Eqn: b'IF THEN ELSE(Productivity Flag=1,Effect of System Pressure on Productivity*Standard GP Productivity\\\\ ,Standard GP Productivity)'
    Units: b'Person/Person/Day'
    Limits: (None, None)
    Type: component

    b''
    """
    return functions.if_then_else(
        productivity_flag() == 1,
        effect_of_system_pressure_on_productivity() * standard_gp_productivity(),
        standard_gp_productivity())


@cache('step')
def gpv_65():
    """
    Real Name: b'"GPV 65+"'
    Original Eqn: b'IF THEN ELSE(Extra Demand Flag=1,10+STEP(2,2020),10)'
    Units: b'1/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return functions.if_then_else(extra_demand_flag() == 1, 10 + functions.step(2, 2020), 10)


@cache('step')
def standard_annual_completed_visits():
    """
    Real Name: b'Standard Annual Completed Visits'
    Original Eqn: b'Standard GP Productivity*Standard Work Year*General Practitioners'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return standard_gp_productivity() * standard_work_year() * general_practitioners()


@cache('run')
def d1():
    """
    Real Name: b'D1'
    Original Eqn: b'15'
    Units: b'Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 15


@cache('run')
def d2():
    """
    Real Name: b'D2'
    Original Eqn: b'25'
    Units: b'Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 25


@cache('step')
def effect_of_system_pressure_on_productivity():
    """
    Real Name: b'Effect of System Pressure on Productivity'
    Original Eqn: b'WITH LOOKUP ( System Pressure, ([(0,0)-(2,2)],(0,0.62),(0.2,0.65),(0.4,0.7),(0.6,0.79),(0.8,0.89),(1,1),(1.2,1.14)\\\\ ,(1.4,1.24),(1.6,1.32),(1.8,1.37),(2,1.4) ))'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return functions.lookup(system_pressure(), [0, 0.2, 0.4, 0.6, 0.8, 1, 1.2, 1.4, 1.6, 1.8, 2],
                            [0.62, 0.65, 0.7, 0.79, 0.89, 1, 1.14, 1.24, 1.32, 1.37, 1.4])


@cache('step')
def effect_of_system_pressure_on_work_year():
    """
    Real Name: b'Effect of System Pressure on Work Year'
    Original Eqn: b'WITH LOOKUP ( System Pressure, ([(0,0)-(2.5,1.5)],(0,0.75),(0.25,0.79),(0.5,0.84),(0.75,0.9),(1,1),(1.25,1.09),(1.5\\\\ ,1.17),(1.75,1.23),(2,1.25),(2.25,1.25),(2.5,1.25) ))'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return functions.lookup(system_pressure(),
                            [0, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5],
                            [0.75, 0.79, 0.84, 0.9, 1, 1.09, 1.17, 1.23, 1.25, 1.25, 1.25])


@cache('step')
def completed_visits():
    """
    Real Name: b'Completed Visits'
    Original Eqn: b'min(Desired Completed Visits,Potential Completed Visits)'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return np.minimum(desired_completed_visits(), potential_completed_visits())


@cache('run')
def target_completion_time():
    """
    Real Name: b'Target Completion Time'
    Original Eqn: b'1'
    Units: b'Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('run')
def extra_demand_flag():
    """
    Real Name: b'Extra Demand Flag'
    Original Eqn: b'0'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0


@cache('run')
def productivity_flag():
    """
    Real Name: b'Productivity Flag'
    Original Eqn: b'1'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def rate_c2_to_c3():
    """
    Real Name: b'Rate C2 to C3'
    Original Eqn: b'Flows On Flag*"Population Aged 15-39"/D2'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return flows_on_flag() * population_aged_1539() / d2()


@cache('step')
def rate_c3_to_c4():
    """
    Real Name: b'Rate C3 to C4'
    Original Eqn: b'Flows On Flag*"Population Aged 40-64"/D2'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return flows_on_flag() * population_aged_4064() / d2()


@cache('run')
def workyear_flag():
    """
    Real Name: b'Workyear Flag'
    Original Eqn: b'1'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def desired_completed_visits():
    """
    Real Name: b'Desired Completed Visits'
    Original Eqn: b'Patients Being Treated/Target Completion Time'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return patients_being_treated() / target_completion_time()


@cache('step')
def system_pressure():
    """
    Real Name: b'System Pressure'
    Original Eqn: b'Desired Completed Visits/Standard Annual Completed Visits'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return desired_completed_visits() / standard_annual_completed_visits()


@cache('step')
def potential_completed_visits():
    """
    Real Name: b'Potential Completed Visits'
    Original Eqn: b'General Practitioners*Productivity*Workyear'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return general_practitioners() * productivity() * workyear()


@cache('step')
def rate_c1_to_c2():
    """
    Real Name: b'Rate C1 to C2'
    Original Eqn: b'Flows On Flag*"Population Aged 0-14"/D1'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return flows_on_flag() * population_aged_014() / d1()


@cache('step')
def workyear():
    """
    Real Name: b'Workyear'
    Original Eqn: b'IF THEN ELSE(Workyear Flag=1,Effect of System Pressure on Work Year*Standard Work Year\\\\ ,Standard Work Year)'
    Units: b'Day/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return functions.if_then_else(workyear_flag() == 1,
                                  effect_of_system_pressure_on_work_year() * standard_work_year(),
                                  standard_work_year())


@cache('step')
def adjustment_for_gps():
    """
    Real Name: b'Adjustment for GPs'
    Original Eqn: b'(Desired GPs-General Practitioners)/Adjustment Time'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return (desired_gps() - general_practitioners()) / adjustment_time()


@cache('run')
def adjustment_time():
    """
    Real Name: b'Adjustment Time'
    Original Eqn: b'1'
    Units: b'Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('run')
def average_career_duration():
    """
    Real Name: b'Average Career Duration'
    Original Eqn: b'40'
    Units: b'Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 40


@cache('run')
def birth_fraction():
    """
    Real Name: b'Birth Fraction'
    Original Eqn: b'20/1000'
    Units: b'1/Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 20 / 1000


@cache('step')
def births():
    """
    Real Name: b'Births'
    Original Eqn: b'Total Population*Birth Fraction*Flows On Flag'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return total_population() * birth_fraction() * flows_on_flag()


@cache('step')
def cerr():
    """
    Real Name: b'CERR'
    Original Eqn: b'Discrepancy/DC'
    Units: b'(Person/Year)/(Year)'
    Limits: (None, None)
    Type: component

    b''
    """
    return discrepancy() / dc()


@cache('run')
def dc():
    """
    Real Name: b'DC'
    Original Eqn: b'3'
    Units: b'Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 3


@cache('run')
def death_fraction():
    """
    Real Name: b'Death Fraction'
    Original Eqn: b'7/1000'
    Units: b'1/Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 7 / 1000


@cache('step')
def deaths():
    """
    Real Name: b'Deaths'
    Original Eqn: b'Flows On Flag*Total Population*Death Fraction'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return flows_on_flag() * total_population() * death_fraction()


@cache('step')
def desired_gps():
    """
    Real Name: b'Desired GPs'
    Original Eqn: b'Total Population*Desired GPs Per Thousand of Population'
    Units: b'Person'
    Limits: (None, None)
    Type: component

    b''
    """
    return total_population() * desired_gps_per_thousand_of_population()


@cache('run')
def desired_gps_per_thousand_of_population():
    """
    Real Name: b'Desired GPs Per Thousand of Population'
    Original Eqn: b'0.8/1000'
    Units: b'Person/Person'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.8 / 1000


@cache('step')
def discrepancy():
    """
    Real Name: b'Discrepancy'
    Original Eqn: b'Retirement Rate-Expected Retirement rate'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return retirement_rate() - expected_retirement_rate()


@cache('step')
def expected_retirement_rate():
    """
    Real Name: b'Expected Retirement rate'
    Original Eqn: b'INTEG ( CERR, 100)'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_expected_retirement_rate()


@cache('run')
def flows_on_flag():
    """
    Real Name: b'Flows On Flag'
    Original Eqn: b'1'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def general_practitioners():
    """
    Real Name: b'General Practitioners'
    Original Eqn: b'INTEG ( Recruitment Rate-Retirement Rate, 4000)'
    Units: b'Person'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_general_practitioners()


@cache('run')
def standard_gp_productivity():
    """
    Real Name: b'Standard GP Productivity'
    Original Eqn: b'24'
    Units: b'Person/Person/Day'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 24


@cache('run')
def gpv_014():
    """
    Real Name: b'"GPV 0-14"'
    Original Eqn: b'3'
    Units: b'1/Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 3


@cache('run')
def gpv_1539():
    """
    Real Name: b'"GPV 15-39"'
    Original Eqn: b'4'
    Units: b'1/Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 4


@cache('run')
def gpv_4064():
    """
    Real Name: b'"GPV 40-64"'
    Original Eqn: b'5'
    Units: b'1/Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 5


@cache('step')
def patient_visits():
    """
    Real Name: b'Patient Visits'
    Original Eqn: b'Total GP Demand'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return total_gp_demand()


@cache('step')
def patients_being_treated():
    """
    Real Name: b'Patients Being Treated'
    Original Eqn: b'INTEG ( Patient Visits-Completed Visits, 2.4e+07)'
    Units: b'Person'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_patients_being_treated()


@cache('step')
def population_aged_014():
    """
    Real Name: b'"Population Aged 0-14"'
    Original Eqn: b'INTEG ( Births-Rate C1 to C2, 1e+06)'
    Units: b'Person'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_population_aged_014()


@cache('step')
def population_aged_1539():
    """
    Real Name: b'"Population Aged 15-39"'
    Original Eqn: b'INTEG ( Rate C1 to C2-Rate C2 to C3, 1.5e+06)'
    Units: b'Person'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_population_aged_1539()


@cache('step')
def population_aged_4064():
    """
    Real Name: b'"Population Aged 40-64"'
    Original Eqn: b'INTEG ( Rate C2 to C3-Rate C3 to C4, 2e+06)'
    Units: b'Person'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_population_aged_4064()


@cache('step')
def population_aged_65():
    """
    Real Name: b'"Population Aged 65+"'
    Original Eqn: b'INTEG ( Rate C3 to C4-Deaths, 500000)'
    Units: b'Person'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_population_aged_65()


@cache('step')
def recruitment_rate():
    """
    Real Name: b'Recruitment Rate'
    Original Eqn: b'MAX(0,Expected Retirement rate+Adjustment for GPs)'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return np.maximum(0, expected_retirement_rate() + adjustment_for_gps())


@cache('run')
def standard_work_year():
    """
    Real Name: b'Standard Work Year'
    Original Eqn: b'250'
    Units: b'Day/Year'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 250


@cache('step')
def retirement_rate():
    """
    Real Name: b'Retirement Rate'
    Original Eqn: b'General Practitioners/Average Career Duration'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return general_practitioners() / average_career_duration()


@cache('step')
def total_gp_demand():
    """
    Real Name: b'Total GP Demand'
    Original Eqn: b'"Total GP Visits 0-14"+"Total GP Visits 15-39"+"Total GP Visits 40-64"+"Total GP Visits 65+"'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return total_gp_visits_014() + total_gp_visits_1539() + total_gp_visits_4064(
    ) + total_gp_visits_65()


@cache('step')
def total_gp_visits_014():
    """
    Real Name: b'"Total GP Visits 0-14"'
    Original Eqn: b'"GPV 0-14"*"Population Aged 0-14"'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return gpv_014() * population_aged_014()


@cache('step')
def total_gp_visits_1539():
    """
    Real Name: b'"Total GP Visits 15-39"'
    Original Eqn: b'"GPV 15-39"*"Population Aged 15-39"'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return gpv_1539() * population_aged_1539()


@cache('step')
def total_gp_visits_4064():
    """
    Real Name: b'"Total GP Visits 40-64"'
    Original Eqn: b'"GPV 40-64"*"Population Aged 40-64"'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return gpv_4064() * population_aged_4064()


@cache('step')
def total_gp_visits_65():
    """
    Real Name: b'"Total GP Visits 65+"'
    Original Eqn: b'"GPV 65+"*"Population Aged 65+"'
    Units: b'Person/Year'
    Limits: (None, None)
    Type: component

    b''
    """
    return gpv_65() * population_aged_65()


@cache('step')
def total_population():
    """
    Real Name: b'Total Population'
    Original Eqn: b'"Population Aged 0-14"+"Population Aged 15-39"+"Population Aged 40-64"+"Population Aged 65+"'
    Units: b'Person'
    Limits: (None, None)
    Type: component

    b''
    """
    return population_aged_014() + population_aged_1539() + population_aged_4064(
    ) + population_aged_65()


@cache('run')
def final_time():
    """
    Real Name: b'FINAL TIME'
    Original Eqn: b'2050'
    Units: b'Year'
    Limits: (None, None)
    Type: constant

    b'The final time for the simulation.'
    """
    return 2050


@cache('run')
def initial_time():
    """
    Real Name: b'INITIAL TIME'
    Original Eqn: b'2014'
    Units: b'Year'
    Limits: (None, None)
    Type: constant

    b'The initial time for the simulation.'
    """
    return 2014


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


integ_expected_retirement_rate = functions.Integ(lambda: cerr(), lambda: 100)

integ_general_practitioners = functions.Integ(lambda: recruitment_rate() - retirement_rate(),
                                              lambda: 4000)

integ_patients_being_treated = functions.Integ(lambda: patient_visits() - completed_visits(),
                                               lambda: 2.4e+07)

integ_population_aged_014 = functions.Integ(lambda: births() - rate_c1_to_c2(), lambda: 1e+06)

integ_population_aged_1539 = functions.Integ(lambda: rate_c1_to_c2() - rate_c2_to_c3(),
                                             lambda: 1.5e+06)

integ_population_aged_4064 = functions.Integ(lambda: rate_c2_to_c3() - rate_c3_to_c4(),
                                             lambda: 2e+06)

integ_population_aged_65 = functions.Integ(lambda: rate_c3_to_c4() - deaths(), lambda: 500000)
