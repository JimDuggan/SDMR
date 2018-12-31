library(deSolve)

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{  
    LandFractionOccupied <- BusinessStructures*LandRequiredPerBusiness/TotalAvailableLand
    
    EffectofLandFractionOccupiedonGrowthRate <- 1 - LandFractionOccupied
    
    ActualGrowthRate <- NormalGrowthRate*EffectofLandFractionOccupiedonGrowthRate
    
    # Outflow
    BusinessConstruction <- ActualGrowthRate*BusinessStructures

    # Outflow
    BusinessDemolition <- BusinessStructures * DemolitionFraction
    
    # the net flow
    d_BusinessStructures_dt <- BusinessConstruction-BusinessDemolition
    
    return (list(c(d_BusinessStructures_dt)))   
  })
}


START<-0; FINISH<-100; STEP<-0.125;

simtime <- seq(START, FINISH, by=STEP)

auxs    <- c(NormalGrowthRate=0.13, 
             DemolitionFraction=0.01,
             LandRequiredPerBusiness=0.2,
             TotalAvailableLand=10000)

InitialStructures <- 1000
stocks            <- c(BusinessStructures=InitialStructures)

o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=auxs, method="euler"))

