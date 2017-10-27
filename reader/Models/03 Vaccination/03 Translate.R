source("reader/Code/conv_to_deSolve.R")

output<-sim$translate_vensim("./reader/Models/03 Vaccination/Vacc.txt")

sim$save_model(output,"./reader/Models/03 Vaccination/Vaccination.R")

# see the translator environment
ls.str(sim)
