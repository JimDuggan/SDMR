library(readr)
library(deSolve)
library(FME)
library(ggplot2)


data <- data.frame(read_csv("tidyverse/sdr_paper2/data/CalibrateStructures.csv"))

model <- function(time, stocks, auxs){
  LandRequiredPerBusiness <- 0.2
  TotalAvailableLand      <- 10000
    
  LandFractionOccupied <- stocks["BusinessStructures"]*LandRequiredPerBusiness/TotalAvailableLand
    
  EffectofLandFractionOccupiedonGrowthRate <- 1 - LandFractionOccupied
    
  ActualGrowthRate <- auxs["NormalGrowthRate"]*EffectofLandFractionOccupiedonGrowthRate

  BusinessConstruction <- ActualGrowthRate*stocks["BusinessStructures"]

  BusinessDemolition <- stocks["BusinessStructures"] * auxs["DemolitionFraction"]
    
  BusinessStructures <- BusinessConstruction-BusinessDemolition
    
  return (list(c(BusinessStructures)))   
}


solveModel <- function(pars){
  # All the stocks are initialised here...
  print("Running Model...")
  InitialStructures <- data[1,"BusinessStructures"]
  stocks            <- c(BusinessStructures=InitialStructures)

  auxs    <- c(NormalGrowthRate=unname(pars["NormalGrowthRate"]),
               DemolitionFraction=unname(pars["DemolitionFraction"]))
  
  return (data.frame(ode(y=stocks, simtime, func = model, 
                         parms=auxs, method="euler")))
}

getCost<-function(p)
{
  out  <-solveModel(p)
  cost <- modCost(obs=data,model=out)
}

START<-0; FINISH<-100; STEP<-0.125;
simtime <- seq(START, FINISH, by=STEP)

pars<-c(NormalGrowthRate=0.13,DemolitionFraction=0.01) 
lower<-c(0.00, 0.0)
upper<-c(0.30, 0.30)

Fit<-modFit(p=pars,f=getCost,lower=lower,upper=upper)

optPar<-c(Fit$par)
optMod <- solveModel(optPar)

time_points <-seq(from=1, to=length(simtime),by=1/STEP)
optMod      <-optMod[time_points,]

ggplot()+geom_path(data=optMod,aes(x=time,y=BusinessStructures),colour="red",size=2)+
  geom_point(data=data,aes(x=time,y=BusinessStructures),colour="blue")




