"""
Python model "Full Beer Model.py"
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
    'R ALPHA': 'r_alpha',
    'D Order Rate': 'd_order_rate',
    'F Customer Orders': 'f_customer_orders',
    'D Customer Orders': 'd_customer_orders',
    'W Order Rate': 'w_order_rate',
    'R Order Rate': 'r_order_rate',
    'R BETA': 'r_beta',
    'R CECO': 'r_ceco',
    'R Customer Orders': 'r_customer_orders',
    'R Delivery Delay': 'r_delivery_delay',
    'R Desired Delivery Rate': 'r_desired_delivery_rate',
    'R Desired Inventory': 'r_desired_inventory',
    'R Desired Supply Line': 'r_desired_supply_line',
    'D Acquisition Rate': 'd_acquisition_rate',
    'D Adjustment for Inventory': 'd_adjustment_for_inventory',
    'D Adjustment for Supply Line': 'd_adjustment_for_supply_line',
    'D Adjustment Time': 'd_adjustment_time',
    'D ALPHA': 'd_alpha',
    'D BETA': 'd_beta',
    'D CECO': 'd_ceco',
    'D Delivery Delay': 'd_delivery_delay',
    'D Desired Delivery Rate': 'd_desired_delivery_rate',
    'D Desired Inventory': 'd_desired_inventory',
    'D Desired Supply Line': 'd_desired_supply_line',
    'D Error Term': 'd_error_term',
    'D Expected Customer Orders': 'd_expected_customer_orders',
    'D Indicated Orders': 'd_indicated_orders',
    'D Inventory Adjustment Time': 'd_inventory_adjustment_time',
    'D Maximum Shipped Orders': 'd_maximum_shipped_orders',
    'D Min Shipment Time': 'd_min_shipment_time',
    'D Shipment Rate': 'd_shipment_rate',
    'D Stock': 'd_stock',
    'D Supply Line': 'd_supply_line',
    'D Supply LIne Adjustment Time': 'd_supply_line_adjustment_time',
    'W ALPHA': 'w_alpha',
    'W BETA': 'w_beta',
    'W CECO': 'w_ceco',
    'F Acquisition Rate': 'f_acquisition_rate',
    'F Adjustment for Inventory': 'f_adjustment_for_inventory',
    'F Adjustment for Supply Line': 'f_adjustment_for_supply_line',
    'F Adjustment Time': 'f_adjustment_time',
    'F ALPHA': 'f_alpha',
    'F BETA': 'f_beta',
    'F CECO': 'f_ceco',
    'F Delivery Delay': 'f_delivery_delay',
    'F Desired Delivery Rate': 'f_desired_delivery_rate',
    'F Desired Inventory': 'f_desired_inventory',
    'F Desired Supply Line': 'f_desired_supply_line',
    'F Error Term': 'f_error_term',
    'F Expected Customer Orders': 'f_expected_customer_orders',
    'F Indicated Orders': 'f_indicated_orders',
    'F Inventory Adjustment Time': 'f_inventory_adjustment_time',
    'F Maximum Shipped Orders': 'f_maximum_shipped_orders',
    'F Min Shipment Time': 'f_min_shipment_time',
    'F Order Rate': 'f_order_rate',
    'F Shipment Rate': 'f_shipment_rate',
    'F Stock': 'f_stock',
    'F Supply Line': 'f_supply_line',
    'F Supply LIne Adjustment Time': 'f_supply_line_adjustment_time',
    'W Shipment Rate': 'w_shipment_rate',
    'W Stock': 'w_stock',
    'R Acquisition Rate': 'r_acquisition_rate',
    'R Adjustment for Inventory': 'r_adjustment_for_inventory',
    'R Adjustment for Supply Line': 'r_adjustment_for_supply_line',
    'R Adjustment Time': 'r_adjustment_time',
    'R Supply LIne Adjustment Time': 'r_supply_line_adjustment_time',
    'W Inventory Adjustment Time': 'w_inventory_adjustment_time',
    'W Customer Orders': 'w_customer_orders',
    'W Delivery Delay': 'w_delivery_delay',
    'W Desired Delivery Rate': 'w_desired_delivery_rate',
    'R Error Term': 'r_error_term',
    'R Expected Customer Orders': 'r_expected_customer_orders',
    'R Indicated Orders': 'r_indicated_orders',
    'R Inventory Adjustment Time': 'r_inventory_adjustment_time',
    'R Maximum Shipped Orders': 'r_maximum_shipped_orders',
    'R Min Shipment Time': 'r_min_shipment_time',
    'R Shipment Rate': 'r_shipment_rate',
    'R Stock': 'r_stock',
    'R Supply Line': 'r_supply_line',
    'W Adjustment for Supply Line': 'w_adjustment_for_supply_line',
    'W Maximum Shipped Orders': 'w_maximum_shipped_orders',
    'W Acquisition Rate': 'w_acquisition_rate',
    'W Adjustment for Inventory': 'w_adjustment_for_inventory',
    'W Desired Inventory': 'w_desired_inventory',
    'W Adjustment Time': 'w_adjustment_time',
    'W Supply Line': 'w_supply_line',
    'W Supply LIne Adjustment Time': 'w_supply_line_adjustment_time',
    'W Indicated Orders': 'w_indicated_orders',
    'W Desired Supply Line': 'w_desired_supply_line',
    'W Error Term': 'w_error_term',
    'W Min Shipment Time': 'w_min_shipment_time',
    'W Expected Customer Orders': 'w_expected_customer_orders',
    'Supply LIne Adjustment Time': 'supply_line_adjustment_time',
    'BETA': 'beta',
    'ALPHA': 'alpha',
    'Inventory Adjustment Time': 'inventory_adjustment_time',
    'Min Shipment Time': 'min_shipment_time',
    'FINAL TIME': 'final_time',
    'INITIAL TIME': 'initial_time',
    'SAVEPER': 'saveper',
    'TIME STEP': 'time_step'
}

__pysd_version__ = "0.9.0"


@cache('run')
def r_alpha():
    """
    Real Name: b'R ALPHA'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def d_order_rate():
    """
    Real Name: b'D Order Rate'
    Original Eqn: b'F Shipment Rate'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return f_shipment_rate()


@cache('step')
def f_customer_orders():
    """
    Real Name: b'F Customer Orders'
    Original Eqn: b'D Indicated Orders'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return d_indicated_orders()


