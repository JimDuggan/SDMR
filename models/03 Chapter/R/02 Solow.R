library(deSolve)
library(ggplot2)
require(gridExtra)


START   <-0; FINISH<-100; STEP<-0.25
simtime <- seq(START, FINISH, by=STEP)
stocks  <- c(sMachines=100)
auxs    <- c(aDepFraction=0.1, aLabour=100, aReinvestFraction=0.20)

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    
    aEconomicOutput <- aLabour * sqrt(sMachines)
    fInvestment     <- aEconomicOutput * aReinvestFraction
    fDiscards       <- sMachines * aDepFraction
    
    d_sMachines_dt  <- fInvestment - fDiscards
  
    return (list(c(d_sMachines_dt),
                 Investment=fInvestment,
                 Discards=fDiscards,
                 EconomicOutput=aEconomicOutput))   
  })
}


o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=auxs, method="euler"))

p1 <- qplot(time,sMachines,data=o,geom="line",color=I("blue"),
            ylab="Machines",xlab="Time")+
      geom_segment(aes(x=0,xend=100,y=40000,yend=40000),linetype=2)




