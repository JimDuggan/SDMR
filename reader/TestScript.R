source("reader/conv_to_deSolve.R")

output<-sim$translate_vensim("./reader/SIR.txt")

sim$save_model(output,"./reader/SIR.R")

# see the translator environment
ls.str(sim)
