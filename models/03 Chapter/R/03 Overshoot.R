library(deSolve)
library(ggplot2)
library(scales)
require(gridExtra)

START<-0; FINISH<-200; STEP<-0.125

simtime <- seq(START, FINISH, by=STEP)
stocks  <- c(sCapital=5, sResource=1000)
auxs    <- c(aDesired.Growth=0.07,        aDepreciation=0.05, 
             aCost.Per.Investment = 2.0,  aFraction.Reinvested=0.12, 
             aRevenue.Per.Unit=3)

x.Resource<-seq(0,1000,by=100)
y.Efficiency<-c(0,0.25,0.45,0.63,0.75,0.85,0.92,0.96,0.98,0.99,1.0)

func.Efficiency<-approxfun(x=x.Resource,y=y.Efficiency, method="linear",
                        yleft=0, yright=1.0)


model<-function(time, stocks, auxs){
  with(as.list(c(stocks,auxs)),
  {
    aExtr.Efficiency  <-func.Efficiency(sResource)
    
    fExtraction       <- aExtr.Efficiency * sCapital
    
    aTotal.Revenue     <- aRevenue.Per.Unit * fExtraction
    aCapital.Costs      <- sCapital * 0.10
    aProfit             <- aTotal.Revenue - aCapital.Costs
    aCapital.Funds      <- aFraction.Reinvested * aProfit
    aMaximum.Investment <- aCapital.Funds/aCost.Per.Investment
    
    aDesired.Investment <-sCapital * aDesired.Growth
    
    fInvestment        <- min(aMaximum.Investment, 
                              aDesired.Investment)
    fDepreciation      <- sCapital * aDepreciation
    
    dS_dt       <- fInvestment - fDepreciation
    dR_dt       <- -fExtraction
    
    return (list(c(dS_dt, dR_dt),
                   DesiredInvestment=aDesired.Investment,
                   MaximumInvestment=aMaximum.Investment,
                   Investment=fInvestment,
                   Depreciation=fDepreciation,
                   Extraction=fExtraction))
    })
}
  

o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                       parms=auxs, method="euler"))

# Plot the effects 
p <- ggplot() + 
  geom_line(colour="blue",aes(x = x.Resource, y = y.Efficiency)) +
  geom_point(aes(x = x.Resource, y = y.Efficiency)) +
  xlab('Resource') +
  labs(color="Stocks")+
  ylab('Extraction Effciency Per Unit Capital')+
  theme(legend.position="")

p1 <- ggplot() + 
  geom_line(colour="blue",data = o, aes(x = time, y = sCapital)) +
  xlab('Year') +
  labs(color="Stocks")+
  ylab('Capital')+
  theme(legend.position="")

p2 <- ggplot() + 
  geom_line(colour="blue",data = o, aes(x = time, y = sResource, color = "Capital")) +
  xlab('Year') +
  labs(color="Stocks")+
  ylab('Resource')+
  theme(legend.position="")

p3 <- ggplot() + 
  geom_line(colour="blue",data = o, aes(x = time, y = Investment-Depreciation)) +
  geom_line(colour="black",linetype="dashed",data = o,aes(x = time, y = Investment)) +
  geom_line(colour="red",linetype="dashed",data = o,aes(x = time, y = Depreciation)) +
  xlab('Year') +
  labs(color="Stocks")+
  ylab('Capital Net Flow')+
  theme(legend.position="")

p4 <- ggplot() + 
  geom_line(colour="blue",data = o, aes(x = time, y = Extraction, color = "Capital")) +
  xlab('Year') +
  labs(color="Stocks")+
  ylab('Extraction')+
  theme(legend.position="")

p5 <- ggplot() + 
  geom_line(linetype="dashed",data = o,aes(x = time, y = DesiredInvestment, color = "Desired")) +
  geom_line(linetype="dashed",data = o,aes(x = time, y = MaximumInvestment, color = "Maximum")) +
  geom_line(data = o, size=1.0,aes(x = time, y = Investment, color = "Actual")) +
  xlab('Year') +
  labs(color="")+
  ylab('Investment-Type Variables')+
  theme(legend.position="bottom")

g1<-grid.arrange(p1, p2, p3, p4, nrow=2, ncol=2)
g2<-grid.arrange(p1, p2, nrow=1, ncol=2)


auxs["aFraction.Reinvested"]=0.12
o1<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=auxs, method="euler"))
o1$GR<-"FR=12%"
base<-o1

# add to overall result set and color by category
auxs["aFraction.Reinvested"]=0.13
o2<-data.frame(ode(y=stocks, times=simtime, func = model, 
                     parms=auxs, method="euler"))
o2$GR<-"FR=13%"
base<-rbind(base,o2)

auxs["aFraction.Reinvested"]=0.14
o3<-data.frame(ode(y=stocks, times=simtime, func = model, 
                     parms=auxs, method="euler"))
o3$GR<-"FR=14%"
base<-rbind(base,o3)

auxs["aDesired.Growth"]=0.15
o4<-data.frame(ode(y=stocks, times=simtime, func = model, 
                   parms=auxs, method="euler"))
o4$GR<-"FR=15%"
base<-rbind(base,o4)

auxs["aDesired.Growth"]=0.16
o5<-data.frame(ode(y=stocks, times=simtime, func = model, 
                   parms=auxs, method="euler"))
o5$GR<-"FR=16%"
base<-rbind(base,o5)

s1<-ggplot(data=base,aes(x=time,y=base$sCapital,color=base$GR))+
  geom_line()+ 
  xlab("Time")+ylab("Capital")+
  theme(legend.position="bottom")+
  guides(color=guide_legend(title=NULL))

s2<-ggplot(data=base,aes(x=time,y=Extraction,color=base$GR))+
  geom_line()+ 
  xlab("Year")+ylab("Extraction Rate")+
  theme(legend.position="bottom")+
  guides(color=guide_legend(title=NULL))



grid.arrange(s1, s2, nrow=1, ncol=2)






