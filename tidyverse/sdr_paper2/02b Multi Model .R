library(deSolve)
library(dplyr)
library(tidyr)
library(ggplot2)

START <- 0; FINISH<-100; STEP<-0.125;
simtime <- seq(START, FINISH, by=STEP)

ARRAY_SIZE<- 5; NUMBER_STOCKS     <- 2
stocks  <- c(BStructures_01=1000,
             BStructures_02=1000,
             BStructures_03=1000,
             BStructures_04=1000,
             BStructures_05=1000,
             BDemolished_01=0,
             BDemolished_02=0,
             BDemolished_03=0,
             BDemolished_04=0,
             BDemolished_05=0)

array_names <- c("Array_01", "Array_02", "Array_03","Array_04","Array_05")
                             
NormalGrowthRate        <- c(Array_01=0.13,Array_02=0.12,Array_03=0.11,Array_04=0.10,Array_05=0.09) 
DemolitionFraction      <- c(Array_01=0.01,Array_02=0.02,Array_03=0.03,Array_04=0.04,Array_05=0.05) 
LandRequiredPerBusiness <- c(Array_01=0.2,Array_02=0.2,Array_03=0.2,Array_04=0.2,Array_05=0.2) 
TotalAvailableLand      <- c(Array_01=10000,Array_02=11000,Array_03=12000,Array_04=13000,Array_05=14000) 

model <- function(time, stocks, auxs){
  states<-matrix(stocks,nrow=ARRAY_SIZE,ncol=NUMBER_STOCKS)
  rownames(states) <- array_names
  colnames(states) <- c("BusinessStructures","BusinessesDemolished")


  LandFractionOccupied <- states[,"BusinessStructures"]*
                            LandRequiredPerBusiness/TotalAvailableLand
  
  EffectofLandFractionOccupiedonGrowthRate <- 1 - LandFractionOccupied
    
  ActualGrowthRate <- NormalGrowthRate*EffectofLandFractionOccupiedonGrowthRate
    
  # Inflow
  BusinessConstruction <- ActualGrowthRate * states[,"BusinessStructures"]

  # Outflow
  BusinessDemolition <- states[,"BusinessStructures"] * DemolitionFraction
    
  # the net flow
  d_BusinessStructures_dt <-  BusinessConstruction - BusinessDemolition
  d_BusinessesDemolished_dt <-  BusinessDemolition
    
  return (list(c(d_BusinessStructures_dt,d_BusinessesDemolished_dt)))   
}

o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=NULL, method="euler"))

tidy_o <- select(o,time, contains("BStructures")) %>%
          gather(key = ModelVariable, value = Value, 
                 BStructures_01:BStructures_05)

fig.8 <- ggplot(tidy_o,aes(x=time,y=Value,colour=ModelVariable))+geom_path()+
  ylab("Business Structures")+xlab("Year")+
  theme(legend.position = "bottom")

tidy_o_2 <- tidy_o[c(T,F,F,F,F,F,F,F), ]

fig.8b <- ggplot(tidy_o_2,aes(x=time,y=Value,colour=ModelVariable,shape=ModelVariable))+geom_path()+
  geom_point()+
  ylab("Business Structures")+xlab("Year")+
  theme(legend.position = "bottom")

ggsave("08_Figure.eps", dpi=600,plot = fig.8,height=4,width=6,units="in")
ggsave("08b_Figure.eps", dpi=600,plot = fig.8b,height=4,width=6,units="in")

