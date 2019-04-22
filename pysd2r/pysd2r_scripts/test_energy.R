Sys.setenv(RETICULATE_PYTHON="/anaconda3/bin/python3")
library(pysd2r)
library(ggplot2)

target <- "pysd2r/pysd2r_scripts/models/Energy.mdl"

get_python_info()

py <- pysd_connect()

py <- read_vensim(py, target)

results <- run_model(py)

results



