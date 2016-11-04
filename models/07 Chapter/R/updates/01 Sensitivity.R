library(deSolve)
library(ggplot2)
library(FME)
library(plyr)


runsim <- function(rvec){
  # this is the model function
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
  
  # setup the individual simulation run
  START<-0; FINISH<-20; STEP<-0.01; 
  simtime <- seq(START, FINISH, by=STEP)
  
  init<-rvec[["initInfected"]]
  
  a<-c(aTotalPopulation=10000,rvec["aEffective.Contact.Rate"],
       rvec["aDelay"],rvec["initInfected"])
  
  stocks  <- c(sSusceptible=10000-init,sInfected=init,sRecovered=0)
  
  o<-data.frame(ode(y=stocks, simtime, func = model, 
                    parms=a, method="euler"))
  o$RunNumber<-rvec["RunNo"]
  o
}


CE.MIN<-0;          CE.MAX<-7.0
DEL.MIN<-1.0;       DEL.MAX<-10.0
INIT.INF.MIN<-1.0;  INIT.INF.MAX<-25.0;

parRange<-data.frame(
  min=c(CE.MIN, DEL.MIN, INIT.INF.MIN),
  max=c(CE.MAX, DEL.MAX, INIT.INF.MAX)
)

rownames(parRange)<-c("aEffective.Contact.Rate","aDelay","initInfected")

NRUNS<-10
p<-data.frame(RunNo=1:NRUNS,Latinhyper(parRange,NRUNS))

out<-apply(p,1,function(x)runsim(x))

df<-rbind.fill(out)

ggplot(df,aes(x=time,y=sInfected,color=RunNumber)) + 
  geom_path() + scale_colour_gradientn(colours=rainbow(10))+
  ylab("Infected") +
  xlab("Time (Days)")  + guides(color=FALSE) 

ggplot(df,aes(x=time,y=sInfected,color=RunNumber,group=RunNumber)) + 
  geom_line() +
  scale_colour_gradientn(colours=rainbow(10))+
  ylab("Infected") +
  xlab("Time (Days)")  + guides(color=FALSE) 
