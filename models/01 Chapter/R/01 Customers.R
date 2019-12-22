library(deSolve)
library(ggplot2)
require(gridExtra)
library(scales)

START<-2015; FINISH<-2030; STEP<-0.25

simtime <- seq(START, FINISH, by=STEP)
stocks  <- c(sCustomers=10000)
auxs    <- c(aDeclineFraction=0.03)

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    
    if(time<2020)
       gf<-0.07
    else if(time<2025)
            gf<-0.03
    else
            gf<-0.02
    
    fRecruits<-sCustomers*gf
    
    fLosses<-sCustomers*0.03
    
    dC_dt <- fRecruits - fLosses
    
    return (list(c(dC_dt),
                 Recruits=fRecruits, Losses=fLosses,GF=gf,DF=0.03))   
  })
}


o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                       parms=auxs, method="euler"))

p1<-ggplot()+
  geom_line(data=o,aes(time,o$sCustomers,color="Customers"))+
  scale_y_continuous(labels = comma)+
  ylab("Stock")+
  xlab("Year") +
  labs(color="")+
  theme(legend.position="none")

p2<-ggplot()+
  geom_line(data=o,aes(time,o$Losses,color="Losses"))+
  geom_line(data=o,aes(time,o$Recruits,color="Recruits"))+
  scale_y_continuous(labels = comma)+
  ylab("Flows")+
  xlab("Year") +
  labs(color="")+
  theme(legend.position="none")

grid.arrange(p1, p2,nrow=2, ncol=1)

gA <- ggplotGrob(p1)
gB <- ggplotGrob(p2)
maxWidth = grid::unit.pmax(gA$widths[2:5], gB$widths[2:5])
gA$widths[2:5] <- as.list(maxWidth)
gB$widths[2:5] <- as.list(maxWidth)


p1<-grid.arrange(gA, gB, ncol=1, heights=c(2.3,2.75))

#ggsave("Fig1_6.png",dpi=1200)

#g <- arrangeGrob(gA, gB, nrow=2) #generates g
#ggsave(file="Fig1_6.png", dpi=1600,g) #saves g

