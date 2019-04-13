"""
Python model "Energy.py"
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
    'travel range max': 'travel_range_max',
    'Change in travel range': 'change_in_travel_range',
    'Attractiveness of AFV': 'attractiveness_of_afv',
    'Attractiveness of ICE': 'attractiveness_of_ice',
    'Development in AFV travel Range': 'development_in_afv_travel_range',
    'AFV travel range': 'afv_travel_range',
    'Effect of travel range on AFV Attractiveness': 'effect_of_travel_range_on_afv_attractiveness',
    'technological upgrade delay': 'technological_upgrade_delay',
    'Fuelling Station Attractiveness on AFV': 'fuelling_station_attractiveness_on_afv',
    'Reference travel range attractiveness on AFV': 'reference_travel_range_attractiveness_on_afv',
    'Travel range attractiveness on AFV': 'travel_range_attractiveness_on_afv',
    'Discarded charging stations': 'discarded_charging_stations',
    'New charging stations': 'new_charging_stations',
    'Charging station attractiveness on ICE': 'charging_station_attractiveness_on_ice',
    'Charging stations attractiveness on AFV': 'charging_stations_attractiveness_on_afv',
    'Change in ECSD': 'change_in_ecsd',
    'Reference charging stations attractiveness on AFV':
    'reference_charging_stations_attractiveness_on_afv',
    '"Adopters: charging stations"': 'adopters_charging_stations',
    'Effect of charging stations availability on attractiveness of AFV':
    'effect_of_charging_stations_availability_on_attractiveness_of_afv',
    'Expected charging station discards': 'expected_charging_station_discards',
    'Stations Discard AT': 'stations_discard_at',
    'Error': 'error',
    'Average life time of charging stations': 'average_life_time_of_charging_stations',
    'Charging station adjustment': 'charging_station_adjustment',
    'Desired relation contant between AFV and CS': 'desired_relation_contant_between_afv_and_cs',
    'New charging station AT': 'new_charging_station_at',
    'Number of AFV Charging Stations': 'number_of_afv_charging_stations',
    'Target Charging stations': 'target_charging_stations',
    'Lagged Effect of price on Attractiveness of ICE':
    'lagged_effect_of_price_on_attractiveness_of_ice',
    'lagged effect of price on attractiveness on AFV':
    'lagged_effect_of_price_on_attractiveness_on_afv',
    'Price Attractiveness on AFV': 'price_attractiveness_on_afv',
    'Price Attractiveness on ICE': 'price_attractiveness_on_ice',
    'Lag constant': 'lag_constant',
    '"Actual Price proportion (AFV/ICE)"': 'actual_price_proportion_afvice',
    '"Actual Price proportion (ICE/AFV)"': 'actual_price_proportion_iceafv',
    'Adopters AFV': 'adopters_afv',
    'Adopters ICE': 'adopters_ice',
    'Adoption fraction i': 'adoption_fraction_i',
    'Advertising Effectiveness': 'advertising_effectiveness',
    'AFV adoption from Advertisement': 'afv_adoption_from_advertisement',
    'AFV adoption from word of mouth': 'afv_adoption_from_word_of_mouth',
    'AFV Adoption Rate': 'afv_adoption_rate',
    'AFV discards': 'afv_discards',
    'AFV life time': 'afv_life_time',
    'AFV opted': 'afv_opted',
    'Contact Rate C': 'contact_rate_c',
    'Delay time': 'delay_time',
    'Effect of Price on Attractiveness on AFV': 'effect_of_price_on_attractiveness_on_afv',
    'Effect of Price on Attractiveness on ICE': 'effect_of_price_on_attractiveness_on_ice',
    'Government Subsidiary': 'government_subsidiary',
    'ICE Adoption from Advertisement': 'ice_adoption_from_advertisement',
    'ICE Adoption from word of mouth': 'ice_adoption_from_word_of_mouth',
    'ICE Adoption rate': 'ice_adoption_rate',
    'ICE discards': 'ice_discards',
    'ICE life time': 'ice_life_time',
    'ICE opted': 'ice_opted',
    'Market share AFV': 'market_share_afv',
    'Market Share ICE': 'market_share_ice',
    'Population N': 'population_n',
    'Potential Adopters': 'potential_adopters',
    'Potential Adopters of AFV': 'potential_adopters_of_afv',
    'Potential Adopters of ICE': 'potential_adopters_of_ice',
    'Purchase price of AFV': 'purchase_price_of_afv',
    'Reference price Attractiveness on AFV': 'reference_price_attractiveness_on_afv',
    'Reference Price Attractiveness on ICE': 'reference_price_attractiveness_on_ice',
    '"Reference Price Proportion (AFV/ICE)"': 'reference_price_proportion_afvice',
    '"Reference Price proportion (ICE/AFV)"': 'reference_price_proportion_iceafv',
    'Selling Price of AFV': 'selling_price_of_afv',
    'Selling price of ICE': 'selling_price_of_ice',
    'Total Attractiveness of vehicles': 'total_attractiveness_of_vehicles',
    'FINAL TIME': 'final_time',
    'INITIAL TIME': 'initial_time',
    'SAVEPER': 'saveper',
    'TIME STEP': 'time_step'
}

__pysd_version__ = "0.9.0"


@cache('step')
def travel_range_max():
    """
    Real Name: b'travel range max'
    Original Eqn: b'50+Step(50,100)'
    Units: b'Miles/charge'
    Limits: (None, None)
    Type: component

    b''
    """
    return 50 + functions.step(50, 100)


@cache('step')
def change_in_travel_range():
    """
    Real Name: b'Change in travel range'
    Original Eqn: b'travel range max-AFV travel range'
    Units: b'Miles/charge'
    Limits: (None, None)
    Type: component

    b''
    """
    return travel_range_max() - afv_travel_range()


@cache('step')
def attractiveness_of_afv():
    """
    Real Name: b'Attractiveness of AFV'
    Original Eqn: b'Price Attractiveness on AFV*Charging stations attractiveness on AFV*Travel range attractiveness on AFV'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return price_attractiveness_on_afv() * charging_stations_attractiveness_on_afv(
    ) * travel_range_attractiveness_on_afv()


