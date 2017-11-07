source("reader/Code/conv_to_deSolve.R")

output<-sim$translate_vensim("reader/Models/07 Adjustment/Vensim.txt")

sim$save_model(output,"reader/Models/07 Adjustment/SMS.R")

# see the translator environment
ls.str(sim)
