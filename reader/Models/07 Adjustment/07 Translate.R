source("reader/Code/conv_to_deSolve.R")

output<-sim$translate_vensim("")

sim$save_model(output,"")

# see the translator environment
ls.str(sim)