@cache('step')
def attractiveness_of_ice():
    """
    Real Name: b'Attractiveness of ICE'
    Original Eqn: b'Price Attractiveness on ICE*Charging station attractiveness on ICE*Fuelling Station Attractiveness on AFV'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return price_attractiveness_on_ice() * charging_station_attractiveness_on_ice(
    ) * fuelling_station_attractiveness_on_afv()


@cache('step')
def development_in_afv_travel_range():
    """
    Real Name: b'Development in AFV travel Range'
    Original Eqn: b'Change in travel range/technological upgrade delay'
    Units: b'Miles/charge/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return change_in_travel_range() / technological_upgrade_delay()


@cache('step')
def afv_travel_range():
    """
    Real Name: b'AFV travel range'
    Original Eqn: b'INTEG ( Development in AFV travel Range, 10)'
    Units: b'Miles/charge'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_afv_travel_range()


@cache('step')
def effect_of_travel_range_on_afv_attractiveness():
    """
    Real Name: b'Effect of travel range on AFV Attractiveness'
    Original Eqn: b'AFV travel range/travel range max'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return afv_travel_range() / travel_range_max()


@cache('run')
def technological_upgrade_delay():
    """
    Real Name: b'technological upgrade delay'
    Original Eqn: b'36'
    Units: b'Month'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 36


@cache('run')
def fuelling_station_attractiveness_on_afv():
    """
    Real Name: b'Fuelling Station Attractiveness on AFV'
    Original Eqn: b'0.4'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.4


@cache('run')
def reference_travel_range_attractiveness_on_afv():
    """
    Real Name: b'Reference travel range attractiveness on AFV'
    Original Eqn: b'0.4'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.4


@cache('step')
def travel_range_attractiveness_on_afv():
    """
    Real Name: b'Travel range attractiveness on AFV'
    Original Eqn: b'Reference travel range attractiveness on AFV*Effect of travel range on AFV Attractiveness'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return reference_travel_range_attractiveness_on_afv(
    ) * effect_of_travel_range_on_afv_attractiveness()


