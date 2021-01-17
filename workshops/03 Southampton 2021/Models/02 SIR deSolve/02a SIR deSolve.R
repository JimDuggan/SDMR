# Example 2(a) using  deSolve for a system dynamics model
library(deSolve)
library(ggplot2)
library(tidyr)

sir_model <- function (time, stocks, auxs){
  with(as.list(c(stocks, auxs)), {
    Per_Capita_Beta <- Average_Contacts * Infectivity/N
    R0 <- Infectivity * Average_Contacts * Recovery_Delay
    Checksum <- Susceptible + Infected + Recovered
    Force_of_Infection <- Per_Capita_Beta * Infected
    
    IR <- Susceptible * Force_of_Infection
    RR <- Infected/Recovery_Delay
    
    d_Susceptible_dt <- -IR
    d_Infected_dt <- IR - RR
    d_Recovered_dt <- RR
    
    return(list(c(d_Susceptible_dt, d_Infected_dt, d_Recovered_dt), 
                RR = RR, Per_Capita_Beta = Per_Capita_Beta, R0 = R0, 
                Checksum = Checksum, Force_of_Infection = Force_of_Infection, 
                IR = IR, Recovery_Delay = Recovery_Delay, N = N, Average_Contacts = Average_Contacts, 
                Infectivity = Infectivity))
  })
}

simtime <- seq(1,30,0.125)

stocks <- c(Susceptible=9999,
            Infected=1,
            Recovered=0)

params <- c(Recovery_Delay=2.0, 
            N = 10000, 
            Average_Contacts = 10.0, 
            Infectivity = 0.1)

results <- tibble(data.frame(ode(y      = stocks,
                      times  = simtime,
                      func   = sir_model,
                      parms  = params, 
                      method = "euler")))

