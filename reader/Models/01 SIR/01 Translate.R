source("reader/Code/conv_to_deSolve.R")

output<-sim$translate_vensim("./reader/Models/01 SIR/SIR.txt")

sim$save_model(output,"./reader/Models/01 SIR/SIR.R")

# see the translator environment
ls.str(sim)