@cache('step')
def discarded_charging_stations():
    """
    Real Name: b'Discarded charging stations'
    Original Eqn: b'(Number of AFV Charging Stations/Average life time of charging stations)'
    Units: b'stations/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return (number_of_afv_charging_stations() / average_life_time_of_charging_stations())


@cache('step')
def new_charging_stations():
    """
    Real Name: b'New charging stations'
    Original Eqn: b'(Charging station adjustment+Expected charging station discards)'
    Units: b'stations/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return (charging_station_adjustment() + expected_charging_station_discards())


@cache('run')
def charging_station_attractiveness_on_ice():
    """
    Real Name: b'Charging station attractiveness on ICE'
    Original Eqn: b'0.5'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.5


@cache('step')
def charging_stations_attractiveness_on_afv():
    """
    Real Name: b'Charging stations attractiveness on AFV'
    Original Eqn: b'Effect of charging stations availability on attractiveness of AFV*Reference charging stations attractiveness on AFV'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return effect_of_charging_stations_availability_on_attractiveness_of_afv(
    ) * reference_charging_stations_attractiveness_on_afv()


@cache('step')
def change_in_ecsd():
    """
    Real Name: b'Change in ECSD'
    Original Eqn: b'Error/Stations Discard AT'
    Units: b'stations/Month/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return error() / stations_discard_at()


@cache('run')
def reference_charging_stations_attractiveness_on_afv():
    """
    Real Name: b'Reference charging stations attractiveness on AFV'
    Original Eqn: b'0.5'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.5


@cache('step')
def adopters_charging_stations():
    """
    Real Name: b'"Adopters: charging stations"'
    Original Eqn: b'Adopters AFV/Number of AFV Charging Stations'
    Units: b'People/stations'
    Limits: (None, None)
    Type: component

    b''
    """
    return adopters_afv() / number_of_afv_charging_stations()


@cache('step')
def effect_of_charging_stations_availability_on_attractiveness_of_afv():
    """
    Real Name: b'Effect of charging stations availability on attractiveness of AFV'
    Original Eqn: b'"Adopters: charging stations"/Desired relation contant between AFV and CS'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return adopters_charging_stations() / desired_relation_contant_between_afv_and_cs()


@cache('step')
def expected_charging_station_discards():
    """
    Real Name: b'Expected charging station discards'
    Original Eqn: b'INTEG ( Change in ECSD, 0)'
    Units: b'stations/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_expected_charging_station_discards()


@cache('run')
def stations_discard_at():
    """
    Real Name: b'Stations Discard AT'
    Original Eqn: b'36'
    Units: b'Month'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 36


@cache('step')
def error():
    """
    Real Name: b'Error'
    Original Eqn: b'Discarded charging stations-Expected charging station discards'
    Units: b'stations/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return discarded_charging_stations() - expected_charging_station_discards()


@cache('run')
def average_life_time_of_charging_stations():
    """
    Real Name: b'Average life time of charging stations'
    Original Eqn: b'36'
    Units: b'Month'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 36


@cache('step')
def charging_station_adjustment():
    """
    Real Name: b'Charging station adjustment'
    Original Eqn: b'(Target Charging stations-Number of AFV Charging Stations)/New charging station AT'
    Units: b'stations/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return (target_charging_stations() -
            number_of_afv_charging_stations()) / new_charging_station_at()


@cache('run')
def desired_relation_contant_between_afv_and_cs():
    """
    Real Name: b'Desired relation contant between AFV and CS'
    Original Eqn: b'5'
    Units: b'People/stations'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 5


@cache('run')
def new_charging_station_at():
    """
    Real Name: b'New charging station AT'
    Original Eqn: b'12'
    Units: b'Month'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 12


@cache('step')
def number_of_afv_charging_stations():
    """
    Real Name: b'Number of AFV Charging Stations'
    Original Eqn: b'INTEG ( New charging stations-Discarded charging stations, 10)'
    Units: b'stations'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_number_of_afv_charging_stations()


@cache('step')
def target_charging_stations():
    """
    Real Name: b'Target Charging stations'
    Original Eqn: b'Adopters AFV/Desired relation contant between AFV and CS'
    Units: b'stations'
    Limits: (None, None)
    Type: component

    b''
    """
    return adopters_afv() / desired_relation_contant_between_afv_and_cs()


@cache('step')
def lagged_effect_of_price_on_attractiveness_of_ice():
    """
    Real Name: b'Lagged Effect of price on Attractiveness of ICE'
    Original Eqn: b'DELAY1I(Effect of Price on Attractiveness on ICE, Lag constant, 0.7)'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return delay_effect_of_price_on_attractiveness_on_ice_lag_constant_07_1()


