library(ggplot2)
#library(gdata)

derivn<-function(voi,time){
  c(0.0,diff(voi)/diff(time))
}

abm<-function(v){
  ifelse(v==0.0,"LIN",
         ifelse(v<0,"LOG","EXP"))
}

# have saved the excel file as a binary
# sim <- read.xls("workshop/models/02 session/LTG.xlsx",
#                stringsAsFactors=FALSE)
# save(sim,file="workshop/models/02 session/LTG.Rda")

load("workshop/models/02 session/LTG.Rda")

ggplot(data=sim,aes(Time,Stock))+
  geom_point()+
  ylab("Stock")+
  xlab("Year") +
  guides(color=guide_legend(title=NULL))+
  theme(legend.position="top")

sim$der<-derivn(abs(sim$Net.Flow),sim$Time)

sim$bmode<-abm(sim$der)

ggplot(data=sim,aes(Time,Stock,colour=bmode))+
  geom_point()+ylab("Stock")+xlab("Year") +
  guides(color=guide_legend(title=NULL))+
  theme(legend.position="top")
