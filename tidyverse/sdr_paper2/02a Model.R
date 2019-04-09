library(deSolve)
library(dplyr)

model <- function(time, stocks, auxs){
  LandFractionOccupied <- stocks["BusinessStructures"] *
                          auxs["LandRequiredPerBusiness"]/auxs["TotalAvailableLand"]
    
  EffectofLandFractionOccupiedonGrowthRate <- 1 - LandFractionOccupied
    
  ActualGrowthRate <- auxs["NormalGrowthRate"]*EffectofLandFractionOccupiedonGrowthRate
    
  # Outflow
  BusinessConstruction <- ActualGrowthRate*stocks["BusinessStructures"]

  # Outflow
  BusinessDemolition <- stocks["BusinessStructures"] * auxs["DemolitionFraction"]
    
    # the net flow
  d_BusinessStructures_dt <- BusinessConstruction-BusinessDemolition
    
  return (list(c(d_BusinessStructures_dt)))   
}


START<-0; FINISH<-100; STEP<-0.125;

simtime <- seq(START, FINISH, by=STEP)

auxs    <- c(NormalGrowthRate=0.13, 
             DemolitionFraction=0.01,
             LandRequiredPerBusiness=0.2,
             TotalAvailableLand=10000)

InitialStructures <- 1000
stocks            <- c(BusinessStructures=InitialStructures)

o<-tibble::as_data_frame(ode(y=stocks, times=simtime, func = model, 
                         parms=auxs, method="euler"))

