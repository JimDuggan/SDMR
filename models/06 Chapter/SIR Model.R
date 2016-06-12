library(deSolve)

# model for SIR process

model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{ 
    aBeta <- aCE / aTotalPopulation # error in test
    aLambda <- aBeta * sInfected

    fIR <- sSusceptible * aLambda
    fRR <- sInfected / aDelay

    d_sSusceptible_dt  <- -fIR
    d_sInfected_dt     <- fIR - fRR
    d_sRecovered_dt    <- fRR
    
    return (list(c(d_sSusceptible_dt,d_sInfected_dt,d_sRecovered_dt),
                 IR=fIR, RR=fRR,Beta=aBeta,Lambda=aLambda,
                 CE=aCE))   
  })
}
