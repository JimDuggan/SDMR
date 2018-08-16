Sys.setenv(RETICULATE_PYTHON="/usr/local/bin/python3")

library(pysd2r)
library(ggplot2)
library(plyr)
library(dplyr)

target <- "pysd2r_scripts/models/Population.mdl"

gr <- seq(0.01,0.04,by=0.0025)

py <- pysd_connect()
py <- read_vensim(py, target)

ans <- lapply(gr, function (g){
  l <- list("Growth Fraction"=g)
  set_components(py,l)
  out     <- run_model(py)
  out$Key <- paste0("GR=",g)
  out     <- select(out,TIME,Population,Key)
})

full <- rbind.fill(ans)

ggplot(data=full)+
  geom_point(aes(x=TIME,y=Population,colour=Key))

