# File:    Customers.R
# Author:  Jim Duggan
# Summary: One-stock example of customers , with fraction increases/descreases

library(deSolve)
library(ggplot2)
require(gridExtra)
library(scales)

# Setup simulation times and time step
START<-2015; FINISH<-2030; STEP<-0.25

# Create time vector
simtime <- seq(START, FINISH, by=STEP)

# Create stock and auxs
stocks  <- c(sCustomers=10000)
auxs    <- c(aGrowthFraction=0.08, aDeclineFraction=0.03)


# Model function
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    
    fRecruits<-sCustomers*aGrowthFraction
    
    fLosses<-sCustomers*aDeclineFraction
    
    dC_dt <- fRecruits - fLosses
    
    return (list(c(dC_dt),
                 Recruits=fRecruits, Losses=fLosses,
                 GF=aGrowthFraction,DF=aDeclineFraction))   
  })
}


# Run simulation
o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=auxs, method="euler"))

# Plots and output
p1<-ggplot()+
  geom_line(data=o,aes(time,o$sCustomers,color="Customers"))+
  scale_y_continuous(labels = comma)+
  ylab("Stock")+
  xlab("Year") +
  labs(color="")+
  theme(legend.position="none")

ggplot()+
  geom_line(data=o,aes(time,o$sCustomers),colour="blue")+
  geom_point(data=o,aes(time,o$sCustomers),colour="blue")+
  scale_y_continuous(labels = comma)+
  ylab("Customers")+
  xlab("Year")


p2<-ggplot()+
  geom_line(data=o,aes(time,o$Losses,color="Losses"))+
  geom_line(data=o,aes(time,o$Recruits,color="Recruits"))+
  scale_y_continuous(labels = comma)+
  ylab("Flows")+
  xlab("Year") +
  labs(color="")+
  theme(legend.position="none")

grid.arrange(p1, p2,nrow=2, ncol=1)