@cache('step')
def d_customer_orders():
    """
    Real Name: b'D Customer Orders'
    Original Eqn: b'W Indicated Orders'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return w_indicated_orders()


@cache('step')
def w_order_rate():
    """
    Real Name: b'W Order Rate'
    Original Eqn: b'D Shipment Rate'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return d_shipment_rate()


@cache('step')
def r_order_rate():
    """
    Real Name: b'R Order Rate'
    Original Eqn: b'W Shipment Rate'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return w_shipment_rate()


@cache('run')
def r_beta():
    """
    Real Name: b'R BETA'
    Original Eqn: b'0.05'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.05


@cache('step')
def r_ceco():
    """
    Real Name: b'R CECO'
    Original Eqn: b'R Error Term/R Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return r_error_term() / r_adjustment_time()


@cache('step')
def r_customer_orders():
    """
    Real Name: b'R Customer Orders'
    Original Eqn: b'100+1*step(100,10)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return 100 + 1 * functions.step(100, 10)


@cache('run')
def r_delivery_delay():
    """
    Real Name: b'R Delivery Delay'
    Original Eqn: b'4'
    Units: b'Week'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 4


@cache('step')
def r_desired_delivery_rate():
    """
    Real Name: b'R Desired Delivery Rate'
    Original Eqn: b'R Adjustment for Inventory+R Expected Customer Orders'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return r_adjustment_for_inventory() + r_expected_customer_orders()


