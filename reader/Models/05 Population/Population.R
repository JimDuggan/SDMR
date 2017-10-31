###########################################
# Translation of Vensim file.
# Date created: 2017-10-31 15:33:41
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
stocks <-c( Population = 3e+09 )
# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    GrowthFraction <- 0.03
    NumberAdded <- Population*GrowthFraction
    d_DT_Population  <- NumberAdded
    return (list(c(d_DT_Population)))
  })
}
# Function call to run simulation
o<-data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))
to<-gather(o,key=Stock,value=Value,2:ncol(o))
ggplot(data=to)+geom_line(aes(x=time,y=Value,colour=Stock))

ggplot()+geom_point(data=o,aes(x=time,y=Population))+geom_point(data=o1,aes(x=time,y=Population),colour="red")+geom_line()


#----------------------------------------------------
# Original text file exported from Vensim
#  Population = INTEG( Number Added , 3e+09) 
#  FINAL TIME = 2010
#  Growth Fraction = 0.0125
#  INITIAL TIME = 1960
#  Number Added = Population * Growth Fraction 
#  TIME STEP = 0.125
#----------------------------------------------------
