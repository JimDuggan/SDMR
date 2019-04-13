library(FME)
library(dplyr)
library(readr)
library(ggplot2)

TRIALS <- 200
time   <- 0:100
Cap    <- 10000
SEED   <- 99

logistic <- function(TR,Cap,P0,r,t){
  P <- Cap/(1+(Cap/P0 - 1)*exp(-r*t))
  log_data <- tibble(TRIAL=rep(TR,length(t)), 
                     time=t,
                     InitialValue=P0,
                     GrowthRate=rep(r,length(t)), 
                     Population=P)
}

set.seed(SEED)
r.MIN           <- 0.00; r.MAX <- 0.50; 
P.INIT.MIN      <- 1;    P.INIT.MAX <- 50; 

parRange<-data.frame(
  min=c(r.MIN,P.INIT.MIN),
  max=c(r.MAX,P.INIT.MAX)
)

rownames(parRange)<-c("r","PInit")

mc_data <- data.frame(TR=1:TRIALS,
                      Latinhyper(parRange,TRIALS))

log_data <- tibble(TRIAL=numeric(), 
                   time=numeric(),
                   InitialValue=numeric(),
                   GrowthRate=numeric(), 
                   Population=numeric())

apply(mc_data,1,function(x){
  ans      <- logistic(x["TR"],Cap,x["PInit"],x["r"],time)
  log_data <<- dplyr::bind_rows(log_data,ans)
})


ggplot(data=log_data,aes(x=time,y=Value,colour=TRIAL))+geom_path()+
  scale_colour_gradientn(colours=rainbow(10))+
  ylab("Population") + xlab("Time (Days)")  + guides(color=FALSE) 


write_csv(log_data,"metamodels/01 Logistic Model/data/Logistic.csv")

