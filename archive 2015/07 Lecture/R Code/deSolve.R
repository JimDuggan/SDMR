library(deSolve)  # include the deSolve library for odes
library(ggplot2)  # include ggplot for displaying graphs

# setup simulation start and finish times, and time step
START<-2015; FINISH<-2035; STEP<-0.25; 

# create a simulation time vector, needed by deSolve
simtime <- seq(START, FINISH, by=STEP)

# create model function that contains all the equations
# this function receives
#   (1) the current time (time)
#   (2) a vectors of stocks (stocks)
#   (3) the auxiliary parameters (auxs)

model <- function(time, stocks, auxs)
{
  # with(as.list) makes it easy to reference variables
  with(as.list(c(stocks, auxs)),{  
    # Calculate the flows
    fInvestment <- sCapital * aInvestmentFraction
    fDepreciation <- sCapital * aDepreciationFraction
    
    # Calculate the net flow
    dC_dt  <- fInvestment - fDepreciation
    
    # return calculations as a list,  
    # first value is a vector of net flows
    return (list(c(dC_dt),
                 Investment=fInvestment,
                 Depreciation=fDepreciation,
                 InvFraction=aInvestmentFraction,
                 DepFraction=aDepreciationFraction))   
  })
}

# create the vector of stocks and their initial values
stocks  <- c(sCapital=10000)

# create the vector of auxiliaries
auxs    <- c(aInvestmentFraction=0.08, 
             aDepreciationFraction=0.05)

# call the function ode, results returned as a data frame
o<-data.frame(ode(y=stocks, simtime, func = model, 
                  parms=auxs, method="euler"))

# plot the results
qplot(data=o,x=o$time,y=o$sCapital,
      geom=c("line","point"),xlab="Year",ylab="Capital")




ggplot() + 
  geom_line(data = o, aes(x = time, y = Investment, color = "Investment")) +
  geom_line(data = o, aes(x = time, y = Depreciation, color = "Depreciation")) +
  xlab('Simulation Time (Years)') +
  labs(color="Model Variables")+
  ylab('Flows')