@cache('run')
def r_desired_inventory():
    """
    Real Name: b'R Desired Inventory'
    Original Eqn: b'400'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 400


@cache('step')
def r_desired_supply_line():
    """
    Real Name: b'R Desired Supply Line'
    Original Eqn: b'R Delivery Delay*R Expected Customer Orders'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return r_delivery_delay() * r_expected_customer_orders()


@cache('step')
def d_acquisition_rate():
    """
    Real Name: b'D Acquisition Rate'
    Original Eqn: b'D Supply Line/D Delivery Delay'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return d_supply_line() / d_delivery_delay()


@cache('step')
def d_adjustment_for_inventory():
    """
    Real Name: b'D Adjustment for Inventory'
    Original Eqn: b'(D Desired Inventory-D Stock)/D Inventory Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return (d_desired_inventory() - d_stock()) / d_inventory_adjustment_time()


@cache('step')
def d_adjustment_for_supply_line():
    """
    Real Name: b'D Adjustment for Supply Line'
    Original Eqn: b'(D Desired Supply Line-D Supply Line)/D Supply LIne Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return (d_desired_supply_line() - d_supply_line()) / d_supply_line_adjustment_time()


@cache('run')
def d_adjustment_time():
    """
    Real Name: b'D Adjustment Time'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('run')
def d_alpha():
    """
    Real Name: b'D ALPHA'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('run')
def d_beta():
    """
    Real Name: b'D BETA'
    Original Eqn: b'0.05'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.05


@cache('step')
def d_ceco():
    """
    Real Name: b'D CECO'
    Original Eqn: b'D Error Term/D Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return d_error_term() / d_adjustment_time()


@cache('run')
def d_delivery_delay():
    """
    Real Name: b'D Delivery Delay'
    Original Eqn: b'4'
    Units: b'Week'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 4


@cache('step')
def d_desired_delivery_rate():
    """
    Real Name: b'D Desired Delivery Rate'
    Original Eqn: b'D Adjustment for Inventory+D Expected Customer Orders'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return d_adjustment_for_inventory() + d_expected_customer_orders()


@cache('run')
def d_desired_inventory():
    """
    Real Name: b'D Desired Inventory'
    Original Eqn: b'400'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 400


@cache('step')
def d_desired_supply_line():
    """
    Real Name: b'D Desired Supply Line'
    Original Eqn: b'D Delivery Delay*D Expected Customer Orders'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return d_delivery_delay() * d_expected_customer_orders()


@cache('step')
def d_error_term():
    """
    Real Name: b'D Error Term'
    Original Eqn: b'D Customer Orders-D Expected Customer Orders'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return d_customer_orders() - d_expected_customer_orders()


@cache('step')
def d_expected_customer_orders():
    """
    Real Name: b'D Expected Customer Orders'
    Original Eqn: b'INTEG ( D CECO, 100)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_d_expected_customer_orders()


@cache('step')
def d_indicated_orders():
    """
    Real Name: b'D Indicated Orders'
    Original Eqn: b'max(0,D Adjustment for Supply Line+D Desired Delivery Rate)'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return np.maximum(0, d_adjustment_for_supply_line() + d_desired_delivery_rate())


@cache('step')
def d_inventory_adjustment_time():
    """
    Real Name: b'D Inventory Adjustment Time'
    Original Eqn: b'1/D ALPHA'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 / d_alpha()


@cache('step')
def d_maximum_shipped_orders():
    """
    Real Name: b'D Maximum Shipped Orders'
    Original Eqn: b'D Stock/D Min Shipment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return d_stock() / d_min_shipment_time()


