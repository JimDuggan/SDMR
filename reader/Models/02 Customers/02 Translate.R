source("reader/Code/conv_to_deSolve.R")

output<-sim$translate_vensim("./reader/Models/02 Customers/Cust.txt")

sim$save_model(output,"./reader/Models/02 Customers/Customers.R")

# see the translator environment
ls.str(sim)
