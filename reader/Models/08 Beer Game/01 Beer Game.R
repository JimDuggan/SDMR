###########################################
# Translation of Vensim file.
# Date created: 2017-11-10 16:57:13
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
stocks <-c( DExpectedCustomerOrders = 100 , DStock = 400 , DSupplyLine = 400 , FExpectedCustomerOrders = 100 , FStock = 400 , FSupplyLine = 400 , RExpectedCustomerOrders = 100 , RStock = 400 , RSupplyLine = 400 , WExpectedCustomerOrders = 100 , WStock = 400 , WSupplyLine = 400 )
# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    ALPHA <- 1
    BETA <- 0.05
    DDeliveryDelay <- 4
    DAcquisitionRate <- DSupplyLine/DDeliveryDelay
    DDesiredInventory <- 400
    DALPHA <- 1
    DInventoryAdjustmentTime <- 1/DALPHA
    DAdjustmentforInventory <- (DDesiredInventory-DStock)/DInventoryAdjustmentTime
    DDesiredSupplyLine <- DDeliveryDelay*DExpectedCustomerOrders
    DBETA <- 0.05
    DSupplyLIneAdjustmentTime <- 1/DBETA
    DAdjustmentforSupplyLine <- (DDesiredSupplyLine-DSupplyLine)/DSupplyLIneAdjustmentTime
    DAdjustmentTime <- 1
    WDeliveryDelay <- 4
    WDesiredSupplyLine <- WDeliveryDelay*WExpectedCustomerOrders
    WBETA <- 0.05
    WSupplyLIneAdjustmentTime <- 1/WBETA
    WAdjustmentforSupplyLine <- (WDesiredSupplyLine-WSupplyLine)/WSupplyLIneAdjustmentTime
    WDesiredInventory <- 400
    WALPHA <- 1
    WInventoryAdjustmentTime <- 1/WALPHA
    WAdjustmentforInventory <- (WDesiredInventory-WStock)/WInventoryAdjustmentTime
    WDesiredDeliveryRate <- WAdjustmentforInventory+WExpectedCustomerOrders
    WIndicatedOrders <- max(0,WAdjustmentforSupplyLine+WDesiredDeliveryRate)
    DCustomerOrders <- WIndicatedOrders
    DErrorTerm <- DCustomerOrders-DExpectedCustomerOrders
    DCECO <- DErrorTerm/DAdjustmentTime
    DDesiredDeliveryRate <- DAdjustmentforInventory+DExpectedCustomerOrders
    DIndicatedOrders <- max(0,DAdjustmentforSupplyLine+DDesiredDeliveryRate)
    DMinShipmentTime <- 1
    DMaximumShippedOrders <- DStock/DMinShipmentTime
    FCustomerOrders <- DIndicatedOrders
    FMinShipmentTime <- 1
    FMaximumShippedOrders <- FStock/FMinShipmentTime
    FShipmentRate <- min(FCustomerOrders,FMaximumShippedOrders)
    DOrderRate <- FShipmentRate
    DShipmentRate <- min(DCustomerOrders,DMaximumShippedOrders)
    FDeliveryDelay <- 4
    FAcquisitionRate <- FSupplyLine/FDeliveryDelay
    FDesiredInventory <- 400
    FALPHA <- 1
    FInventoryAdjustmentTime <- 1/FALPHA
    FAdjustmentforInventory <- (FDesiredInventory-FStock)/FInventoryAdjustmentTime
    FDesiredSupplyLine <- FDeliveryDelay*FExpectedCustomerOrders
    FBETA <- 0.05
    FSupplyLIneAdjustmentTime <- 1/FBETA
    FAdjustmentforSupplyLine <- (FDesiredSupplyLine-FSupplyLine)/FSupplyLIneAdjustmentTime
    FAdjustmentTime <- 1
    FErrorTerm <- FCustomerOrders-FExpectedCustomerOrders
    FCECO <- FErrorTerm/FAdjustmentTime
    FDesiredDeliveryRate <- FAdjustmentforInventory+FExpectedCustomerOrders
    FIndicatedOrders <- FAdjustmentforSupplyLine+FDesiredDeliveryRate
    FOrderRate <- max(0,FIndicatedOrders)
    InventoryAdjustmentTime <- 1/ALPHA
    MinShipmentTime <- 1
    RDeliveryDelay <- 4
    RAcquisitionRate <- RSupplyLine/RDeliveryDelay
    RDesiredInventory <- 400
    RALPHA <- 1
    RInventoryAdjustmentTime <- 1/RALPHA
    RAdjustmentforInventory <- (RDesiredInventory-RStock)/RInventoryAdjustmentTime
    RDesiredSupplyLine <- RDeliveryDelay*RExpectedCustomerOrders
    RBETA <- 0.05
    RSupplyLIneAdjustmentTime <- 1/RBETA
    RAdjustmentforSupplyLine <- (RDesiredSupplyLine-RSupplyLine)/RSupplyLIneAdjustmentTime
    RAdjustmentTime <- 1
    RCustomerOrders <- 100
    RErrorTerm <- RCustomerOrders-RExpectedCustomerOrders
    RCECO <- RErrorTerm/RAdjustmentTime
    RDesiredDeliveryRate <- RAdjustmentforInventory+RExpectedCustomerOrders
    RIndicatedOrders <- max(0,RAdjustmentforSupplyLine+RDesiredDeliveryRate)
    RMinShipmentTime <- 1
    RMaximumShippedOrders <- RStock/RMinShipmentTime
    WCustomerOrders <- RIndicatedOrders
    WMinShipmentTime <- 1
    WMaximumShippedOrders <- WStock/WMinShipmentTime
    WShipmentRate <- min(WCustomerOrders,WMaximumShippedOrders)
    ROrderRate <- WShipmentRate
    RShipmentRate <- min(RCustomerOrders,RMaximumShippedOrders)
    SupplyLIneAdjustmentTime <- 1/BETA
    WAcquisitionRate <- WSupplyLine/WDeliveryDelay
    WAdjustmentTime <- 1
    WErrorTerm <- WCustomerOrders-WExpectedCustomerOrders
    WCECO <- WErrorTerm/WAdjustmentTime
    WOrderRate <- DShipmentRate
    d_DT_DExpectedCustomerOrders  <- DCECO
    d_DT_DStock  <- DAcquisitionRate-DShipmentRate
    d_DT_DSupplyLine  <- DOrderRate-DAcquisitionRate
    d_DT_FExpectedCustomerOrders  <- FCECO
    d_DT_FStock  <- FAcquisitionRate-FShipmentRate
    d_DT_FSupplyLine  <- FOrderRate-FAcquisitionRate
    d_DT_RExpectedCustomerOrders  <- RCECO
    d_DT_RStock  <- RAcquisitionRate-RShipmentRate
    d_DT_RSupplyLine  <- ROrderRate-RAcquisitionRate
    d_DT_WExpectedCustomerOrders  <- WCECO
    d_DT_WStock  <- WAcquisitionRate-WShipmentRate
    d_DT_WSupplyLine  <- WOrderRate-WAcquisitionRate
    return (list(c(d_DT_DExpectedCustomerOrders,d_DT_DStock,d_DT_DSupplyLine,d_DT_FExpectedCustomerOrders,d_DT_FStock,d_DT_FSupplyLine,d_DT_RExpectedCustomerOrders,d_DT_RStock,d_DT_RSupplyLine,d_DT_WExpectedCustomerOrders,d_DT_WStock,d_DT_WSupplyLine)))
  })
}
# Function call to run simulation
o<-data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))
to<-gather(o,key=Stock,value=Value,2:ncol(o))
ggplot(data=to)+geom_line(aes(x=time,y=Value,colour=Stock))


