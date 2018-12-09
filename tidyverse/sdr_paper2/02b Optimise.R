library(readr)

data <- read_csv("tidyverse/sdr_paper2/data/Structures.csv")

START<-0; FINISH<-100; STEP<-0.125;
simtime <- seq(START, FINISH, by=STEP)

WP_1960<-3026002942
WP_INIT<-world_data[1,"Population"]

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{  
    

    

    
    Normal Growth Rate=
      0.13
    
    Land Required Per Business=
      0.2
    
    Total Available Land=
      10000
    
    Land Fraction Occupied=
      Business Structures*Land Required Per Business/Total Available Land
    
    Effect of Land Fraction Occupied on Growth Rate=
      1-Land Fraction Occupied
    
    Actual Growth Rate=
      Normal Growth Rate*Effect of Land Fraction Occupied on Growth Rate
    
    Business Construction=
      Actual Growth Rate*Business Structures

    
    BusinessDemolition <- BusinessStructures * DemolitionFraction
    
    
    fPopulationAdded<-Population * aGrowthFraction
    
    # the net flow
    BusinessStructures = BusinessConstruction-BusinessDemolition
    
    return (list(c(BusinessStructures)))   
  })
}

solveWP <- function(pars){
  # All the stocks are initialised here...
  stocks  <- c(Population=WP_INIT)
  auxs    <- c(aGrowthFraction=unname(pars["aGrowthFraction"]))
  
  return (data.frame(ode(y=stocks, simtime, func = model, 
                         parms=auxs, method="euler")))
}

getCost<-function(p)
{
  out<-solveWP(p)
  #http://www.inside-r.org/packages/cran/FME/docs/modCost
  cost <- modCost(obs=world_data,model=out)
  #cat(str(cost))
  return(cost)
}

pars<-c(aGrowthFraction=0.001) 
lower<-c(0.0)
upper<-c(0.2)



Fit<-modFit(p=pars,f=getCost,lower=lower,upper=upper)

optPar<-c(Fit$par)
optMod <- solveWP(optPar)

# see http://www.inside-r.org/packages/cran/FME/docs/modFit

time_points<-seq(from=1, to=length(simtime),by=1/STEP)
optMod<-optMod[time_points,]



p1<-ggplot()+geom_point(data=world_data,size=1.5,aes(time,Population,colour="Data"))+
  geom_line(data=optMod,size=1,aes(x=time,y=Population,colour="Model"))+
  ylab("People")+
  xlab("Year")+
  scale_y_continuous(labels = comma)+
  theme(legend.position="bottom")+
  scale_colour_manual(name="",
                      values=c(Data="red", 
                               Model="blue"),
                      labels=c("Data",
                               "Model"))
