library(deSolve)
library(ggplot2)
require(gridExtra)
library(scales)

START<-2015; FINISH<-2050; STEP<-0.125;
NUM_COHORTS<-3; NUM_STATES<-5
simtime <- seq(START, FINISH, by=STEP)

CE  <- matrix(c(3.0, 2.0, 1.0,
                2.0, 2.0, 1.0,
                1.0, 1.0, 0.5),
                nrow=3,ncol=3,byrow=TRUE)

CohortPopulatons<- c(25000,50000,25000)

beta <- CE/CohortPopulatons

#Setup the model variables
stocks <- c(Coh.A.00_19=24999, Cohort.B.00_19=50000, 
            Coh.C.00_19=25000,
            Coh.D.00_19=25000,
            Cohort.E.00_19=25000,
            
            InfectedY=1,        InfectedA=0,        InfectedE=0,
            RecoveredY=0,       RecoveredA=0,       RecoveredE=0)

birth.rates <- c(area1=, Adult=2.0, Elderly=2.0)
death.rates <- c(Young=2.0, Adult=2.0, Elderly=2.0)


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




