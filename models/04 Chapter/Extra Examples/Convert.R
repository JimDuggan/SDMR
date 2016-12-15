source("reader/conv_to_deSolve.R")

output<-sim$translate_vensim("models/04 Chapter/Extra Examples/Vensim.txt")

sim$save_model(output,"models/04 Chapter/Extra Examples/FixedDelay.R")
