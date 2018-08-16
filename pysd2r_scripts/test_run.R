Sys.setenv(RETICULATE_PYTHON="/usr/local/bin/python3")
library(pysd2r)
library(ggplot2)

target <- "pysd2r_scripts/models/Population.mdl"

py <- pysd_connect()

py <- read_vensim(py, target)

results <- run_model(py)

l <- list("Growth Fraction"=0.02)

set_components(py,l)
out2 <- run_model(py)

ggplot(data=results)+
  geom_point(aes(x=TIME,y=Population),colour="blue")+
  geom_point(data=out2,aes(x=TIME,y=Population),colour="red")
