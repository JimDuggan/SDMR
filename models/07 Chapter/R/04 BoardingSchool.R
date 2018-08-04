library(deSolve)
library(ggplot2)
library(gdata)
library(scales)
library(FME)

# see https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1603269/pdf/brmedj00115-0064.pdf
inf_data <- read.xls("models/07 Chapter/R/BoardingSchool.xlsx",stringsAsFactors=F)
START<-0; FINISH<-20; STEP<-0.125
# Create time vector
simtime <- seq(START, FINISH, by=STEP)

# Write callback function (model equations)
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    aLambda <- aBeta * sInfected
    
    fIR <- sSusceptible * aLambda
    fRR <- sInfected / aDelay
    
    d_sSusceptible_dt  <- -fIR
    d_sInfected_dt     <- fIR - fRR
    d_sRecovered_dt    <- fRR
    
    
    return (list(c(d_sSusceptible_dt,d_sInfected_dt,d_sRecovered_dt)))  
  })
}

solveSIR <- function(pars){
  # All the stocks are initialised here...
  stocks  <- c(sSusceptible=762,sInfected=1,sRecovered=0)
  auxs    <- c(aBeta=unname(pars["aBeta"]),
               aDelay=unname(pars["aDelay"]))
               
  return (data.frame(ode(y=stocks, simtime, func = model, 
              parms=auxs, method="rk4")))
}

getCost<-function(p)
{
  out<-solveSIR(p)
  #http://www.inside-r.org/packages/cran/FME/docs/modCost
  cost <- modCost(obs=inf_data,model=out)
  #cat(str(cost))
  return(cost)
}

pars<-c(aBeta=0.001,aDelay=2.0) 
lower<-c(0.0, 1.0)
upper<-c(0.01, 5.0)


Fit<-modFit(p=pars,f=getCost,lower=lower,upper=upper)

optPar<-c(Fit$par)
optMod <- solveSIR(optPar)

# see http://www.inside-r.org/packages/cran/FME/docs/modFit

# Book params
pars<-c(aBeta=2.18e-3,aDelay=2.02) 
optBook <- solveSIR(pars)

p1<-ggplot()+geom_point(data=inf_data,size=1.5,aes(time,sInfected,colour="Data"))+
  geom_line(data=optMod,size=1,aes(x=time,y=sInfected,colour="Model"))+
  ylab("People Infected")+
  xlab("Day")+
  scale_y_continuous(labels = comma)+
  theme(legend.position="bottom")+
  scale_colour_manual(name="",
                      values=c(Data="red", 
                               Model="blue"),
                      labels=c("Data",
                               "Model"))




