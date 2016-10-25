# File:    Customers.R
# Author:  Jim Duggan
# Summary: One-stock example of customers , with fraction increases/descreases

library(deSolve)
library(ggplot2)

# Setup simulation times and time step
START<-2015; FINISH<-2030; STEP<-0.5

# Create time vector
simtime <- seq(START, FINISH, by=STEP)

# Create stock and auxs
stocks  <- c(sCustomers=10000)
auxs    <- c(aGrowthFraction=0.08, aDeclineFraction=0.03)


# The Model function, takes 3 arguments from ode()
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    
    # The inflow equation
    fRecruits <- sCustomers*aGrowthFraction
    
    # The outflow equation
    fLosses <- sCustomers*aDeclineFraction
    
    # The stock equation
    dC_dt <- fRecruits - fLosses
    
    # All the results for the time step
    ans <- list(c(dC_dt),
              Recruits=fRecruits, 
              Losses=fLosses,
              NetFlow=dC_dt,
              GF=aGrowthFraction,
              DF=aDeclineFraction)
  })
}


# Run simulation
o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=auxs, method='euler'))

# Plot results
qplot(x=time,y=sCustomers,data=o) + geom_line()







