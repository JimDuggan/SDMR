library(deSolve)
library(ggplot2)
require(gridExtra)
library(scales)
library(FME)
library(plyr)

START<-0; FINISH<-25; STEP<-0.125; 

simtime <- seq(START, FINISH, by=STEP)

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    aBeta <- aEffective.Contact.Rate / aTotalPopulation
    aLambda <- aBeta * sInfected
    
    fIR <- sSusceptible * aLambda
    fRR <- sInfected / aDelay
    
    dS_dt  <- -fIR
    dI_dt  <- fIR - fRR
    dR_dt  <- fRR
    
    return (list(c(dS_dt,dI_dt,dR_dt),
                 IR=fIR, RR=fRR,Beta=aBeta,Lambda=aLambda,DEL=aDelay,
                 CE=aEffective.Contact.Rate,InitI=initInfected))   
  })
}

# setup the parameter data frame
CE.MIN<-0;          CE.MAX<-7.0
DEL.MIN<-1.0;       DEL.MAX<-10.0
INIT.INF.MIN<-1.0;  INIT.INF.MAX<-25.0;

parRange<-data.frame(
  min=c(CE.MIN, DEL.MIN, INIT.INF.MIN),
  max=c(CE.MAX, DEL.MAX, INIT.INF.MAX)
)
rownames(parRange)<-c("aEffective.Contact.Rate",
                      "aDelay",
                      "initInfected")

g.simRuns<-list()
sensRun<-function(p){
  
  g.simRuns<<-list(length=nrow(p))

  for(i in 1:nrow(p)){
    init<-p[i,"initInfected"]

    a<-c(aTotalPopulation=10000,p[i,1:3])
    
    stocks  <- c(sSusceptible=10000-init,sInfected=init,sRecovered=0)

    o<-data.frame(ode(y=stocks, simtime, func = model, 
                      parms=a, method="euler"))
    o$run<-i
    g.simRuns[[i]]<<-o
  }
}

NRUNS<-200
p<-data.frame(Latinhyper(parRange,NRUNS))
sensRun(p)

df<-rbind.fill(g.simRuns)

# statistical screening process starts here...
runs<-split(df,df$time)

av.Infected<-sapply(runs,function(l){mean(l$sInfected)})
max.Infected<-sapply(runs,function(l){max(l$sInfected)})
min.Infected<-sapply(runs,function(l){min(l$sInfected)})

cor.CE<-sapply(runs,function(l){cor(l$sInfected, l$CE)})
cor.DEL<-sapply(runs,function(l){cor(l$sInfected, l$DEL )})
cor.initInf<-sapply(runs,function(l){cor(l$sInfected, l$InitI )})

p1<-ggplot()+
  geom_line(aes(simtime,cor.CE),color="blue")+
  scale_y_continuous(labels = comma)+
  ylab("cor(CE, Infected)")+
  xlab("Time (Day)") +
  labs(color="")+
  theme(legend.position="bottom")

p2<-ggplot()+
  geom_line(aes(simtime,av.Infected),color="red")+
  ylab("Average Infected")+
  xlab("") +
  scale_y_continuous(labels = comma)+
  labs(color="")+
  guides(color=FALSE) 

gA <- ggplotGrob(p2)
gB <- ggplotGrob(p1)
maxWidth = grid::unit.pmax(gA$widths[2:5], gB$widths[2:5])
gA$widths[2:5] <- as.list(maxWidth)
gB$widths[2:5] <- as.list(maxWidth)
grid.arrange(gA, gB, ncol=1, heights=c(2.3,2.75))

g <- arrangeGrob(gA, gB, nrow=2) #generates g
