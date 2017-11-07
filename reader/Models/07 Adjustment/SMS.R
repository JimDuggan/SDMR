###########################################
# Translation of Vensim file.
# Date created: 2017-11-07 15:37:38
###########################################
library(deSolve)
library(ggplot2)
library(tidyr)
#Displaying the simulation run parameters
START_TIME <- 0.000000
FINISH_TIME <- 100.000000
TIME_STEP <- 0.062500
#Setting aux param to NULL
auxs<-NULL

#Generating the simulation time vector
simtime<-seq(0.000000,100.000000,by=0.062500)
# Writing global variables (stocks and dependent auxs)
stocks <-c( Stock = 100 )
# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    Target <- 100
    AT <- 100
    Adjustment <- (Target-Stock)/AT
    NetFlow <- Adjustment
    d_DT_Stock  <- NetFlow
    return (list(c(d_DT_Stock)))
  })
}
# Function call to run simulation
o<-data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))
to<-gather(o,key=Stock,value=Value,2:ncol(o))
ggplot(data=to)+geom_line(aes(x=time,y=Value,colour=Stock))
#----------------------------------------------------
# Original text file exported from Vensim
#  Stock = INTEG( Net Flow , 100) 
#  Target = 100 + step ( 100, 10) 
#  AT = 100
#  Adjustment = ( Target - Stock ) / AT 
#  FINAL TIME = 100
#  INITIAL TIME = 0
#  Net Flow = Adjustment 
#  TIME STEP = 0.0625
#----------------------------------------------------
