library(readsdr)
library(deSolve)
library(dplyr)

filepath <- "workshops/04 UCD MPH 2021/Models/01 SIR/SIR Basic.stmx"
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
