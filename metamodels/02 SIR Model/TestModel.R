library(pysd2r)
source("metamodels/02 SIR Model/RunModel.R")

init_connection("metamodels/02 SIR Model/Vensim/01 SIR Aggregate.mdl")

results <- run_sir_model(1, 2, 2)
