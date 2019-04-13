library(pysd2r)
source("metamodels/02 SIR Model/RunModel.R")

init_connection("metamodels/02 SIR Model/Vensim/01 SEIR.mdl")

results <- run_seir_model(1, 2, 2,2)

l <- list("R0"=3,"DelayI"=3,"DelayE"=4)
set_components(vensim_model,l)

ans <- run_model(vensim_model)
