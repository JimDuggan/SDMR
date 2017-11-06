library(deSolve)
library(ggplot2)
library(plyr)


# Create the start time, finish time, and time step
START<-0; FINISH<-75; STEP<-1/16

# Create time vector
simtime <- seq(START, FINISH, by=STEP)

# Create stocks vector, with initial values
stocks  <- c(sSusceptible=99999,sInfected=1,sRecovered=0)

# Write callback function (model equations)
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    aBeta <- aEffective.Contact.Rate / aTotalPopulation
    aLambda <- aBeta * sInfected
    
    fIR <- sSusceptible * aLambda
    fRR <- sInfected / aDelay
    
    d_sSusceptible_dt  <- -fIR
    d_sInfected_dt     <- fIR - fRR
    d_sRecovered_dt    <- fRR
  
    return (list(c(d_sSusceptible_dt,d_sInfected_dt,d_sRecovered_dt),
                 IR=fIR, RR=fRR,Beta=aBeta,Lambda=aLambda,
                 CE=aEffective.Contact.Rate,
                 DEL=aDelay))   
  })
}


NRUNS     <- 50
LOWER_EFC <- 0; UPPER_EFC=10;
LOWER_DEL <- 0; UPPER_DEL=10;


run_info <- data.frame(
    RunID = 1:NRUNS,
    aEffective.Contact.Rate=runif(NRUNS,LOWER_EFC,UPPER_EFC),
    aDelay=runif(NRUNS,LOWER_DEL,UPPER_DEL)
)
  
ans <- apply(run_info,1,function(x){
  auxs<-c(aTotalPopulation=100000,
          aEffective.Contact.Rate=x[["aEffective.Contact.Rate"]],
          aDelay=x[["aDelay"]])
  o<-data.frame(ode(y=stocks,
                    times=simtime,
                    func=model,
                    parms=auxs,method='euler'))
  o$RunID <- x[["RunID"]]
  o
})


ans_df <- rbind.fill(ans)

ggplot(ans_df,aes(x=time,y=sInfected,color=RunID)) + 
  geom_path() + scale_colour_gradientn(colours=rainbow(10))+
  ylab("Infected") +
  xlab("Time (Days)")  + guides(color=FALSE) 


m_data<-lapply(ans,function(x){
  data.frame(MaxInfected=max(x$sInfected),
             ECR=unique(x$CE),
             DEL=unique(x$DEL))
})


m_data_df <-rbind.fill(m_data)

ggplot(data=m_data_df)+
  geom_point(aes(x=ECR,y=DEL,colour=MaxInfected,size=MaxInfected))+
  scale_colour_gradientn(colours=rainbow(10))




