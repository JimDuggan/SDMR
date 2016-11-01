library(deSolve)
library(ggplot2)

l1 <- seq(100,0,by=-5)
l2 <- seq(5,100,by=5)
l3 <- seq(95,0,by=-5)
l4 <- seq(5,100,by=5)

input <- c(l1, l2, l3, l4)

START<-0; FINISH<-20; STEP<-0.25
simtime <- seq(START, FINISH, by=STEP)

stocks  <- c(sStock=100)
auxs    <- c(aOutflow=50)

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
  
    fInflow <- input[which(simtime==time)]

    fOutflow <- aOutflow
    
    dS_dt <- fInflow - fOutflow
    
    ans <- list(c(dS_dt),Inflow=fInflow, 
              Outflow=fOutflow,
              NetFlow=dS_dt)
  })
}

# Run simulation
o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                  parms=auxs, method='euler'))


qplot(x=time,y=sStock,data=o) + 
  geom_line()


qplot(x=sStock,y=NetFlow,data=o) + 
  geom_path()

