###########################################
# Translation of Vensim file.
# Date created: 2017-11-10 16:57:13
###########################################
library(deSolve)
library(ggplot2)
library(tidyr)
library(dplyr)
library(FME)
library(gridExtra)

#Displaying the simulation run parameters
START_TIME <- 0.000000
FINISH_TIME <- 80.00
TIME_STEP <- 0.125000
#Setting aux param to NULL
auxs<-NULL

#Generating the simulation time vector
simtime<-seq(START_TIME,FINISH_TIME,by=TIME_STEP)
# Writing global variables (stocks and dependent auxs)
stocks <-c( DExpectedCustomerOrders = 100 , 
            DStock = 400 , 
            DSupplyLine = 400 , 
            FExpectedCustomerOrders = 100 , 
            FStock = 400 , 
            FSupplyLine = 400 , 
            RExpectedCustomerOrders = 100 , 
            RStock = 400 , 
            RSupplyLine = 400 , 
            WExpectedCustomerOrders = 100 , 
            WStock = 400 , 
            WSupplyLine = 400 )

# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    DDeliveryDelay <- 4
    DAcquisitionRate <- DSupplyLine/DDeliveryDelay
    DDesiredInventory <- 400
    #DALPHA <- 1
    DInventoryAdjustmentTime <- 1/DALPHA
    DAdjustmentforInventory <- (DDesiredInventory-DStock)/DInventoryAdjustmentTime
    DDesiredSupplyLine <- DDeliveryDelay*DExpectedCustomerOrders
    #DBETA <- 0.05
    DSupplyLIneAdjustmentTime <- 1/DBETA
    DAdjustmentforSupplyLine <- (DDesiredSupplyLine-DSupplyLine)/DSupplyLIneAdjustmentTime
    DAdjustmentTime <- 1/DALPHA
    WDeliveryDelay <- 4
    WDesiredSupplyLine <- WDeliveryDelay*WExpectedCustomerOrders
    #WBETA <- 0.05
    WSupplyLIneAdjustmentTime <- 1/WBETA
    WAdjustmentforSupplyLine <- (WDesiredSupplyLine-WSupplyLine)/WSupplyLIneAdjustmentTime
    WDesiredInventory <- 400
    #WALPHA <- 1
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
    #FALPHA <- 1
    FInventoryAdjustmentTime <- 1/FALPHA
    FAdjustmentforInventory <- (FDesiredInventory-FStock)/FInventoryAdjustmentTime
    FDesiredSupplyLine <- FDeliveryDelay*FExpectedCustomerOrders
    #FBETA <- 0.05
    FSupplyLIneAdjustmentTime <- 1/FBETA
    FAdjustmentforSupplyLine <- (FDesiredSupplyLine-FSupplyLine)/FSupplyLIneAdjustmentTime
    FAdjustmentTime <- 1/FALPHA
    FErrorTerm <- FCustomerOrders-FExpectedCustomerOrders
    FCECO <- FErrorTerm/FAdjustmentTime
    FDesiredDeliveryRate <- FAdjustmentforInventory+FExpectedCustomerOrders
    FIndicatedOrders <- FAdjustmentforSupplyLine+FDesiredDeliveryRate
    FOrderRate <- max(0,FIndicatedOrders)
    RDeliveryDelay <- 4
    RAcquisitionRate <- RSupplyLine/RDeliveryDelay
    RDesiredInventory <- 400
    #RALPHA <- 1
    RInventoryAdjustmentTime <- 1/RALPHA
    RAdjustmentforInventory <- (RDesiredInventory-RStock)/RInventoryAdjustmentTime
    RDesiredSupplyLine <- RDeliveryDelay*RExpectedCustomerOrders
    #RBETA <- 0.05
    RSupplyLIneAdjustmentTime <- 1/RBETA
    RAdjustmentforSupplyLine <- (RDesiredSupplyLine-RSupplyLine)/RSupplyLIneAdjustmentTime
    RAdjustmentTime <- 1/RALPHA
    # Adding in the R version of a step function here
    if(time >= 10) RCustomerOrders <- 200 else RCustomerOrders <- 100
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
    WAcquisitionRate <- WSupplyLine/WDeliveryDelay
    WAdjustmentTime <- 1/WALPHA
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
    return (list(c(d_DT_DExpectedCustomerOrders,
                   d_DT_DStock,
                   d_DT_DSupplyLine,
                   d_DT_FExpectedCustomerOrders,
                   d_DT_FStock,
                   d_DT_FSupplyLine,
                   d_DT_RExpectedCustomerOrders,
                   d_DT_RStock,
                   d_DT_RSupplyLine,
                   d_DT_WExpectedCustomerOrders,
                   d_DT_WStock,
                   d_DT_WSupplyLine),
                   RCustomerOrders=RCustomerOrders,
                   WCustomerOrders=WCustomerOrders,
                   DCustomerOrders=DCustomerOrders,
                   FCustomerOrders=FCustomerOrders,
                   RBETA  = RBETA,
                   RALPHA = RALPHA,
                   WBETA  = WBETA,
                   WALPHA = WALPHA,
                   DBETA  = DBETA,
                   DALPHA = DALPHA,
                   FBETA  = FBETA,
                   FALPHA = FALPHA
                 ))
  })
}
# Function call to run simulation
nruns <- 200

