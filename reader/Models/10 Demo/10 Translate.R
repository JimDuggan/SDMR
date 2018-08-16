source("reader/Code/conv_to_deSolve.R")

output<-sim$translate_vensim("./reader/Models/10 Demo/Pop.Txt")

sim$save_model(output,"./reader/Models/10 Demo/Population.R")

# see the translator environment
ls.str(sim)