@cache('run')
def d_min_shipment_time():
    """
    Real Name: b'D Min Shipment Time'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def d_shipment_rate():
    """
    Real Name: b'D Shipment Rate'
    Original Eqn: b'MIN(D Customer Orders,D Maximum Shipped Orders)'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return np.minimum(d_customer_orders(), d_maximum_shipped_orders())


@cache('step')
def d_stock():
    """
    Real Name: b'D Stock'
    Original Eqn: b'INTEG ( D Acquisition Rate-D Shipment Rate, 400)'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_d_stock()


@cache('step')
def d_supply_line():
    """
    Real Name: b'D Supply Line'
    Original Eqn: b'INTEG ( D Order Rate-D Acquisition Rate, 400)'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_d_supply_line()


@cache('step')
def d_supply_line_adjustment_time():
    """
    Real Name: b'D Supply LIne Adjustment Time'
    Original Eqn: b'1/D BETA'
    Units: b'Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 / d_beta()


@cache('run')
def w_alpha():
    """
    Real Name: b'W ALPHA'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('run')
def w_beta():
    """
    Real Name: b'W BETA'
    Original Eqn: b'0.05'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.05


@cache('step')
def w_ceco():
    """
    Real Name: b'W CECO'
    Original Eqn: b'W Error Term/W Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return w_error_term() / w_adjustment_time()


@cache('step')
def f_acquisition_rate():
    """
    Real Name: b'F Acquisition Rate'
    Original Eqn: b'F Supply Line/F Delivery Delay'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return f_supply_line() / f_delivery_delay()


@cache('step')
def f_adjustment_for_inventory():
    """
    Real Name: b'F Adjustment for Inventory'
    Original Eqn: b'(F Desired Inventory-F Stock)/F Inventory Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return (f_desired_inventory() - f_stock()) / f_inventory_adjustment_time()


@cache('step')
def f_adjustment_for_supply_line():
    """
    Real Name: b'F Adjustment for Supply Line'
    Original Eqn: b'(F Desired Supply Line-F Supply Line)/F Supply LIne Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return (f_desired_supply_line() - f_supply_line()) / f_supply_line_adjustment_time()


@cache('run')
def f_adjustment_time():
    """
    Real Name: b'F Adjustment Time'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('run')
def f_alpha():
    """
    Real Name: b'F ALPHA'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('run')
def f_beta():
    """
    Real Name: b'F BETA'
    Original Eqn: b'0.05'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.05


@cache('step')
def f_ceco():
    """
    Real Name: b'F CECO'
    Original Eqn: b'F Error Term/F Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return f_error_term() / f_adjustment_time()


@cache('run')
def f_delivery_delay():
    """
    Real Name: b'F Delivery Delay'
    Original Eqn: b'4'
    Units: b'Week'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 4


@cache('step')
def f_desired_delivery_rate():
    """
    Real Name: b'F Desired Delivery Rate'
    Original Eqn: b'F Adjustment for Inventory+F Expected Customer Orders'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return f_adjustment_for_inventory() + f_expected_customer_orders()


@cache('run')
def f_desired_inventory():
    """
    Real Name: b'F Desired Inventory'
    Original Eqn: b'400'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 400


@cache('step')
def f_desired_supply_line():
    """
    Real Name: b'F Desired Supply Line'
    Original Eqn: b'F Delivery Delay*F Expected Customer Orders'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return f_delivery_delay() * f_expected_customer_orders()


@cache('step')
def f_error_term():
    """
    Real Name: b'F Error Term'
    Original Eqn: b'F Customer Orders-F Expected Customer Orders'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return f_customer_orders() - f_expected_customer_orders()


@cache('step')
def f_expected_customer_orders():
    """
    Real Name: b'F Expected Customer Orders'
    Original Eqn: b'INTEG ( F CECO, 100)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_f_expected_customer_orders()


@cache('step')
def f_indicated_orders():
    """
    Real Name: b'F Indicated Orders'
    Original Eqn: b'F Adjustment for Supply Line+F Desired Delivery Rate'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return f_adjustment_for_supply_line() + f_desired_delivery_rate()


