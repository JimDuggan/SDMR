library(deSolve)  
library(ggplot2) 
library(scales)

START<-2015; FINISH<-2035; STEP<-0.25; 

simtime <- seq(START, FINISH, by=STEP)

INV_FRACT_MIN <-0.03; INV_FRACT_MAX <-0.12
DEP_FRACT_MIN <-0.01; DEP_FRACT_MAX <-0.04
INIT_CAP_MIN  <-9000; INIT_CAP_MAX  <-10100

NRUNS<-100

sensRun<-function(run){
  model <- function(time, stocks, auxs)
  {
      with(as.list(c(stocks, auxs)),{  

      fInvestment <- sCapital * aInvestmentFraction
      fDepreciation <- sCapital * aDepreciationFraction
  
      dC_dt  <- fInvestment - fDepreciation
    
      return (list(c(dC_dt),
                   Investment=fInvestment,
                   Depreciation=fDepreciation,
                   InvFraction=aInvestmentFraction,
                   DepFraction=aDepreciationFraction))   
    })
  }
  stocks  <- c(sCapital=runif(1,INIT_CAP_MIN,INIT_CAP_MAX))

  # create the vector of auxiliaries
  auxs    <- c(aInvestmentFraction=
                  runif(1, INV_FRACT_MIN, 
                             INV_FRACT_MAX), 
               aDepreciationFraction=
                  runif(1,DEP_FRACT_MIN, 
                            DEP_FRACT_MAX))

  o<-data.frame(ode(y=stocks, simtime, func = model, 
                    parms=auxs, method="euler"))
  o$run<-run
  return (o)
}

# plot the results
o1<-sensRun(1)
for(n in 2:NRUNS)
{
  o1<-rbind(o1,sensRun(n))
}


p1<-ggplot(o1,aes(x=time,y=sCapital,color=run,group=run)) + geom_line() + 
  ylab("Capital") +
  xlab("Year")  + guides(color=FALSE) +
  ggtitle("Sensitivity Simulation Runs (100) showing Capital")

runs<-split(o1,o1$time)




corInv<-sapply(runs,function(l){cor(l$sCapital, l$InvFraction )})
corDep<-sapply(runs,function(l){cor(l$sCapital, l$DepFraction )})



p2<-ggplot()+
  geom_line(aes(simtime,corInv,color="INV"))+
  geom_line(aes(simtime,corDep,color="DEP"))+
  scale_y_continuous(labels = comma)+
  ylab("Capital- Correlation Coefficients")+
  xlab("Year") +
  labs(color="")+
  theme(legend.position="bottom")


