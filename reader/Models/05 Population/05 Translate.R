source("reader/Code/conv_to_deSolve.R")

output<-sim$translate_vensim("./reader/Models/05 Population/Population.txt")

sim$save_model(output,"./reader/Models/05 Population/Population.R")

# see the translator environment
ls.str(sim)
