library(deSolve)  
library(ggplot2) 

# Model equations (from Vensim)
# INITIAL TIME  = 0
# FINAL TIME  = 25
# Inflow=100+step(100,4)
# Outflow=Stock/Time Delay
# Stock= INTEG (Inflow-Outflow, 400)
# Time Delay=4
# TIME STEP  = 0.125

START<-0; FINISH<-25; STEP<-0.125; 
simtime <- seq(START, FINISH, by=STEP)

# Setup the step function in a global data frame
input <- rep(NA,length(simtime))
input[1:(4/STEP)]<-100
input[((4/STEP)+1):length(simtime)]<-200

simData<-data.frame(time=simtime, aInput=input)

# model equations
model <- function(time, stocks, auxs)
{
  with(as.list(c(stocks, auxs)),{  
    index<-which(simData$time==time)

    fInflow<-simData$aInput[index]
    fOutflow<-sStock/aTimeDelay
    
    dS_dt  <- fInflow - fOutflow
    
    return (list(c(dS_dt),
                 Inflow=fInflow,
                 Outflow=fOutflow))   
  })
}

stocks  <- c(sStock=400)
auxs    <- c(aTimeDelay=4)


o<-data.frame(ode(y=stocks, simtime, func = model, 
                  parms=auxs, method="euler"))

p1<-qplot(data=o,x=o$time,y=o$sStock,
      geom=c("line","point"),xlab="Time",ylab="Stock")

p2<-qplot(data=o,x=o$time,y=o$Inflow,
          geom=c("line","point"),xlab="Time",ylab="Inflow")

p3<-qplot(data=o,x=o$time,y=o$Outflow,
          geom=c("line","point"),xlab="Time",ylab="Outflow")



