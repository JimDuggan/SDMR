library(deSolve)


library(ggplot2)
library(scales)

START<-0; FINISH<-20; STEP<-0.01;
simtime <- seq(START, FINISH, by=STEP)
stocks  <- c(sPotentialAdopters=99999,sAdopters=1)
auxs    <- c(aTotalPopulation=100000, aContact.Rate=6, aInfectivity=0.25)


model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    print(time)
    aBeta <- aContact.Rate * aInfectivity/ aTotalPopulation
    aRho <- aBeta * sAdopters
    
    fAR <- sPotentialAdopters * aRho
    
    dPA_dt  <- -fAR
    dA_dt   <- fAR
    
    rvals<-list(c(dPA_dt, dA_dt),
                AR=fAR, Rho=aRho)
    return (rvals)   
  })
}


o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=auxs, method="euler"))

index<-seq(from=1, to=length(simtime),by=1/STEP)


o[index[1:11],]


p1<-ggplot()+
  geom_line(data=o,aes(time,o$sPotentialAdopters,color="1. Potential Adopters"))+
  geom_line(data=o,aes(time,o$sAdopters,color="2. Adopters"))+
  scale_y_continuous(labels = comma)+
  ylab("Model Stocks")+
  xlab("Weeks") +
  labs(color="")+
  theme(legend.position="bottom")


