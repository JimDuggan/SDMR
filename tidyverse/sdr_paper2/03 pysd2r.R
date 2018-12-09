Sys.setenv(RETICULATE_PYTHON="/Library/Frameworks/Python.framework/Versions/3.6/bin/python3")

library(pysd2r)
library(ggplot2)
library(plyr)
library(dplyr)

target <- "tidyverse/sdr_paper2/vensim/BusinessStructures.mdl"

gr <- seq(0.01,0.20,by=0.005)

py <- pysd_connect()
py <- read_vensim(py, target)

ans <- lapply(seq_along(gr), function (g_index){
  l <- list("Normal Growth Rate"=gr[g_index])
  set_components(py,l)
  out     <- run_model(py)
  out$RunNumber <- g_index
  out     <- select(out,TIME,RunNumber,`Business Structures`)
})

full <- rbind.fill(ans)

ggplot(data=full)+
  geom_point(aes(x=TIME,y=`Business Structures`,colour=as.factor(RunNumber)),show.legend = FALSE) +
  xlab("Time")
             
