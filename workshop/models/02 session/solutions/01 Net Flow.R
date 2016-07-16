library(deSolve)
library(ggplot2)
require(gridExtra)

derivn<-function(voi,time){
  c(0.0,diff(voi)/diff(time))
}

abm<-function(v){
  ifelse(v==0.0,"LIN",
         ifelse(v<0,"LOG","EXP"))
}

load("workshop/models/02 session/LTG.Rda")

o<-sim

o$abm<-derivn(abs(derivn(o$Net.Flow,o$Time)),o$Time)

o$bmode<-abm(o$abm)

ggplot()+
  geom_point(data=o,aes(Time,o$Net.Flow,colour=o$bmode))+
  ylab("Stock")+
  xlab("Year") +
  guides(color=guide_legend(title=NULL))+
  theme(legend.position="top")

