library(deSolve)  
library(ggplot2) 


START<-0; FINISH<-20; STEP<-0.125; 

simtime <- seq(START, FINISH, by=STEP)

getTarget<-function(time){
  if(time < 10)
    100 else 200
}

model <- function(time, stocks, auxs)
{
  with(as.list(c(stocks, auxs)),{  

    aDisrepancy<-getTarget(time) - sStock
    
    fRI<- aDisrepancy/ aAT
    
    dS_dt  <- fRI
    
    return (list(c(dS_dt),
                 Target=getTarget(time),
                 Inflow=fRI,
                 AT=aAT))   
  })
}


stocks  <- c(sStock=0)

auxs    <- c(aAT=1)


o<-data.frame(ode(y=stocks, simtime, func = model, 
                  parms=auxs, method="euler"))

qplot(data=o,x=o$time,y=o$sStock,
      geom=c("line","point"),xlab="Time",ylab="Stock")



