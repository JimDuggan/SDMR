Sys.setenv(RETICULATE_PYTHON="/usr/local/bin/python3")
library(pysd2r)
library(ggplot2)

target <- "models/04 Chapter/Vensim/Health Model.mdl"

py <- pysd_connect()

py <- read_vensim(py, target)

results <- run_model(py)