@cache('step')
def lagged_effect_of_price_on_attractiveness_on_afv():
    """
    Real Name: b'lagged effect of price on attractiveness on AFV'
    Original Eqn: b'DELAY1I(Effect of Price on Attractiveness on AFV, Lag constant , 0.3 )'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return delay_effect_of_price_on_attractiveness_on_afv_lag_constant_03_1()


@cache('step')
def price_attractiveness_on_afv():
    """
    Real Name: b'Price Attractiveness on AFV'
    Original Eqn: b'lagged effect of price on attractiveness on AFV*Reference price Attractiveness on AFV'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return lagged_effect_of_price_on_attractiveness_on_afv(
    ) * reference_price_attractiveness_on_afv()


@cache('step')
def price_attractiveness_on_ice():
    """
    Real Name: b'Price Attractiveness on ICE'
    Original Eqn: b'Lagged Effect of price on Attractiveness of ICE*Reference Price Attractiveness on ICE'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return lagged_effect_of_price_on_attractiveness_of_ice(
    ) * reference_price_attractiveness_on_ice()


@cache('run')
def lag_constant():
    """
    Real Name: b'Lag constant'
    Original Eqn: b'48'
    Units: b'Month'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 48


@cache('step')
def actual_price_proportion_afvice():
    """
    Real Name: b'"Actual Price proportion (AFV/ICE)"'
    Original Eqn: b'Purchase price of AFV/Selling price of ICE'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return purchase_price_of_afv() / selling_price_of_ice()


@cache('step')
def actual_price_proportion_iceafv():
    """
    Real Name: b'"Actual Price proportion (ICE/AFV)"'
    Original Eqn: b'Selling price of ICE/Purchase price of AFV'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return selling_price_of_ice() / purchase_price_of_afv()


@cache('step')
def adopters_afv():
    """
    Real Name: b'Adopters AFV'
    Original Eqn: b'INTEG ( AFV Adoption Rate-AFV discards, 100)'
    Units: b'People'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_adopters_afv()


@cache('step')
def adopters_ice():
    """
    Real Name: b'Adopters ICE'
    Original Eqn: b'INTEG ( ICE Adoption rate-ICE discards, 100)'
    Units: b'People'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_adopters_ice()


@cache('run')
def adoption_fraction_i():
    """
    Real Name: b'Adoption fraction i'
    Original Eqn: b'0.2'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.2


@cache('run')
def advertising_effectiveness():
    """
    Real Name: b'Advertising Effectiveness'
    Original Eqn: b'0.1'
    Units: b'1/Month'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.1


@cache('step')
def afv_adoption_from_advertisement():
    """
    Real Name: b'AFV adoption from Advertisement'
    Original Eqn: b'Potential Adopters of AFV*Advertising Effectiveness'
    Units: b'People/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return potential_adopters_of_afv() * advertising_effectiveness()


@cache('step')
def afv_adoption_from_word_of_mouth():
    """
    Real Name: b'AFV adoption from word of mouth'
    Original Eqn: b'Contact Rate C*Adoption fraction i*Potential Adopters of AFV*(Adopters AFV/Population N\\\\ )'
    Units: b'People/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return contact_rate_c() * adoption_fraction_i() * potential_adopters_of_afv() * (
        adopters_afv() / population_n())


@cache('step')
def afv_adoption_rate():
    """
    Real Name: b'AFV Adoption Rate'
    Original Eqn: b'AFV adoption from Advertisement+AFV adoption from word of mouth'
    Units: b'People/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return afv_adoption_from_advertisement() + afv_adoption_from_word_of_mouth()


@cache('step')
def afv_discards():
    """
    Real Name: b'AFV discards'
    Original Eqn: b'Adopters AFV/AFV life time'
    Units: b'People/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return adopters_afv() / afv_life_time()


@cache('run')
def afv_life_time():
    """
    Real Name: b'AFV life time'
    Original Eqn: b'60'
    Units: b'Month'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 60


@cache('step')
def afv_opted():
    """
    Real Name: b'AFV opted'
    Original Eqn: b'((Market share AFV*Potential Adopters)/Delay time)'
    Units: b'People/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return ((market_share_afv() * potential_adopters()) / delay_time())


