library(deSolve)

NUMBER_SECTORS    <- 5
NUMBER_STOCKS     <- 2
START <- 0; FINISH<-100; STEP<-0.125;
simtime <- seq(START, FINISH, by=STEP)
stocks  <- c(BusinessStructures_01=1000,
             BusinessStructures_02=1000,
             BusinessStructures_03=1000,
             BusinessStructures_04=1000,
             BusinessStructures_05=1000,
             BusinessesDemolished_01=0,
             BusinessesDemolished_02=0,
             BusinessesDemolished_03=0,
             BusinessesDemolished_04=0,
             BusinessesDemolished_05=0)
sector_names <- c("Sector_01", "Sector_02", "Sector_03","Sector_04","Sector_05")
                             
NormalGrowthRate        <- c(Sector_01=0.13,Sector_02=0.13,Sector_03=0.13,Sector_04=0.13,Sector_05=0.13) 
DemolitionFraction      <- c(Sector_01=0.01,Sector_02=0.01,Sector_03=0.01,Sector_04=0.01,Sector_05=0.01) 
LandRequiredPerBusiness <- c(Sector_01=0.2,Sector_02=0.2,Sector_03=0.01,Sector_04=0.01,Sector_05=0.01) 
TotalAvailableLand      <- c(Sector_01=1000,Sector_02=1000,Sector_03=1000,Sector_04=1000,Sector_05=1000) 

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{  
    states<-matrix(stocks,nrow=NUMBER_SECTORS,ncol=NUMBER_STOCKS)
    rownames(states) <- names(sector_names)
    colnames(states) <- c("BusinessStructures","BusinessesDemolished")
    
    LandFractionOccupied <- states[,"BusinessStructures"]*LandRequiredPerBusiness/TotalAvailableLand
    
    EffectofLandFractionOccupiedonGrowthRate <- 1 - LandFractionOccupied
    
    ActualGrowthRate <- NormalGrowthRate*EffectofLandFractionOccupiedonGrowthRate
    
    # Inflow
    BusinessConstruction <- ActualGrowthRate * states[,"BusinessStructures"]

    # Outflow
    BusinessDemolition <- states[,"BusinessStructures"] * DemolitionFraction
    
    # the net flow
    d_BusinessStructures_dt <-  BusinessConstruction-BusinessDemolition
    d_BusinessesDemolished_dt <-  BusinessDemolition
    
    return (list(c(d_BusinessStructures_dt,d_BusinessesDemolished_dt)))   
  })
}


o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=NULL, method="euler"))

