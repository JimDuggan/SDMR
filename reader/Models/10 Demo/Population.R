###########################################
# Translation of Vensim file.
# Date created: 2018-08-08 14:45:20
###########################################
library(deSolve)
library(ggplot2)
library(tidyr)
#Displaying the simulation run parameters
START_TIME <- 1960.000000
FINISH_TIME <- 2010.000000
TIME_STEP <- 0.125000
#Setting aux param to NULL
auxs<-NULL

#Generating the simulation time vector
simtime<-seq(1960.000000,2010.000000,by=0.125000)
# Writing global variables (stocks and dependent auxs)
InitialPopulation = 3000
stocks <-c( Population = InitialPopulation )
# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    GrowthFraction <- 0.015
    NumberAdded <- GrowthFraction*Population
    d_DT_Population  <- NumberAdded
    return (list(c(d_DT_Population)))
  })
}
# Function call to run simulation
o<-data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))
to<-gather(o,key=Stock,value=Value,2:ncol(o))
ggplot(data=to)+geom_line(aes(x=time,y=Value,colour=Stock))
#----------------------------------------------------
# Original text file exported from Vensim
#  Initial Population = 3000
#  Population = INTEG( Number Added , Initial Population ) 
#  FINAL TIME = 2010
#  Growth Fraction = 0.015
#  INITIAL TIME = 1960
#  Number Added = Growth Fraction * Population 
#  TIME STEP = 0.125
#----------------------------------------------------
