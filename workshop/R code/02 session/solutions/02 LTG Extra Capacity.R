library(deSolve)
library(ggplot2)
require(gridExtra)

START<-0; FINISH<-200; STEP<-0.25

simtime <- seq(START, FINISH, by=STEP)
stocks  <- c(sStock=100)
auxs    <- c(aRef.Availability=1, aRef.GrowthRate=0.10)

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    if(time <=100) aCapacity=10000 else aCapacity = 20000
    aAvailability <- 1 - sStock / aCapacity
    aEffect <- aAvailability / aRef.Availability
    aGrowth.Rate <- aRef.GrowthRate * aEffect
    
    fNet.Flow <- sStock * aGrowth.Rate
    
    d_sStock_dt  <- fNet.Flow
  
    return (list(c(d_sStock_dt),
                 NetFlow=fNet.Flow,
                 GrowthRate=aGrowth.Rate,
                 Effect=aEffect, 
                 Capacity=aCapacity,
                 Availability=aAvailability))   
  })
}


o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                       parms=auxs, method="euler"))

plot3 <- qplot(time,NetFlow,data=o,geom="line",color=I("red"))
plot1 <- qplot(time,sStock,data=o,geom="line",color=I("blue"),ylab="Stock")
plot2 <- qplot(time,Availability,data=o,geom="line",color=I("green"),ylab="Availability")
plot4 <- qplot(time,GrowthRate,data=o,geom="line",color=I("black"),ylab="Growth Rate")
grid.arrange(plot1, plot2, plot3, plot4, nrow=2, ncol=2)