@cache('run')
def contact_rate_c():
    """
    Real Name: b'Contact Rate C'
    Original Eqn: b'6'
    Units: b'People/People/Month'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 6


@cache('run')
def delay_time():
    """
    Real Name: b'Delay time'
    Original Eqn: b'1'
    Units: b'Month'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def effect_of_price_on_attractiveness_on_afv():
    """
    Real Name: b'Effect of Price on Attractiveness on AFV'
    Original Eqn: b'"Actual Price proportion (ICE/AFV)"/"Reference Price proportion (ICE/AFV)"'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return actual_price_proportion_iceafv() / reference_price_proportion_iceafv()


@cache('step')
def effect_of_price_on_attractiveness_on_ice():
    """
    Real Name: b'Effect of Price on Attractiveness on ICE'
    Original Eqn: b'"Actual Price proportion (AFV/ICE)"/"Reference Price Proportion (AFV/ICE)"'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return actual_price_proportion_afvice() / reference_price_proportion_afvice()


@cache('run')
def government_subsidiary():
    """
    Real Name: b'Government Subsidiary'
    Original Eqn: b'0'
    Units: b'Euros'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0


@cache('step')
def ice_adoption_from_advertisement():
    """
    Real Name: b'ICE Adoption from Advertisement'
    Original Eqn: b'Potential Adopters of ICE*Advertising Effectiveness'
    Units: b'People/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return potential_adopters_of_ice() * advertising_effectiveness()


@cache('step')
def ice_adoption_from_word_of_mouth():
    """
    Real Name: b'ICE Adoption from word of mouth'
    Original Eqn: b'Contact Rate C*Adoption fraction i*Potential Adopters of ICE*(Adopters ICE/Population N\\\\ )'
    Units: b'People/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return contact_rate_c() * adoption_fraction_i() * potential_adopters_of_ice() * (
        adopters_ice() / population_n())


@cache('step')
def ice_adoption_rate():
    """
    Real Name: b'ICE Adoption rate'
    Original Eqn: b'ICE Adoption from Advertisement+ICE Adoption from word of mouth'
    Units: b'People/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return ice_adoption_from_advertisement() + ice_adoption_from_word_of_mouth()


@cache('step')
def ice_discards():
    """
    Real Name: b'ICE discards'
    Original Eqn: b'Adopters ICE/ICE life time'
    Units: b'People/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return adopters_ice() / ice_life_time()


@cache('run')
def ice_life_time():
    """
    Real Name: b'ICE life time'
    Original Eqn: b'60'
    Units: b'Month'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 60


@cache('step')
def ice_opted():
    """
    Real Name: b'ICE opted'
    Original Eqn: b'(Market Share ICE*Potential Adopters)/Delay time'
    Units: b'People/Month'
    Limits: (None, None)
    Type: component

    b''
    """
    return (market_share_ice() * potential_adopters()) / delay_time()


@cache('step')
def market_share_afv():
    """
    Real Name: b'Market share AFV'
    Original Eqn: b'Attractiveness of AFV/Total Attractiveness of vehicles'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return attractiveness_of_afv() / total_attractiveness_of_vehicles()


@cache('step')
def market_share_ice():
    """
    Real Name: b'Market Share ICE'
    Original Eqn: b'Attractiveness of ICE/Total Attractiveness of vehicles'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return attractiveness_of_ice() / total_attractiveness_of_vehicles()


@cache('step')
def population_n():
    """
    Real Name: b'Population N'
    Original Eqn: b'Adopters AFV+Adopters ICE+Potential Adopters+Potential Adopters of AFV+Potential Adopters of ICE'
    Units: b'People'
    Limits: (None, None)
    Type: component

    b''
    """
    return adopters_afv() + adopters_ice() + potential_adopters() + potential_adopters_of_afv(
    ) + potential_adopters_of_ice()


@cache('step')
def potential_adopters():
    """
    Real Name: b'Potential Adopters'
    Original Eqn: b'INTEG ( ICE discards+AFV discards-ICE opted-AFV opted, 0)'
    Units: b'People'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_potential_adopters()


@cache('step')
def potential_adopters_of_afv():
    """
    Real Name: b'Potential Adopters of AFV'
    Original Eqn: b'INTEG ( AFV opted-AFV Adoption Rate, 1000)'
    Units: b'People'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_potential_adopters_of_afv()


