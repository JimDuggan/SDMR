###########################################
# Translation of Vensim file.
# Date created: 2017-10-27 21:14:40
###########################################
library(deSolve)
library(ggplot2)
library(tidyr)
#Displaying the simulation run parameters
START_TIME <- 2015.000000
FINISH_TIME <- 2030.000000
TIME_STEP <- 0.125000
#Setting aux param to NULL
auxs<-NULL

#Generating the simulation time vector
simtime<-seq(2015.000000,2030.000000,by=0.125000)
# Writing global variables (stocks and dependent auxs)
InitCustomers = 10000
stocks <-c( Customers = InitCustomers )
# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    DeclineFraction <- 0.03
    GrowthFraction <- 0.07
    Losses <- Customers*DeclineFraction
    Recruits <- Customers*GrowthFraction
    d_DT_Customers  <- Recruits-Losses
    return (list(c(d_DT_Customers)))
  })
}
# Function call to run simulation
o<-data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))
to<-gather(o,key=Stock,value=Value,2:ncol(o))
ggplot(data=to)+geom_line(aes(x=time,y=Value,colour=Stock))
#----------------------------------------------------
# Original text file exported from Vensim
#  Init Customers = 10000
#  Customers = INTEG( Recruits - Losses , Init Customers) 
#  Decline Fraction = 0.03
#  Growth Fraction = 0.07
#  Losses = Customers * Decline Fraction 
#  Recruits = Customers * Growth Fraction 
#  FINAL TIME = 2030
#  INITIAL TIME = 2015
#  TIME STEP = 0.125
#----------------------------------------------------