@cache('step')
def f_inventory_adjustment_time():
    """
    Real Name: b'F Inventory Adjustment Time'
    Original Eqn: b'1/F ALPHA'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 / f_alpha()


@cache('step')
def f_maximum_shipped_orders():
    """
    Real Name: b'F Maximum Shipped Orders'
    Original Eqn: b'F Stock/F Min Shipment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return f_stock() / f_min_shipment_time()


@cache('run')
def f_min_shipment_time():
    """
    Real Name: b'F Min Shipment Time'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def f_order_rate():
    """
    Real Name: b'F Order Rate'
    Original Eqn: b'max(0,F Indicated Orders)'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return np.maximum(0, f_indicated_orders())


@cache('step')
def f_shipment_rate():
    """
    Real Name: b'F Shipment Rate'
    Original Eqn: b'MIN (F Customer Orders,F Maximum Shipped Orders)'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return np.minimum(f_customer_orders(), f_maximum_shipped_orders())


@cache('step')
def f_stock():
    """
    Real Name: b'F Stock'
    Original Eqn: b'INTEG ( F Acquisition Rate-F Shipment Rate, 400)'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_f_stock()


@cache('step')
def f_supply_line():
    """
    Real Name: b'F Supply Line'
    Original Eqn: b'INTEG ( F Order Rate-F Acquisition Rate, 400)'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_f_supply_line()


@cache('step')
def f_supply_line_adjustment_time():
    """
    Real Name: b'F Supply LIne Adjustment Time'
    Original Eqn: b'1/F BETA'
    Units: b'Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 / f_beta()


@cache('step')
def w_shipment_rate():
    """
    Real Name: b'W Shipment Rate'
    Original Eqn: b'MIN(W Customer Orders,W Maximum Shipped Orders)'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return np.minimum(w_customer_orders(), w_maximum_shipped_orders())


@cache('step')
def w_stock():
    """
    Real Name: b'W Stock'
    Original Eqn: b'INTEG ( W Acquisition Rate-W Shipment Rate, 400)'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_w_stock()


@cache('step')
def r_acquisition_rate():
    """
    Real Name: b'R Acquisition Rate'
    Original Eqn: b'R Supply Line/R Delivery Delay'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return r_supply_line() / r_delivery_delay()


@cache('step')
def r_adjustment_for_inventory():
    """
    Real Name: b'R Adjustment for Inventory'
    Original Eqn: b'(R Desired Inventory-R Stock)/R Inventory Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return (r_desired_inventory() - r_stock()) / r_inventory_adjustment_time()


@cache('step')
def r_adjustment_for_supply_line():
    """
    Real Name: b'R Adjustment for Supply Line'
    Original Eqn: b'(R Desired Supply Line-R Supply Line)/R Supply LIne Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return (r_desired_supply_line() - r_supply_line()) / r_supply_line_adjustment_time()


@cache('run')
def r_adjustment_time():
    """
    Real Name: b'R Adjustment Time'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def r_supply_line_adjustment_time():
    """
    Real Name: b'R Supply LIne Adjustment Time'
    Original Eqn: b'1/R BETA'
    Units: b'Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 / r_beta()


@cache('step')
def w_inventory_adjustment_time():
    """
    Real Name: b'W Inventory Adjustment Time'
    Original Eqn: b'1/W ALPHA'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 / w_alpha()


@cache('step')
def w_customer_orders():
    """
    Real Name: b'W Customer Orders'
    Original Eqn: b'R Indicated Orders'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return r_indicated_orders()


@cache('run')
def w_delivery_delay():
    """
    Real Name: b'W Delivery Delay'
    Original Eqn: b'4'
    Units: b'Week'
    Limits: (None, None)
    Type: constant

    b''
    """
    return 4


@cache('step')
def w_desired_delivery_rate():
    """
    Real Name: b'W Desired Delivery Rate'
    Original Eqn: b'W Adjustment for Inventory+W Expected Customer Orders'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return w_adjustment_for_inventory() + w_expected_customer_orders()


