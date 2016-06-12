library(deSolve)
library(ggplot2)
require(gridExtra)

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
  
    dS_dt  <- fNet.Flow
    
    return (list(c(dS_dt),
                 NetFlow=fNet.Flow,
                 GrowthRate=aGrowth.Rate,
                 Effect=aEffect, 
                 Availability=aAvailability))   
  })
}


deriv<-function(yvar, xvar){
  ans<-vector(length=length(yvar))
  ans[1]<-0.0
  ans[2:length(ans)]<-diff(yvar)/diff(xvar)
  return(ans)
}

polarity<-function(flow, stock){
  lsign<-sign(deriv(flow,stock))
  ifelse(lsign<0,"NEG","POS")
}



o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                       parms=auxs, method="euler"))

o$polarity<-polarity(o$NetFlow, o$sStock)

ggplot(o,aes(x=o$time,y=o$sStock))+
         geom_point(aes(color=o$polarity))+
         guides(color=guide_legend(title=NULL))+
         xlab("Time")+ylab("Stock")


