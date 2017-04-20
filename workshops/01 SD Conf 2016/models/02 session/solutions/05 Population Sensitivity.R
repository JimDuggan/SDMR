library(deSolve)
library(ggplot2)
library(scales)
library(FME)
library(plyr)

START<-2015; FINISH<-2030; STEP<-0.25

simtime <- seq(START, FINISH, by=STEP)

# The model
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    
    fPopulationAdded<-sPopulation*aGrowthFraction
    
    
    dP_dt <- fPopulationAdded
    
    return (list(c(dP_dt),
                 Additions=fPopulationAdded,GF=aGrowthFraction))   
  })
}

GF.MIN<- -0.07; GF.MAX<-0.07

parRange<-data.frame(
  min=c(GF.MIN),
  max=c(GF.MAX)
)
rownames(parRange)<-c("aGrowthFraction")

g.simRuns<-list()
sensRun<-function(p){
  
  g.simRuns<<-list(length=nrow(p))
  
  for(i in 1:nrow(p)){
    
    a<-c(aGrowthFraction=p[i,"aGrowthFraction"])
    
    stocks  <- c(sPopulation=10000)
    
    o<-data.frame(ode(y=stocks, simtime, func = model, 
                      parms=a, method="euler"))
    o$run<-i
    g.simRuns[[i]]<<-o
  }
}

NRUNS<-500
p<-data.frame(Latinhyper(parRange,NRUNS))
sensRun(p)

df<-rbind.fill(g.simRuns)

p1<-ggplot(df,aes(x=time,y=sPopulation,color=run,group=run)) + 
  geom_line() +
  ylab("Population") +
  xlab("Time (Days)")  + guides(color=FALSE) 
