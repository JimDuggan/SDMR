library(deSolve)  
library(ggplot2) 


START<-0; FINISH<-20; STEP<-0.25; 

simtime <- seq(START, FINISH, by=STEP)

# Setup the step function in a global data frame
target <- rep(NA,length(simtime))
target[1:(10/STEP)]<-100
target[((10/STEP)+1):length(simtime)]<-200

simData<-data.frame(time=simtime, aTarget=target)

# model equations
model <- function(time, stocks, auxs)
{
  with(as.list(c(stocks, auxs)),{  
    
    index<-which(simData$time==time)

    aDisrepancy<-simData$aTarget[index] - sStock
    
    fRI<- aDisrepancy/ aAT
    
    dS_dt  <- fRI
    
    return (list(c(dS_dt),
                 Target=simData$aTarget[index],
                 Inflow=fRI,
                 AT=aAT))   
  })
}

stocks  <- c(sStock=0)
auxs    <- c(aAT=1)


o<-data.frame(ode(y=stocks, simtime, func = model, 
                  parms=auxs, method="euler"))

p1<-qplot(data=o,x=o$time,y=o$sStock,
      geom=c("line","point"),xlab="Time",ylab="Stock")

p2<-qplot(data=o,x=o$time,y=o$Target,
          geom=c("line","point"),xlab="Time",ylab="Target")



