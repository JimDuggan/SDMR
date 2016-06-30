# Implement the following model in R. 
# Assume an initial population of 100000 and a growth fraction of 0.07. 
# Plot the results, and a phase plot.


library(deSolve)
library(ggplot2)
library(scales)

# Setup simulation times and time step
START<-2015; FINISH<-2030; STEP<-0.25

# Create time vector
simtime <- seq(START, FINISH, by=STEP)

# Create stock and auxs
stocks  <- c(sPopulation=10000)
auxs    <- c(aGrowthFraction=0.07)


# Model function
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    
    fPopulationAdded<-sPopulation*aGrowthFraction
  
    
    dP_dt <- fPopulationAdded
    
    return (list(c(dP_dt),
                 Additions=fPopulationAdded,GF=aGrowthFraction))   
  })
}


# Run simulation
o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=auxs, method="euler"))

# Plots and output
p1<-ggplot()+
  geom_line(data=o,aes(time,o$sPopulation),color="red")+
  scale_y_continuous(labels = comma)+
  ylab("Population")+
  xlab("Year") +
  theme(legend.position="none")

# Phase plot... state of the system v derivative

p2<-ggplot()+
  geom_point(data=o,aes(o$sPopulation,o$Additions),color="blue")+
  scale_y_continuous(labels = comma)+
  ylab("Flow")+
  xlab("Stock") +
  theme(legend.position="none")







