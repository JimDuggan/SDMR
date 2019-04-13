library(pysd2r)

init_connection <- function (target){
  py <- pysd_connect()
  py <- read_vensim(py, target)
  vensim_model <<- py
}

run_sir_model <- function(trial,r0, delay){
  l <- list("R0"=r0,"DelayI"=delay)
  set_components(vensim_model,l)
  ans <- run_model(vensim_model)

  ans %>% mutate(Time=TIME,Trial=trial) %>% 
          select(Trial,Time,R0,DelayI,Susceptible,Infected,Recovered) -> ans 
  
  ans
}

run_seir_model <- function(trial,r0, delayE, delayI){
  l <- list("R0"=r0,"DelayE"=delayE,"DelayI"=delayI)
  set_components(vensim_model,l)
  ans <- run_model(vensim_model)

  ans %>% mutate(Time=TIME,Trial=trial) %>% 
    select(Trial,Time,R0,DelayE,DelayI,Susceptible,Infected,Recovered) -> ans 
  
  ans
}