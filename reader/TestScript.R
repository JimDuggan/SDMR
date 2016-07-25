source("reader/conv_to_deSolve.R")

output<-sim$translate("./reader/SIR.txt")

sim$save_model(output,"./reader/SIR.R")


