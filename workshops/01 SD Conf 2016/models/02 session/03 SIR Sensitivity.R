library(deSolve)
library(ggplot2)
require(gridExtra)
library(scales)
library(FME)
library(plyr)

START<-0; FINISH<-50; STEP<-0.125; 

simtime <- seq(START, FINISH, by=STEP)

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    aBeta <- aEffective.Contact.Rate / aTotalPopulation
    aLambda <- aBeta * sInfected
    
    fIR <- sSusceptible * aLambda
    fRR <- sInfected / aDelay
    
    dS_dt  <- -fIR
    dI_dt  <- fIR - fRR
    dR_dt  <- fRR
    
    return (list(c(dS_dt,dI_dt,dR_dt),
                 IR=fIR, RR=fRR,Beta=aBeta,Lambda=aLambda,DEL=aDelay,
                 CE=aEffective.Contact.Rate,InitI=initInfected))   
  })
}

# setup the parameter data frame
CE.MIN<-0;          CE.MAX<-7.0
DEL.MIN<-1.0;       DEL.MAX<-10.0
INIT.INF.MIN<-1.0;  INIT.INF.MAX<-25.0;

parRange<-data.frame(
  min=c(CE.MIN, DEL.MIN, INIT.INF.MIN),
  max=c(CE.MAX, DEL.MAX, INIT.INF.MAX)
)
rownames(parRange)<-c("aEffective.Contact.Rate",
                      "aDelay",
                      "initInfected")

g.simRuns<-list()
sensRun<-function(p){
  
  g.simRuns<<-list(length=nrow(p))

  for(i in 1:nrow(p)){
    print("Simulating..\n")
    
    init<-p[i,"initInfected"]

    a<-c(aTotalPopulation=10000,p[i,1:3])
    
    stocks  <- c(sSusceptible=10000-init,sInfected=init,sRecovered=0)

    o<-data.frame(ode(y=stocks, simtime, func = model, 
                      parms=a, method="euler"))
    o$run<-i
    g.simRuns[[i]]<<-o
  }
}

NRUNS<-200
p<-data.frame(Latinhyper(parRange,NRUNS))
sensRun(p)

df<-rbind.fill(g.simRuns)

p1<-ggplot(df,aes(x=time,y=sInfected,color=run,group=run)) + 
  geom_line() +
  ylab("Infected") +
  xlab("Time (Days)")  + guides(color=FALSE) 
