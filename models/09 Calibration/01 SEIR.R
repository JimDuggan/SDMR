library(gdata)
library(ggplot2)
library(FME)
library(deSolve)

flu <- read.xls("models/09 Calibration/Aggregate Flu1957.xlsx",stringsAsFactors=FALSE)

seir_model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    aLambda <- aBeta * sInfected
    
    fIR <- sSusceptible * aLambda
    fER <- sExposed / (2.0/7.0)
    fRR <- sInfected / (RD/7.0)
    
    dS_dt  <- -fIR
    dE_dt  <- fIR - fER
    dI_dt  <- fER - fRR
    dR_dt  <- fRR
    dC_dt  <- fIR*.45
    
    
    return (list(c(dS_dt,dE_dt,dI_dt,dR_dt,dC_dt),
                 IR=fIR, ER=fER, RR=fRR,Beta=aBeta,Lambda=aLambda))   
  })
}


opt_SEIR <- function(pars){
  START<-1; FINISH<-20; STEP<-0.01; RESULTS_PER_TIME<-1;
  simtime <- seq(START, FINISH, by=STEP)
  stocks  <- c(sSusceptible=7998,sExposed=0,sInfected=2,sRecovered=0,CINF=0)
  auxs    <- pars
  
  return (data.frame(ode(y=stocks, simtime, func = seir_model, 
                         parms=auxs, method="euler")))
}

getCost<-function(p)
{
  out<-opt_SEIR(p)
  cost <- modCost(obs=flu,model=out)
}

pars<- c(aBeta=0.0001,RD=2.0)
lower<-c(0.0000,1.5)
upper<-c(0.0005,2.5)

Fit<-modFit(p=pars,f=getCost,lower=lower,upper=upper)

auxs    <- c(Fit$par)
opt     <- opt_SEIR(Fit$par)

ggplot(flu,mapping = aes(x=time,y=CINF))+
       geom_path(colour="red")+
       geom_point(colour="blue")


ggplot(opt,mapping = aes(x=time,y=CINF))+
  geom_path(colour="red")+
  geom_point(colour="blue")+
  geom_point(data=flu,aes(x=time,y=CINF))