R.ALPHA.MIN<-0;         R.ALPHA.MAX<-1.0
R.BETA.MIN<-0;          R.BETA.MAX<-1.0
W.ALPHA.MIN<-0;         W.ALPHA.MAX<-1.0
W.BETA.MIN<-0;          W.BETA.MAX<-1.0
D.ALPHA.MIN<-0;         D.ALPHA.MAX<-1.0
D.BETA.MIN<-0;          D.BETA.MAX<-1.0
F.ALPHA.MIN<-0;         F.ALPHA.MAX<-1.0
F.BETA.MIN<-0;          F.BETA.MAX<-1.0

parRange<-data.frame(
  min=c(R.ALPHA.MIN, 
        R.BETA.MIN,
        W.ALPHA.MIN, 
        W.BETA.MIN,
        D.ALPHA.MIN, 
        D.BETA.MIN,
        F.ALPHA.MIN, 
        F.BETA.MIN),
  max=c(R.ALPHA.MAX, 
        R.BETA.MAX,
        D.ALPHA.MAX, 
        D.BETA.MAX,
        W.ALPHA.MAX, 
        W.BETA.MAX,
        F.ALPHA.MAX, 
        F.BETA.MAX)
)

rownames(parRange)<-c("RALPHA",
                      "RBETA",
                      "WALPHA",
                      "WBETA",
                      "DALPHA",
                      "DBETA",
                      "FALPHA",
                      "FBETA")

run_info <-as_data_frame(data.frame(RunID=1:nruns,
                      Latinhyper(parRange,nruns)))

# MAybe sort by means...

apply(run_info,1,mean)

ans <- apply(run_info,1,function(x){
  cat("Simulation run...",x[["RunID"]],"\n")
  auxs <- x[-1]
  o<-as_data_frame(data.frame(ode(y=stocks,
                                  times=simtime,
                                  func=model,
                                  parms=auxs,
                                  method='euler')))
  o$RunID <- x[["RunID"]]
  o
})

# get all the required variables
ans <- as_data_frame(plyr::rbind.fill(ans))

# create a tidy data set based on actor, alpha and beta values
s1 <- select(ans,RunID,time,c(FStock,DStock,WStock,RStock,RBETA:FALPHA))

g_stocks <- gather(select(s1,RunID,time,c(FStock,DStock,WStock,RStock)),
                          key=Stock,value=Amount,FStock:RStock) 
g_stocks <- mutate(g_stocks,Key=1:nrow(g_stocks))

g_alpha <- gather(select(s1,RunID,time,c(FALPHA,DALPHA,WALPHA,RALPHA)),
                   key=AlphaSector,value=Alpha,FALPHA:RALPHA) 
g_alpha <- mutate(g_alpha,Key=1:nrow(g_alpha))

g_beta <- gather(select(s1,RunID,time,c(FBETA,DBETA,WBETA,RBETA)),
                  key=BetaSector,value=Beta,FBETA:RBETA)

g_beta <- mutate(g_beta,Key=1:nrow(g_beta))
res1 <- inner_join(g_stocks,g_alpha)

# This is the tidy data set
full_table <- inner_join(res1,g_beta)

# Plot all the runs
p10 <- ggplot(full_table,aes(x=time,y=Amount,color=RunID)) + 
  geom_point() + ylab("R Inventory") + scale_colour_gradientn(colours=rainbow(100))+
  xlab("")  + guides(color=FALSE) 
p11 <- ggplot(filter(full_table,Stock=="RStock"),aes(x=time,y=Amount,color=RunID)) + 
  geom_point() + ylab("R Inventory") + scale_colour_gradientn(colours=rainbow(100))+
  xlab("")  + guides(color=FALSE) 
p12 <- ggplot(filter(full_table,Stock=="WStock"),aes(x=time,y=Amount,color=RunID)) + 
  geom_point() + ylab("W Inventory") + scale_colour_gradientn(colours=rainbow(20))+
  xlab("")  + guides(color=FALSE) 
p13 <- ggplot(filter(full_table,Stock=="DStock"),aes(x=time,y=Amount,color=RunID)) + 
  geom_point() + ylab("D Inventory") + scale_colour_gradientn(colours=rainbow(20))+
  xlab("")  + guides(color=FALSE) 
p14 <- ggplot(filter(full_table,Stock=="FStock"),aes(x=time,y=Amount,color=RunID)) + 
  geom_point() + ylab("F Inventory") + scale_colour_gradientn(colours=rainbow(20))+
  xlab("")  + guides(color=FALSE) 

p1<-grid.arrange(p11, p12,p13,p14,nrow=2, ncol=2)

p2 <- ggplot(full_table,aes(x=time,y=Amount,color=Stock,group=RunID)) + 
  geom_path() + ylab("Inventory") + facet_wrap(~Stock)+
  xlab("Weeks")  + guides(color=FALSE) 

# Generate an x-y scatter on the max inventory values from each time step

agg_data <- full_table %>% 
              group_by(RunID,Stock) %>% 
              summarise(MaxStock=max(Amount),Alpha=unique(Alpha),Beta=unique(Beta))

p3 <- ggplot(agg_data,aes(x=Alpha,y=Beta,color=Stock,size=MaxStock)) + 
  geom_point() + ylab("Beta") +
  xlab("Alpha")  + guides(size=FALSE)

agg_data <- full_table %>% 
  group_by(RunID,Stock,AlphaSector) %>% 
  summarise(MaxStock=max(Amount),Alpha=unique(Alpha),Beta=unique(Beta))

p3 <- ggplot(agg_data,aes(x=Alpha,y=Beta,color=RunID,size=MaxStock)) + 
  geom_point() + ylab("Beta") + facet_wrap(~Stock)+
  scale_colour_gradientn(colours=rainbow(200))+
  xlab("Alpha")  + guides(size=FALSE)

