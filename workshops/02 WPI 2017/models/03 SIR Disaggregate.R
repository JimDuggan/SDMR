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
    colnames(states) <- c("Susceptible","Infected","Recovered")
    rownames(states) <- c("Young","Adult","Elderly")
    
    browser()
    
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

p1<-ggplot()+
  geom_line(data=o,size=1,aes(time,o$InfectedY,color="1. Young"))+
  geom_line(data=o,size=1,aes(time,o$InfectedA,color="2. Adult"))+
  geom_line(data=o,size=1,aes(time,o$InfectedE,color="3. Elderly"))+
  geom_line(data=o,size=1,aes(time,o$TotalInfected,color="4. Total"))+
    scale_y_continuous(labels = comma)+
  ylab("Infected")+
  xlab("Day") +
  labs(color="")+
  theme(legend.position="bottom")





