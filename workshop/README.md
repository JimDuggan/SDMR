#### Overview of Workshop: System Dynamics Modeling with R


Welcome to the githib resource for a three-hour workshop on how combine system dynamics and [R](https://www.r-project.org) (using [R Studio](https://www.rstudio.com)), which will be delivered as part of the [System Dynamics International Summer School](http://conference.systemdynamics.org/summer-school/) and the [Workshop Day](http://conference.systemdynamics.org/current/upload/ws.pdf) at the [The 34th International Conference of the System Dynamics Society](http://conference.systemdynamics.org).


There are two parts to the workshop, and the slides can be viewed [here](https://github.com/JimDuggan/SDMR/tree/master/workshop/slides).

* [Session 1](https://github.com/JimDuggan/SDMR/tree/master/workshop/models/01%20session) (Introduction to R), which focuses on key concepts and basics that can be used by system dynamics modellers. Topics include vectors, lists, data frames, functions and visualistion. For example, you will learn what the following R code performs:

```R
library(gdata)
library(ggplot2)
library(reshape2)

sim <- read.xls("workshop/models/01 session/SimData.xlsx",
                stringsAsFactors=FALSE)
sub<-sim[c( TRUE, rep(FALSE,7)),]
msub<-melt(sub,id.vars = "Time")
names(msub)<-c("Year","Cohort","Population")
ggplot(data=msub)+geom_area(aes(x=Year,y=Population,fill=Cohort))

```

* [Session 2](https://github.com/JimDuggan/SDMR/tree/master/workshop/models/02%20session) (System Dynamics Modeling with R), which demonstrates how the deSolve package and be used to run models, and how analysis techniques such as atomic behaviour modes and statistical screening can be used. One of the models covered is shown below.

```R
library(deSolve)
library(ggplot2)
require(gridExtra)
library(scales)

# Setup simulation times and time step
START<-2015; FINISH<-2030; STEP<-0.25

# Create time vector
simtime <- seq(START, FINISH, by=STEP)

# Create stock and auxs
stocks  <- c(sCustomers=10000)
auxs    <- c(aGrowthFraction=0.08, aDeclineFraction=0.03)


# Model function
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    
    fRecruits<-sCustomers*aGrowthFraction
    
    fLosses<-sCustomers*aDeclineFraction
    
    dC_dt <- fRecruits - fLosses
    
    return (list(c(dC_dt),
                 Recruits=fRecruits, Losses=fLosses,NetFlow=dC_dt,
                 GF=aGrowthFraction,DF=aDeclineFraction))   
  })
}


# Run simulation
o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=auxs, method="euler"))

# Plots and output
p1<-ggplot()+
  geom_line(data=o,aes(time,o$sCustomers,color="red"))+
  scale_y_continuous(labels = comma)+
  ylab("Customers")+
  xlab("Year") +
  theme(legend.position="none")


```

