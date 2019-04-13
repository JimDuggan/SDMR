library(FME)
library(dplyr)
library(readr)
library(ggplot2)

source("metamodels/02 SIR Model/RunModel.R")
init_connection("metamodels/02 SIR Model/Vensim/01 SEIR.mdl")

TRIALS <- 200
SEED   <- 99

set.seed(SEED)
r0.MIN       <- 0.00;  r0.MAX  <- 4; 
delE.MIN     <- 1.00;  delE.MAX <- 1;
delI.MIN     <- 1.00;  delI.MAX <- 5;

parRange<-data.frame(
  min=c(r0.MIN,delE.MIN,delI.MIN),
  max=c(r0.MAX,delE.MAX,delI.MAX)
)

rownames(parRange)<-c("R0","DelayE","DelayI")

mc_data <- data.frame(TR=1:TRIALS,
                      Latinhyper(parRange,TRIALS))

log_data <- tibble(Trial=numeric(), 
                   Time=numeric(),
                   R0=numeric(),
                   DelayE=numeric(),
                   DelayI=numeric(),
                   Infected=numeric())

invisible(apply(mc_data,1,function(x){
  print(sprintf("Generating Data for Trial %d - R0 = %f and DE = %f DI = %f",
          x["TR"],x["R0"],x["DelayE"],x["DelayI"]))
  ans      <- run_seir_model(x["TR"], x["R0"],x["DelayE"],x["DelayI"])
  log_data <<- dplyr::bind_rows(log_data,ans)
}))

log_data <- log_data %>% filter(Time != 0)

ggplot(data=log_data,aes(x=Time,y=Infected,colour=Trial))+geom_path()+
  scale_colour_gradientn(colours=rainbow(10))+
  ylab("Population") + xlab("Time (Days)")  + guides(color=FALSE) 


write_csv(log_data,"metamodels/02 SIR Model/SEIRData.csv")

