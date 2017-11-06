###########################################
# Translation of Vensim file.
# Date created: 2017-11-02 15:56:18
###########################################
library(deSolve)
library(ggplot2)
library(tidyr)
#Displaying the simulation run parameters
START_TIME <- 0.000000
FINISH_TIME <- 40.000000
TIME_STEP <- 0.125000
#Setting aux param to NULL
auxs<-NULL

#Generating the simulation time vector
simtime<-seq(0.000000,40.000000,by=0.125000)
# Writing global variables (stocks and dependent auxs)
stocks <-c( ExpectedCustomerOrders = 100 , Stock = 400 , SupplyLine = 400 )
# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    DeliveryDelay <- 4
    AcquisitionRate <- SupplyLine/DeliveryDelay
    DesiredInventory <- 400
    ALPHA <- 1
    InventoryAdjustmentTime <- 1/ALPHA
    AdjustmentforInventory <- (DesiredInventory-Stock)/InventoryAdjustmentTime
    DesiredSupplyLine <- DeliveryDelay*ExpectedCustomerOrders
    BETA <- 0.05
    SupplyLIneAdjustmentTime <- 1/BETA
    AdjustmentforSupplyLine <- (DesiredSupplyLine-SupplyLine)/SupplyLIneAdjustmentTime
    AdjustmentTime <- 1
    CustomerOrders <- 100
    ErrorTerm <- CustomerOrders-ExpectedCustomerOrders
    CECO <- ErrorTerm/AdjustmentTime
    DesiredDeliveryRate <- AdjustmentforInventory+ExpectedCustomerOrders
    IndicatedOrders <- AdjustmentforSupplyLine+DesiredDeliveryRate
    MinShipmentTime <- 1
    MaximumShippedOrders <- Stock/MinShipmentTime
    OrderRate <- max(0,IndicatedOrders)
    ShipmentRate <- min(CustomerOrders,MaximumShippedOrders)
    d_DT_ExpectedCustomerOrders  <- CECO
    d_DT_Stock  <- AcquisitionRate-ShipmentRate
    d_DT_SupplyLine  <- OrderRate-AcquisitionRate
    return (list(c(d_DT_ExpectedCustomerOrders,d_DT_Stock,d_DT_SupplyLine)))
  })
}
# Function call to run simulation
o<-data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))
to<-gather(o,key=Stock,value=Value,2:ncol(o))
ggplot(data=to)+geom_line(aes(x=time,y=Value,colour=Stock))
#----------------------------------------------------
# Original text file exported from Vensim
#  Expected Customer Orders = INTEG( CECO , 100) 
#  Stock = INTEG( Acquisition Rate - Shipment Rate , 400) 
#  Supply Line = INTEG( Order Rate - Acquisition Rate , 400) 
#  Delivery Delay = 4
#  Acquisition Rate = Supply Line / Delivery Delay 
#  Desired Inventory = 400
#  ALPHA = 1
#  Inventory Adjustment Time = 1 / ALPHA 
#  Adjustment for Inventory = ( Desired Inventory - Stock ) / Inventory Adjustment Time
#  Desired Supply Line = Delivery Delay * Expected Customer Orders 
#  BETA = 0.05
#  Supply LIne Adjustment Time = 1 / BETA 
#  Adjustment for Supply Line = ( Desired Supply Line - Supply Line ) / Supply LIne Adjustment Time
#  Adjustment Time = 1
#  Customer Orders = 100 
#  Error Term = Customer Orders - Expected Customer Orders 
#  CECO = Error Term / Adjustment Time 
#  Desired Delivery Rate = Adjustment for Inventory + Expected Customer Orders
#  FINAL TIME = 40
#  Indicated Orders = Adjustment for Supply Line + Desired Delivery Rate 
#  INITIAL TIME = 0
#  Min Shipment Time = 1
#  Maximum Shipped Orders = Stock / Min Shipment Time 
#  Order Rate = max ( 0, Indicated Orders ) 
#  TIME STEP = 0.125
#  Shipment Rate = min ( Customer Orders , Maximum Shipped Orders ) 
#----------------------------------------------------
