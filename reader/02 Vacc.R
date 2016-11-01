source("reader/conv_to_deSolve.R")

output<-sim$translate_vensim("./reader/Cust.txt")

sim$save_model(output,"./reader/Customer.R")
