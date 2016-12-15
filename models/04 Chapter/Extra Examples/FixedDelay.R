###########################################
# Translation of Vensim file.
# Date created: 2016-12-15 16:26:42
###########################################
library(deSolve)
library(ggplot2)
library(scales)

#Displaying the simulation run parameters
START_TIME <- 0.000000
FINISH_TIME <- 20.000000
TIME_STEP <- 0.125000
#Setting aux param to NULL
auxs<-NULL

#Generating the simulation time vector
simtime<-seq(0.000000,20.000000,by=0.125000)

# add a data frame to keep track of the inflow, all empty at the start
inflowHistory <- data.frame(Time=simtime,
                            Value=vector(mode = "numeric",length =length(simtime)))

# Writing global variables (stocks and dependent auxs)
stocks <-c( MaterialinTransit = 400 )

# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    
    # Create the step function 
    if(time < 8) Inflow <- 100 else Inflow <- 200
    
    # Here we use the R superassignment operator to change the data frame state
    inflowHistory$Value[which(inflowHistory$Time == time)] <<- Inflow
    AverageDelay <- 4.0
    
    #check for initial flow value
    if(time - AverageDelay < 0) 
      Outflow <- 100 else{
        ind <- which(inflowHistory$Time == (time - AverageDelay))
        Outflow <- inflowHistory$Value[ind]
      }
    
    d_DT_MaterialinTransit  <- Inflow-Outflow
    return (list(c(d_DT_MaterialinTransit),Inflow=Inflow,Outflow=Outflow))
  })
}
# Function call to run simulation
o<-data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))

p1<-ggplot()+
  geom_line(data=o,aes(time,o$Inflow,color="Inflow"))+
  geom_line(data=o,aes(time,o$Outflow,color="Outflow"))+
  scale_y_continuous(labels = comma)+
  ylab("Stock")+
  xlab("Year") +
  labs(color="")+
  theme(legend.position="top")




#----------------------------------------------------
# Original text file exported from Vensim
#  Material in Transit = INTEG( Inflow - Outflow , 400) 
#  Inflow = 100 + step ( 100, 8) 
#  Average Delay = 4
#  Outflow = DELAY FIXED ( Inflow ,Average Delay , 100) 
#  FINAL TIME = 20
#  INITIAL TIME = 0
#  TIME STEP = 0.125
#  SAVEPER = TIME STEP
#----------------------------------------------------