#----------------------------------------------------
# Original text file exported from Vensim
#  D Expected Customer Orders = INTEG( D CECO , 100) 
#  D Stock = INTEG( D Acquisition Rate - D Shipment Rate , 400) 
#  D Supply Line = INTEG( D Order Rate - D Acquisition Rate , 400) 
#  F Expected Customer Orders = INTEG( F CECO , 100) 
#  F Stock = INTEG( F Acquisition Rate - F Shipment Rate , 400) 
#  F Supply Line = INTEG( F Order Rate - F Acquisition Rate , 400) 
#  R Expected Customer Orders = INTEG( R CECO , 100) 
#  R Stock = INTEG( R Acquisition Rate - R Shipment Rate , 400) 
#  R Supply Line = INTEG( R Order Rate - R Acquisition Rate , 400) 
#  W Expected Customer Orders = INTEG( W CECO , 100) 
#  W Stock = INTEG( W Acquisition Rate - W Shipment Rate , 400) 
#  W Supply Line = INTEG( W Order Rate - W Acquisition Rate , 400) 
#  ALPHA = 1
#  BETA = 0.05
#  D Delivery Delay = 4
#  D Acquisition Rate = D Supply Line / D Delivery Delay 
#  D Desired Inventory = 400
#  D ALPHA = 1
#  D Inventory Adjustment Time = 1 / D ALPHA 
#  D Adjustment for Inventory = ( D Desired Inventory - D Stock ) / D Inventory Adjustment Time
#  D Desired Supply Line = D Delivery Delay * D Expected Customer Orders 
#  D BETA = 0.05
#  D Supply LIne Adjustment Time = 1 / D BETA 
#  D Adjustment for Supply Line = ( D Desired Supply Line - D Supply Line ) / D Supply LIne Adjustment Time 
#  D Adjustment Time = 1
#  W Delivery Delay = 4
#  W Desired Supply Line = W Delivery Delay * W Expected Customer Orders 
#  W BETA = 0.05
#  W Supply LIne Adjustment Time = 1 / W BETA 
#  W Adjustment for Supply Line = ( W Desired Supply Line - W Supply Line ) / W Supply LIne Adjustment Time 
#  W Desired Inventory = 400
#  W ALPHA = 1
#  W Inventory Adjustment Time = 1 / W ALPHA 
#  W Adjustment for Inventory = ( W Desired Inventory - W Stock ) / W Inventory Adjustment Time
#  W Desired Delivery Rate = W Adjustment for Inventory + W Expected Customer Orders
#  W Indicated Orders = max ( 0, W Adjustment for Supply Line + W Desired Delivery Rate) 
#  D Customer Orders = W Indicated Orders 
#  D Error Term = D Customer Orders - D Expected Customer Orders 
#  D CECO = D Error Term / D Adjustment Time 
#  D Desired Delivery Rate = D Adjustment for Inventory + D Expected Customer Orders
#  D Indicated Orders = max ( 0, D Adjustment for Supply Line + D Desired Delivery Rate) 
#  D Min Shipment Time = 1
#  D Maximum Shipped Orders = D Stock / D Min Shipment Time 
#  F Customer Orders = D Indicated Orders 
#  F Min Shipment Time = 1
#  F Maximum Shipped Orders = F Stock / F Min Shipment Time 
#  F Shipment Rate = min ( F Customer Orders , F Maximum Shipped Orders ) 
#  D Order Rate = F Shipment Rate 
#  D Shipment Rate = min ( D Customer Orders , D Maximum Shipped Orders ) 
#  F Delivery Delay = 4
#  F Acquisition Rate = F Supply Line / F Delivery Delay 
#  F Desired Inventory = 400
#  F ALPHA = 1
#  F Inventory Adjustment Time = 1 / F ALPHA 
#  F Adjustment for Inventory = ( F Desired Inventory - F Stock ) / F Inventory Adjustment Time
#  F Desired Supply Line = F Delivery Delay * F Expected Customer Orders 
#  F BETA = 0.05
#  F Supply LIne Adjustment Time = 1 / F BETA 
#  F Adjustment for Supply Line = ( F Desired Supply Line - F Supply Line ) / F Supply LIne Adjustment Time 
#  F Adjustment Time = 1
#  F Error Term = F Customer Orders - F Expected Customer Orders 
#  F CECO = F Error Term / F Adjustment Time 
#  F Desired Delivery Rate = F Adjustment for Inventory + F Expected Customer Orders
#  F Indicated Orders = F Adjustment for Supply Line + F Desired Delivery Rate
#  F Order Rate = max ( 0, F Indicated Orders ) 
#  FINAL TIME = 40
#  INITIAL TIME = 0
#  Inventory Adjustment Time = 1 / ALPHA 
#  Min Shipment Time = 1
#  R Delivery Delay = 4
#  R Acquisition Rate = R Supply Line / R Delivery Delay 
#  R Desired Inventory = 400
#  R ALPHA = 1
#  R Inventory Adjustment Time = 1 / R ALPHA 
#  R Adjustment for Inventory = ( R Desired Inventory - R Stock ) / R Inventory Adjustment Time
#  R Desired Supply Line = R Delivery Delay * R Expected Customer Orders 
#  R BETA = 0.05
#  R Supply LIne Adjustment Time = 1 / R BETA 
#  R Adjustment for Supply Line = ( R Desired Supply Line - R Supply Line ) / R Supply LIne Adjustment Time 
#  R Adjustment Time = 1
#  R Customer Orders = 100 
#  R Error Term = R Customer Orders - R Expected Customer Orders 
#  R CECO = R Error Term / R Adjustment Time 
#  R Desired Delivery Rate = R Adjustment for Inventory + R Expected Customer Orders
#  R Indicated Orders = max ( 0, R Adjustment for Supply Line + R Desired Delivery Rate) 
#  R Min Shipment Time = 1
#  R Maximum Shipped Orders = R Stock / R Min Shipment Time 
#  W Customer Orders = R Indicated Orders 
#  W Min Shipment Time = 1
#  W Maximum Shipped Orders = W Stock / W Min Shipment Time 
#  W Shipment Rate = min ( W Customer Orders , W Maximum Shipped Orders ) 
#  R Order Rate = W Shipment Rate 
#  R Shipment Rate = min ( R Customer Orders , R Maximum Shipped Orders ) 
#  TIME STEP = 0.125
#  Supply LIne Adjustment Time = 1 / BETA 
#  W Acquisition Rate = W Supply Line / W Delivery Delay 
#  W Adjustment Time = 1
#  W Error Term = W Customer Orders - W Expected Customer Orders 
#  W CECO = W Error Term / W Adjustment Time 
#  W Order Rate = D Shipment Rate 
#----------------------------------------------------
