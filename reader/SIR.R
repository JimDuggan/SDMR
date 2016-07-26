###########################################
# Translation of Vensim file.
# Date created: 2016-07-25 19:26:53
###########################################
library(deSolve)
library(ggplot2)
library(reshape2)
#Displaying the simulation run parameters
START_TIME <- 0.000000
FINISH_TIME <- 20.000000
TIME_STEP <- 0.125000
#Setting aux param to NULL
auxs<-NULL

#Generating the simulation time vector
simtime<-seq(0.000000,20.000000,by=0.125000)
# Writing global variables (stocks and dependent auxs)
InitInfected = 1
stocks <-c( Infected = InitInfected , Recovered = 0 , Susceptible = 9999 )
# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    EffectiveContactRate <- 2
    TotalPopulation <- 10000
    Beta <- EffectiveContactRate/TotalPopulation
    Delay <- 2
    Lambda <- Beta*Infected
    IR <- Lambda*Susceptible
    RR <- Infected/Delay
    VF <- 0.05
    VR <- Susceptible*VF
    d_DT_Infected  <- IR-RR
    d_DT_Recovered  <- RR+VR
    d_DT_Susceptible  <- -IR-VR
    return (list(c(d_DT_Infected,d_DT_Recovered,d_DT_Susceptible)))
  })
}
# Function call to run simulation
o<-data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))
mo<-melt(o,id.vars = 'time')
names(mo)<-c('Time','Stock','Value')
ggplot(data=mo)+geom_line(aes(x=Time,y=Value,colour=Stock))
#----------------------------------------------------
# Original text file exported from Vensim
#  Init Infected = 1
#  Infected = INTEG( IR - RR , Init Infected ) 
#  Recovered = INTEG( RR + VR , 0) 
#  Susceptible = INTEG( - IR - VR , 9999) 
#  Effective Contact Rate = 2
#  Total Population = 10000
#  Beta = Effective Contact Rate / Total Population 
#  Delay = 2
#  FINAL TIME = 20
#  INITIAL TIME = 0
#  Lambda = Beta * Infected 
#  IR = Lambda * Susceptible 
#  RR = Infected / Delay 
#  TIME STEP = 0.125
#  SAVEPER = TIME STEP 
#  VF = 0.05
#  VR = Susceptible * VF 
#----------------------------------------------------