@cache('step')
def potential_adopters_of_ice():
    """
    Real Name: b'Potential Adopters of ICE'
    Original Eqn: b'INTEG ( ICE opted-ICE Adoption rate, 1000)'
    Units: b'People'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_potential_adopters_of_ice()


@cache('step')
def purchase_price_of_afv():
    """
    Real Name: b'Purchase price of AFV'
    Original Eqn: b'Selling Price of AFV-Government Subsidiary'
    Units: b'Euros'
    Limits: (None, None)
    Type: component

    b''
    """
    return selling_price_of_afv() - government_subsidiary()


@cache('run')
def reference_price_attractiveness_on_afv():
    """
    Real Name: b'Reference price Attractiveness on AFV'
    Original Eqn: b'0.3'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.3


@cache('run')
def reference_price_attractiveness_on_ice():
    """
    Real Name: b'Reference Price Attractiveness on ICE'
    Original Eqn: b'0.7'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.7


@cache('run')
def reference_price_proportion_afvice():
    """
    Real Name: b'"Reference Price Proportion (AFV/ICE)"'
    Original Eqn: b'2'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 2


@cache('run')
def reference_price_proportion_iceafv():
    """
    Real Name: b'"Reference Price proportion (ICE/AFV)"'
    Original Eqn: b'0.5'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.5


@cache('step')
def selling_price_of_afv():
    """
    Real Name: b'Selling Price of AFV'
    Original Eqn: b'1200-Step(200,12)'
    Units: b'Euros'
    Limits: (None, None)
    Type: component

    b''
    """
    return 1200 - functions.step(200, 12)


@cache('run')
def selling_price_of_ice():
    """
    Real Name: b'Selling price of ICE'
    Original Eqn: b'1000'
    Units: b'Euros'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1000


@cache('step')
def total_attractiveness_of_vehicles():
    """
    Real Name: b'Total Attractiveness of vehicles'
    Original Eqn: b'Attractiveness of AFV+Attractiveness of ICE'
    Units: b'Dmnl'
    Limits: (None, None)
    Type: component

    b''
    """
    return attractiveness_of_afv() + attractiveness_of_ice()


@cache('run')
def final_time():
    """
    Real Name: b'FINAL TIME'
    Original Eqn: b'2000'
    Units: b'Month'
    Limits: (None, None)
    Type: constant

    b'The final time for the simulation.'
    """
    return 2000


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
    Original Eqn: b'0.125'
    Units: b'Month'
    Limits: (0.0, None)
    Type: constant

    b'The time step for the simulation.'
    """
    return 0.125


integ_afv_travel_range = functions.Integ(lambda: development_in_afv_travel_range(), lambda: 10)

integ_expected_charging_station_discards = functions.Integ(lambda: change_in_ecsd(), lambda: 0)

integ_number_of_afv_charging_stations = functions.Integ(
    lambda: new_charging_stations() - discarded_charging_stations(), lambda: 10)

delay_effect_of_price_on_attractiveness_on_ice_lag_constant_07_1 = functions.Delay(
    lambda: effect_of_price_on_attractiveness_on_ice(), lambda: lag_constant(), lambda: 0.7,
    lambda: 1)

delay_effect_of_price_on_attractiveness_on_afv_lag_constant_03_1 = functions.Delay(
    lambda: effect_of_price_on_attractiveness_on_afv(), lambda: lag_constant(), lambda: 0.3,
    lambda: 1)

integ_adopters_afv = functions.Integ(lambda: afv_adoption_rate() - afv_discards(), lambda: 100)

integ_adopters_ice = functions.Integ(lambda: ice_adoption_rate() - ice_discards(), lambda: 100)

integ_potential_adopters = functions.Integ(
    lambda: ice_discards() + afv_discards() - ice_opted() - afv_opted(), lambda: 0)

integ_potential_adopters_of_afv = functions.Integ(lambda: afv_opted() - afv_adoption_rate(),
                                                  lambda: 1000)

integ_potential_adopters_of_ice = functions.Integ(lambda: ice_opted() - ice_adoption_rate(),
                                                  lambda: 1000)
