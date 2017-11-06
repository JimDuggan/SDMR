source("reader/Code/conv_to_deSolve.R")

output<-sim$translate_vensim("./reader/Models/06 Retailer/VensimModel.txt")

sim$save_model(output,"./reader/Models/06 Retailer/Retailer.R")

# see the translator environment
ls.str(sim)
