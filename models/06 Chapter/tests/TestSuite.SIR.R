source('models/06 chapter/SIR Model.R')
library(RUnit)

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

bpattern<-function(bm)
{
  return (rle(bm)$values)
}

T01.S.Eq.0.IMP.IR.Eq.0<-function()
{
  START<-0; FINISH<-20; STEP<-0.01; 
  simtime <- seq(START, FINISH, by=STEP)
  stocks  <- c(sSusceptible=0,sInfected=10000,sRecovered=0)
  auxs    <- c(aTotalPopulation=10000, aCE=2, aDelay=2)
  t<-data.frame(ode(y=stocks, times=simtime, func = model, parms=auxs, method="euler"))
  t$Expected<-0
  checkEquals(t$Expected,t$IR)
}

T02.I.Eq.0.IMP.IR.Eq.0<-function()
{
  START<-0; FINISH<-20; STEP<-0.01; 
  simtime <- seq(START, FINISH, by=STEP)
  stocks  <- c(sSusceptible=10000,sInfected=0,sRecovered=0)
  auxs    <- c(aTotalPopulation=10000, aCE=0, aDelay=2)
  t<-data.frame(ode(y=stocks, times=simtime, func = model, parms=auxs, method="euler"))
  t$Expected<-0
  checkEquals(t$Expected,t$IR)
}

T03.CE.Eq.0.IMP.IR.Eq.0<-function()
{
  START<-0; FINISH<-20; STEP<-0.01; 
  simtime <- seq(START, FINISH, by=STEP)
  stocks  <- c(sSusceptible=9999,sInfected=1,sRecovered=0)
  auxs    <- c(aTotalPopulation=10000, aCE=0, aDelay=2)
  t<-data.frame(ode(y=stocks, times=simtime, func = model, parms=auxs, method="euler"))
  t$Expected<-0
  checkEquals(t$Expected,t$IR)
}




T04.D.Eq.INF.IMP.RR.Eq.0<-function()
{
  START<-0; FINISH<-20; STEP<-0.01; 
  simtime <- seq(START, FINISH, by=STEP)
  stocks  <- c(sSusceptible=0,sInfected=10000,sRecovered=0)
  auxs    <- c(aTotalPopulation=10000, aCE=2, aDelay=Inf)
  t<-data.frame(ode(y=stocks, times=simtime, func = model, parms=auxs, method="euler"))
  t$Expected<-0
  checkEquals(t$Expected,t$RR)
}

T05.IMP.All.Vars.GTE.0<-function()
{
  START<-0; FINISH<-20; STEP<-0.01; 
  simtime <- seq(START, FINISH, by=STEP)
  stocks  <- c(sSusceptible=9999,sInfected=1,sRecovered=0)
  auxs    <- c(aTotalPopulation=10000, aCE=20, aDelay=2)
  t<-data.frame(ode(y=stocks, times=simtime, func = model, parms=auxs, method="euler"))
  checkTrue(all(t$sSusceptible>=0)); checkTrue(all(t$sInfected >= 0))
  checkTrue(all(t$sRecovered>=0)); checkTrue(all(t$IR>=0))
  checkTrue(all(t$RR>=0)); checkTrue(all(t$Lambda>=0))
}

T06.IMP.Mode.BellShaped<-function()
{
  START<-0; FINISH<-20; STEP<-0.01; 
  simtime <- seq(START, FINISH, by=STEP)
  stocks  <- c(sSusceptible=9999,sInfected=1,sRecovered=0)
  auxs    <- c(aTotalPopulation=10000, aCE=2, aDelay=2)
  t<-data.frame(ode(y=stocks, times=simtime, func = model, parms=auxs, method="euler"))
  expected<-c("EXP","LOG","EXP","LOG")
  actual<-bpattern(bmode(t$IR-t$RR,t$time))
  checkEquals(expected,actual)
  t$mode<-bmode(t$IR-t$RR,t$time)
}

