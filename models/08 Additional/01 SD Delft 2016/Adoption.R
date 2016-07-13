library(deSolve)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

# Function: get the distance between two cells on the grid
euc.distance<-function(r1, c1, r2, c2){
  sqrt((r1-r2)^2+(c1-c2)^2)
}

# a function to create the distance matrix
create.dm<-function(df)
{
  m<-matrix(nrow = nrow(df), ncol=nrow(df))
  for(i in 1:nrow(df)){
    for(j in 1:nrow(df)){
      m[i,j]<-euc.distance(df[i,"Row"],df[i,"Col"],
                           df[j,"Row"],df[j,"Col"])
    }   
  }
  return(m)
}

# Setup the spatial model. It's a 2 x 5 grid.
TotalPopulation<-100000
name.reg<-c("Region01","Region02","Region03","Region04","Region05",
            "Region06","Region07","Region08","Region09","Region10")
row.reg<-c(1,1,1,1,1,2,2,2,2,2)
col.reg<-c(1,2,3,4,5,1,2,3,4,5)
pop.reg<-c(0.10,0.01,0.21,0.08,0.17,
           0.04,0.05,0.25,0.03,0.06)
#names(pop.reg)<-c("R1","R2","R3","R4","R5","R6","R7","R8","R9","R10")

# setup the data frame for spatial information
sp<-data.frame(Regions=name.reg,
               Row=row.reg,
               Col=col.reg,
               Pop=pop.reg*TotalPopulation)

# Make contacts proportional to population proportion
set.seed(123)

normal.contacts<-runif(10,pop.reg*40,pop.reg*60)
names(normal.contacts)<-c("R1","R2","R3","R4","R5","R6","R7","R8","R9","R10")

# Infectivity 

infectivity<-runif(10,0.01,0.05)
names(infectivity)<-c("R1","R2","R3","R4","R5","R6","R7","R8","R9","R10")

# alpha parameter used to determine how quickly contact rates decay between regions
ALPHA<-0.95

# Create the distance matrix
dm<-create.dm(sp)
colnames(dm)<-c("R1","R2","R3","R4","R5","R6","R7","R8","R9","R10")
rownames(dm)<-c("R1","R2","R3","R4","R5","R6","R7","R8","R9","R10")

# Create the effective contact matrix
cr<-t(normal.contacts*exp(-ALPHA*dm))
ec<-t(normal.contacts*exp(-ALPHA*dm)*infectivity)

beta <- ec/sp$Pop

START<-0; FINISH<-50; STEP<-0.01;
NUM_REGIONS<-10; NUM_STOCKS_PER_REGION <-2

simtime <- seq(START, FINISH, by=STEP)

#Setup the stocks
stocks <- c(PA_R01=sp$Pop[1],  PA_R02=sp$Pop[2],   PA_R03=sp$Pop[3],   
            PA_R04=sp$Pop[4],  PA_R05=sp$Pop[5],   PA_R06=sp$Pop[6], 
            PA_R07=sp$Pop[7],  PA_R08=sp$Pop[8]-1, PA_R09=sp$Pop[9], 
            PA_R10=sp$Pop[10], AD_R01=0,           AD_R02=0,         
            AD_R03=0,          AD_R04=0,           AD_R05=0, 
            AD_R06=0,          AD_R07=0,           AD_R08=1,           
            AD_R09=0,          AD_R10=0)

model <- function(time, stocks, auxs){
  with(as.list(stocks),{ 
    #convert the stocks vector to a matrix
    states<-matrix(stocks,
                   nrow=NUM_REGIONS,
                   ncol=NUM_STOCKS_PER_REGION)
    
    PotentialAdopters <- states[,1]
    Adopters          <- states[,2]
    
    Rho               <- beta %*% Adopters
    AR                <- Rho * PotentialAdopters
    
    dPA_dt            <- -AR
    dAD_dt            <- AR
  
    
    TotalPopulation        <- sum(stocks)
    TotalPotentialAdopters <- sum(PotentialAdopters)
    TotalAdopters          <- sum(Adopters)
    
    return (list(c(dPA_dt, dAD_dt),AR_R=AR,
                 TP=TotalPopulation,
                 TPA=TotalPotentialAdopters,
                 TAD=TotalAdopters))  
  })
}

o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=NULL, method="euler"))


o1<-o[seq(from=1, to=length(simtime),by=1/STEP),]

tidy<-melt(o1,id.vars = "time")
names(tidy)<-c("Time","Variable","Value")

ar<-filter(tidy,grepl("AR_",Variable))
ad<-filter(tidy,grepl("AD_",Variable))

p1<-ggplot(ar,aes(x=Time,y=Value,color=Variable)) + 
  geom_line() +
  geom_point()+
  ylab("Adoption Rate") +
  xlab("Time (Weeks)")

ggsave(file="Plot1.png", dpi=300,p1) #saves g

p2<-ggplot(ad,aes(x=Time,y=Value,color=Variable,group=Variable)) + 
  geom_line() +
  geom_point()+
  ylab("Adopters") +
  xlab("Time (Weeks)")

ggsave(file="Plot2.png", dpi=300,p2) #saves g

pa<-filter(tidy,grepl("PA_",Variable))

p3<-ggplot(pa,aes(x=Time,y=Value,color=Variable,group=Variable)) + 
  geom_line() +
  geom_point()+
  ylab("Potential Adopters") +
  xlab("Time (Weeks)")





