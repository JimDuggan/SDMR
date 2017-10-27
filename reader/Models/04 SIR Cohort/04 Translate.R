source("reader/Code/conv_to_deSolve.R")

output<-sim$translate_vensim("./reader/Models/04 SIR Cohort/Cohort.txt")

sim$save_model(output,"./reader/Models/04 SIR Cohort/Cohort.R")

# see the translator environment
ls.str(sim)
