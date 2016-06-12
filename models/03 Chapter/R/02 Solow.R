library(deSolve)
library(ggplot2)
require(gridExtra)
source("lib/bMode.R")

#Hungarian notation is an identifier naming convention 
#in computer programming, in which the name of a variable or 
#function indicates its type or intended use. 

START   <-0; FINISH<-100; STEP<-0.25
simtime <- seq(START, FINISH, by=STEP)
stocks  <- c(sMachines=100)
auxs    <- c(aDepFraction=0.1, aLabour=100, aReinvestFraction=0.20)

m04_ecn <- function(time, stocks, auxs){
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


o<-data.frame(ode(y=stocks, times=simtime, func = m04_ecn, 
                  parms=auxs, method="euler"))

p1 <- qplot(time,sMachines,data=o,geom="line",color=I("blue"),
            ylab="Machines",xlab="Time")+
      geom_segment(aes(x=0,xend=100,y=40000,yend=40000),linetype=2)

ggsave("Fig3_6.png",dpi=1600)

o$d_machines_dt<-o$Investment - o$Discards
o$d_machines_dot_dt[2:length(o$time)]<-diff(o$d_machines_dt)/diff(o$time)
o$machines_bm<-bmode(o$d_machines_dt,o$d_machines_dot_dt)

p2<-ggplot(data=o,aes(x=o$time,y=o$sMachines,color=o$machines_bm))+
  geom_point(size=1)+ xlab("Time")+ylab("Machines")+
  theme(legend.position="bottom")+
  guides(color=guide_legend(title=NULL))

ggsave("Fig3_2.png",dpi=1600)




