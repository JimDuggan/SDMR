source("reader/Code/conv_to_deSolve.R")

output<-sim$translate_vensim("reader/Models/09 Vacc Model/Vensim Equations")

sim$save_model(output,"reader/Models/09 Vacc Model/Vacc.R")

# see the translator environment
ls.str(sim)