@cache('step')
def r_error_term():
    """
    Real Name: b'R Error Term'
    Original Eqn: b'R Customer Orders-R Expected Customer Orders'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return r_customer_orders() - r_expected_customer_orders()


@cache('step')
def r_expected_customer_orders():
    """
    Real Name: b'R Expected Customer Orders'
    Original Eqn: b'INTEG ( R CECO, 100)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_r_expected_customer_orders()


@cache('step')
def r_indicated_orders():
    """
    Real Name: b'R Indicated Orders'
    Original Eqn: b'max(0,R Adjustment for Supply Line+R Desired Delivery Rate)'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return np.maximum(0, r_adjustment_for_supply_line() + r_desired_delivery_rate())


@cache('step')
def r_inventory_adjustment_time():
    """
    Real Name: b'R Inventory Adjustment Time'
    Original Eqn: b'1/R ALPHA'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 / r_alpha()


@cache('step')
def r_maximum_shipped_orders():
    """
    Real Name: b'R Maximum Shipped Orders'
    Original Eqn: b'R Stock/R Min Shipment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return r_stock() / r_min_shipment_time()


@cache('run')
def r_min_shipment_time():
    """
    Real Name: b'R Min Shipment Time'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def r_shipment_rate():
    """
    Real Name: b'R Shipment Rate'
    Original Eqn: b'MIN(R Customer Orders,R Maximum Shipped Orders)'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return np.minimum(r_customer_orders(), r_maximum_shipped_orders())


@cache('step')
def r_stock():
    """
    Real Name: b'R Stock'
    Original Eqn: b'INTEG ( R Acquisition Rate-R Shipment Rate, 400)'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_r_stock()


@cache('step')
def r_supply_line():
    """
    Real Name: b'R Supply Line'
    Original Eqn: b'INTEG ( R Order Rate-R Acquisition Rate, 400)'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_r_supply_line()


@cache('step')
def w_adjustment_for_supply_line():
    """
    Real Name: b'W Adjustment for Supply Line'
    Original Eqn: b'(W Desired Supply Line-W Supply Line)/W Supply LIne Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return (w_desired_supply_line() - w_supply_line()) / w_supply_line_adjustment_time()


@cache('step')
def w_maximum_shipped_orders():
    """
    Real Name: b'W Maximum Shipped Orders'
    Original Eqn: b'W Stock/W Min Shipment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return w_stock() / w_min_shipment_time()


@cache('step')
def w_acquisition_rate():
    """
    Real Name: b'W Acquisition Rate'
    Original Eqn: b'W Supply Line/W Delivery Delay'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return w_supply_line() / w_delivery_delay()


@cache('step')
def w_adjustment_for_inventory():
    """
    Real Name: b'W Adjustment for Inventory'
    Original Eqn: b'(W Desired Inventory-W Stock)/W Inventory Adjustment Time'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return (w_desired_inventory() - w_stock()) / w_inventory_adjustment_time()


@cache('run')
def w_desired_inventory():
    """
    Real Name: b'W Desired Inventory'
    Original Eqn: b'400'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 400


@cache('run')
def w_adjustment_time():
    """
    Real Name: b'W Adjustment Time'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def w_supply_line():
    """
    Real Name: b'W Supply Line'
    Original Eqn: b'INTEG ( W Order Rate-W Acquisition Rate, 400)'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_w_supply_line()


@cache('step')
def w_supply_line_adjustment_time():
    """
    Real Name: b'W Supply LIne Adjustment Time'
    Original Eqn: b'1/W BETA'
    Units: b'Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 / w_beta()


@cache('step')
def w_indicated_orders():
    """
    Real Name: b'W Indicated Orders'
    Original Eqn: b'max(0,W Adjustment for Supply Line+W Desired Delivery Rate)'
    Units: b'SKU/Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return np.maximum(0, w_adjustment_for_supply_line() + w_desired_delivery_rate())


