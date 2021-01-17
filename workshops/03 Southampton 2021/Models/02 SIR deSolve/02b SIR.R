# Example 2(b) using the readsdr package to develop the deSolve code in R

library(readsdr)
library(deSolve)
library(dplyr)

filepath <- "workshops/03 Southampton 2021/Models/02 SIR deSolve/SIR.stmx"
mdl      <- read_xmile(filepath) 

simtime <- seq(mdl$deSolve_components$sim_params$start,
               mdl$deSolve_components$sim_params$stop,
               mdl$deSolve_components$sim_params$dt)

output_deSolve <- ode(y      = mdl$deSolve_components$stocks,
                      times  = simtime,
                      func   = mdl$deSolve_components$func,
                      parms  = mdl$deSolve_components$consts, 
                      method = "euler")

out <- data.frame(output_deSolve)

results <- tibble(out)


