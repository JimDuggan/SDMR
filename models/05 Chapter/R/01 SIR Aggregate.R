#   FILE:     01 SIR Aggregate.R
#   Author:   Jim Duggan
#   Date:     April 3rd 2016
#   Description:
#   This file implements the classic SIR Model in R, using the deSolve library
#
#   Ref: Soetaert, K. E. R., Petzoldt, T., & Setzer, R. W. 2010. 
#       Solving differential equations in R: pack-age deSolve. 
#       Journal of Statistical Software, 33.

library(deSolve)
library(ggplot2)
require(gridExtra)
library(scales)

# Create the start time, finish time, and time step
START<-0; FINISH<-20; STEP<-0.125

# Create time vector
simtime <- seq(START, FINISH, by=STEP)

# Create stocks vector, with initial values
stocks  <- c(sSusceptible=99999,sInfected=1,sRecovered=0)

# Create auxiliaries vector, with values
auxs    <- c(aTotalPopulation=100000, aEffective.Contact.Rate=2, aDelay=2)

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
                 CE=aEffective.Contact.Rate))   
  })
}

# Call Solver, and store results in a data frame
o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=auxs, method="euler"))

# PLot output
p1<-ggplot()+
  geom_line(data=o,aes(time,o$sSusceptible,color="1. Susceptible"))+
  geom_line(data=o,aes(time,o$sInfected,color="2. Infected"))+
  geom_line(data=o,aes(time,o$sRecovered,color="3. Recovered"))+
  scale_y_continuous(labels = comma)+
  ylab("System Stocks")+
  xlab("Day") +
  labs(color="")+
  theme(legend.position="bottom")

p2<-ggplot()+
  geom_line(data=o,aes(time,o$IR,color="Infection Rate"))+
  geom_line(data=o,aes(time,o$RR,color="Recovery Rate"))+
  scale_y_continuous(labels = comma)+
  ylab("System Flows")+
  xlab("Day") +
  labs(color="")+
  theme(legend.position="bottom")

grid.arrange(p2, p1,nrow=1, ncol=2)
