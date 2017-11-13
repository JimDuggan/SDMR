source("reader/Code/conv_to_deSolve.R")

output<-sim$translate_vensim("reader/Models/08 Beer Game/Vensim Equations")

sim$save_model(output,"reader/Models/08 Beer Game/01 Beer Game.R")

# see the translator environment
ls.str(sim)
