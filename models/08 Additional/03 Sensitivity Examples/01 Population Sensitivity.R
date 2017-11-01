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

#Generating the simulation time vector
simtime<-seq(1960.000000,2010.000000,by=0.125000)
# Writing global variables (stocks and dependent auxs)
stocks <-c( Population = 3e+09 )
# This is the model function called from ode

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    
    # Adding policy logic to the model
    if(aChangeFlag == 1 && time > aChangeTime){
      aGrowthFraction <- aGrowthFraction * aGrowthFractionMultiplier
    }
    
    NumberAdded <- Population*aGrowthFraction
    d_DT_Population  <- NumberAdded
    return (list(c(d_DT_Population)))
  })
}

run_info <- data.frame(
  RunID = 1:length(seq(START_TIME,FINISH_TIME,10)),
  aChangeFlag=1,
  aChangeTime =seq(START_TIME,FINISH_TIME,10),
  aGrowthFraction=0.0125,
  aGrowthFractionMultiplier=0.75
)

ans <- apply(run_info,1,function(x){
  auxs<-c(aGrowthFraction=x[["aGrowthFraction"]],
          aChangeTime=x[["aChangeTime"]],
          aChangeFlag=x[["aChangeFlag"]],
          aGrowthFractionMultiplier=x[["aGrowthFractionMultiplier"]])
  
  o<-data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))
  o$RunID <- as.factor(x[["RunID"]])
  o
})

ans_df <- rbind.fill(ans)

ggplot(data=ans_df)+geom_path(aes(x=time,y=Population,colour=RunID))


#----------------------------------------------------
# Original text file exported from Vensim
#  Population = INTEG( Number Added , 3e+09) 
#  FINAL TIME = 2010
#  Growth Fraction = 0.0125
#  INITIAL TIME = 1960
#  Number Added = Population * Growth Fraction 
#  TIME STEP = 0.125
#----------------------------------------------------
