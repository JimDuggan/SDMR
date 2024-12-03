library(deSolve)
library(ggplot2)
require(gridExtra)

START<-0; FINISH<-100; STEP<-0.25

simtime <- seq(START, FINISH, by=STEP)
stocks  <- c(sStock=100)
auxs    <- c(aCapacity=10000, aRef.Availability=1, aRef.GrowthRate=0.10)

bmode<-function(net_flow, time)
{
  net_flow<-abs(net_flow)
  net_flow_dt<- rep(NA, length(net_flow))
  net_flow_dt[2:length(net_flow_dt)]<-diff(net_flow)/diff(time)  
  bm<-ifelse(net_flow_dt > 0,ans<-"EXP",
             ifelse(net_flow_dt < 0,ans<-"LOG",ans<-"LIN"))
  bm[1] = bm[2]
  return(bm)
}


model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    aAvailability <- 1 - sStock / aCapacity
    aEffect <- aAvailability / aRef.Availability
    aGrowth.Rate <- aRef.GrowthRate * aEffect
    
    fNet.Flow <- sStock * aGrowth.Rate
    
    d_sStock_dt  <- fNet.Flow
  
    
    return (list(c(d_sStock_dt),
                 NetFlow=fNet.Flow,
                 GrowthRate=aGrowth.Rate,
                 Effect=aEffect, 
                 Availability=aAvailability))   
  })
}


o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                       parms=auxs, method="euler"))

plot3 <- qplot(time,NetFlow,data=o,geom="line",color=I("red"))
plot1 <- qplot(time,sStock,data=o,geom="line",color=I("blue"),ylab="Stock")
plot2 <- qplot(time,Availability,data=o,geom="line",color=I("green"),ylab="Availability")
plot4 <- qplot(time,GrowthRate,data=o,geom="line",color=I("black"),ylab="Growth Rate")
grid.arrange(plot1, plot2, plot3, plot4, nrow=2, ncol=2)

o$d_stock_dt<-o$NetFlow
o$d_stock_dot_dt[2:length(o$time)]<-diff(o$d_stock_dt)/diff(o$time)
o$stock_bm<-bmode(o$d_stock_dt,o$d_stock_dot_dt)

p1<-ggplot(data=o,aes(x=o$time,y=o$sStock,color=o$stock_bm))+
  geom_point(size=1)+ xlab("Time")+ylab("Stock")+
  theme(legend.position="bottom")+
  guides(color=guide_legend(title=NULL))

gA <- ggplotGrob(plot1)
gB <- ggplotGrob(plot2)
gC <- ggplotGrob(plot3)
gD <- ggplotGrob(plot4)
maxWidth = grid::unit.pmax(gA$widths[2:5], gB$widths[2:5],gC$widths[2:5],gD$widths[2:5])
gA$widths[2:5] <- as.list(maxWidth)
gB$widths[2:5] <- as.list(maxWidth)
gC$widths[2:5] <- as.list(maxWidth)
gD$widths[2:5] <- as.list(maxWidth)
grid.arrange(gA, gB, gC, gD,ncol=2, heights=c(2.3,2.3))

g <- arrangeGrob(gA, gB,gC, gD, nrow=2,ncol = 2) #generates g


