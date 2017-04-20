library(deSolve)
library(ggplot2)
require(gridExtra)

derivn<-function(voi,time){
  c(0.0,diff(voi)/diff(time))
}

abm<-function(v){
  ifelse(v==0.0,"LIN",
         ifelse(v<0,"LOG","EXP"))
}

START<-0; FINISH<-100; STEP<-0.25

simtime <- seq(START, FINISH, by=STEP)
stocks  <- c(sStock=100)
auxs    <- c(aCapacity=10000, aRef.Availability=1, aRef.GrowthRate=0.10)

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    aAvailability <- 1 - sStock / aCapacity
    aEffect <- aAvailability / aRef.Availability
    aGrowth.Rate <- aRef.GrowthRate * aEffect
    
    fNet.Flow <- sStock * aGrowth.Rate
    
    d_sStock_dt  <- fNet.Flow
  
    return (list(c(d_sStock_dt),
                 NetFlow=fNet.Flow,
                 GrowthRate=aGrowth.Rate,
                 Effect=aEffect, 
                 Availability=aAvailability))   
  })
}


o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                       parms=auxs, method="euler"))

o$abm<-derivn(abs(o$NetFlow),o$time)

o$bmode<-abm(o$abm)


p1<-ggplot()+
  geom_point(data=o,aes(time,o$sStock,colour=o$bmode))+
  ylab("Stock")+
  xlab("Year") +
  guides(color=guide_legend(title=NULL))+
  theme(legend.position="top")