@cache('step')
def w_desired_supply_line():
    """
    Real Name: b'W Desired Supply Line'
    Original Eqn: b'W Delivery Delay*W Expected Customer Orders'
    Units: b'SKU'
    Limits: (None, None)
    Type: component

    b''
    """
    return w_delivery_delay() * w_expected_customer_orders()


@cache('step')
def w_error_term():
    """
    Real Name: b'W Error Term'
    Original Eqn: b'W Customer Orders-W Expected Customer Orders'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return w_customer_orders() - w_expected_customer_orders()


@cache('run')
def w_min_shipment_time():
    """
    Real Name: b'W Min Shipment Time'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def w_expected_customer_orders():
    """
    Real Name: b'W Expected Customer Orders'
    Original Eqn: b'INTEG ( W CECO, 100)'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return integ_w_expected_customer_orders()


@cache('step')
def supply_line_adjustment_time():
    """
    Real Name: b'Supply LIne Adjustment Time'
    Original Eqn: b'1/BETA'
    Units: b'Week'
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 / beta()


@cache('run')
def beta():
    """
    Real Name: b'BETA'
    Original Eqn: b'0.05'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 0.05


@cache('run')
def alpha():
    """
    Real Name: b'ALPHA'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('step')
def inventory_adjustment_time():
    """
    Real Name: b'Inventory Adjustment Time'
    Original Eqn: b'1/ALPHA'
    Units: b''
    Limits: (None, None)
    Type: component

    b''
    """
    return 1 / alpha()


@cache('run')
def min_shipment_time():
    """
    Real Name: b'Min Shipment Time'
    Original Eqn: b'1'
    Units: b''
    Limits: (None, None)
    Type: constant

    b''
    """
    return 1


@cache('run')
def final_time():
    """
    Real Name: b'FINAL TIME'
    Original Eqn: b'40'
    Units: b'Week'
    Limits: (None, None)
    Type: constant

    b'The final time for the simulation.'
    """
    return 40


@cache('run')
def initial_time():
    """
    Real Name: b'INITIAL TIME'
    Original Eqn: b'0'
    Units: b'Week'
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
    Units: b'Week'
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
    Units: b'Week'
    Limits: (0.0, None)
    Type: constant

    b'The time step for the simulation.'
    """
    return 0.125


integ_d_expected_customer_orders = functions.Integ(lambda: d_ceco(), lambda: 100)

integ_d_stock = functions.Integ(lambda: d_acquisition_rate() - d_shipment_rate(), lambda: 400)

integ_d_supply_line = functions.Integ(lambda: d_order_rate() - d_acquisition_rate(), lambda: 400)

integ_f_expected_customer_orders = functions.Integ(lambda: f_ceco(), lambda: 100)

integ_f_stock = functions.Integ(lambda: f_acquisition_rate() - f_shipment_rate(), lambda: 400)

integ_f_supply_line = functions.Integ(lambda: f_order_rate() - f_acquisition_rate(), lambda: 400)

integ_w_stock = functions.Integ(lambda: w_acquisition_rate() - w_shipment_rate(), lambda: 400)

integ_r_expected_customer_orders = functions.Integ(lambda: r_ceco(), lambda: 100)

integ_r_stock = functions.Integ(lambda: r_acquisition_rate() - r_shipment_rate(), lambda: 400)

integ_r_supply_line = functions.Integ(lambda: r_order_rate() - r_acquisition_rate(), lambda: 400)

integ_w_supply_line = functions.Integ(lambda: w_order_rate() - w_acquisition_rate(), lambda: 400)

integ_w_expected_customer_orders = functions.Integ(lambda: w_ceco(), lambda: 100)
