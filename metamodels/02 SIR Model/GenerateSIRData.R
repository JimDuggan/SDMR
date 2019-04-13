library(FME)
library(dplyr)
library(readr)
library(ggplot2)

source("metamodels/02 SIR Model/RunModel.R")
init_connection("metamodels/02 SIR Model/Vensim/01 SIR Aggregate.mdl")

TRIALS <- 100
SEED   <- 99

set.seed(SEED)
r0.MIN       <- 0.00;  r0.MAX  <- 4; 
delI.MIN     <- 1.00;  delI.MAX <- 5;

parRange<-data.frame(
  min=c(r0.MIN,delI.MIN),
  max=c(r0.MAX,delI.MAX)
)

rownames(parRange)<-c("R0","DelayI")

mc_data <- data.frame(TR=1:TRIALS,
                      Latinhyper(parRange,TRIALS))

log_data <- tibble(Trial=numeric(), 
                   Time=numeric(),
                   R0=numeric(),
                   DelayI=numeric(),
                   Susceptible=numeric(),
                   Infected=numeric(),
                   Recovered=numeric())

invisible(apply(mc_data,1,function(x){
  print(sprintf("Generating Data for Trial %d - R0 = %f and DI = %f",
          x["TR"],x["R0"],x["DelayI"]))
  ans      <- run_sir_model(x["TR"], x["R0"],x["DelayI"])
  log_data <<- dplyr::bind_rows(log_data,ans)
}))

log_data <- log_data %>% filter(Time != 0)

ggplot(data=log_data,aes(x=Time,y=Infected,colour=Trial))+geom_path()+
  scale_colour_gradientn(colours=rainbow(10))+
  ylab("Population") + xlab("Time (Days)")  + guides(color=FALSE) 

ggplot(data=log_data,aes(x=Time,y=Susceptible,colour=Trial))+geom_path()+
  scale_colour_gradientn(colours=rainbow(10))+
  ylab("Population") + xlab("Time (Days)")  + guides(color=FALSE) 

ggplot(data=log_data,aes(x=Time,y=Recovered,colour=Trial))+geom_path()+
  scale_colour_gradientn(colours=rainbow(10))+
  ylab("Population") + xlab("Time (Days)")  + guides(color=FALSE) 


write_csv(log_data,"metamodels/02 SIR Model/SIRData.csv")

