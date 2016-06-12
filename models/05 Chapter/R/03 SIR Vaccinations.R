library(deSolve)
library(ggplot2)
require(gridExtra)
library(scales)

START<-0; FINISH<-20; STEP<-0.125;
NUM_COHORTS<-3; NUM_STATES<-3
simtime <- seq(START, FINISH, by=STEP)


CE  <- matrix(c(3.0, 2.0, 1.0,
                2.0, 2.0, 1.0,
                1.0, 1.0, 0.5),
                nrow=3,ncol=3,byrow=TRUE)

CohortPopulatons<- c(25000,50000,25000)

beta <- CE/CohortPopulatons

#Setup the model variables
stocks <- c(SusceptibleY=24999, SusceptibleA=50000, SusceptibleE=25000,  
            InfectedY=1,        InfectedA=0,        InfectedE=0,
            RecoveredY=0,       RecoveredA=0,       RecoveredE=0)

stocks.vy <- c(SusceptibleY=4999,  SusceptibleA=50000, SusceptibleE=25000,  
               InfectedY=1,        InfectedA=0,        InfectedE=0,
               RecoveredY=20000,   RecoveredA=0,       RecoveredE=0)

stocks.va <- c(SusceptibleY=24999, SusceptibleA=30000, SusceptibleE=25000,  
               InfectedY=1,        InfectedA=0,        InfectedE=0,
               RecoveredY=0,       RecoveredA=20000,       RecoveredE=0)

stocks.ve <- c(SusceptibleY=24999, SusceptibleA=50000, SusceptibleE=5000,  
               InfectedY=1,        InfectedA=0,        InfectedE=0,
               RecoveredY=0,       RecoveredA=0,       RecoveredE=20000)

delays <- c(Young=2.0, Adult=2.0, Elderly=2.0)

auxs <-NULL

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    #convert the stocks vector to a matrix
    states<-matrix(stocks,nrow=NUM_COHORTS,ncol=NUM_STATES)

    
    Susceptible <- states[,1]
    Infected    <- states[,2]
    Recovered   <- states[,3]
    
    Lambda      <- beta %*% Infected
    
    IR         <- Lambda * Susceptible
    RR         <- Infected / delays
    
    dS_dt  <- -IR
    dI_dt  <- IR - RR
    dR_dt  <- RR
    
    return (list(c(dS_dt, dI_dt, dR_dt)))  
  })
}

o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=auxs, method="euler"))
o$TotalInfected<-o$InfectedY+o$InfectedA+o$InfectedE

o.vy<-data.frame(ode(y=stocks.vy, times=simtime, func = model, 
                  parms=auxs, method="euler"))
o.vy$TotalInfected<-o.vy$InfectedY+o.vy$InfectedA+o.vy$InfectedE

o.va<-data.frame(ode(y=stocks.va, times=simtime, func = model, 
                     parms=auxs, method="euler"))
o.va$TotalInfected<-o.va$InfectedY+o.va$InfectedA+o.va$InfectedE

o.ve<-data.frame(ode(y=stocks.ve, times=simtime, func = model, 
                     parms=auxs, method="euler"))
o.ve$TotalInfected<-o.ve$InfectedY+o.ve$InfectedA+o.ve$InfectedE

p1<-ggplot()+
  geom_line(data=o.vy,size=1,aes(time,o.vy$TotalInfected,color="Young"))+
  geom_line(data=o.va,size=1,aes(time,o.va$TotalInfected,color="Adults"))+
  geom_line(data=o.ve,size=1,aes(time,o.ve$TotalInfected,color="Elderly"))+
  geom_line(data=o,size=1,aes(time,o$TotalInfected,color="Baseline"))+
    scale_y_continuous(labels = comma)+
  ylab("Infected")+
  xlab("Day") +
  labs(color="")+
  theme(legend.position="bottom")

ggsave(file="Fig5_7.png", dpi=1600,p1) #saves g



