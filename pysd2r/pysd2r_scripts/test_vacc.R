Sys.setenv(RETICULATE_PYTHON="/usr/local/bin/python3")

library(pysd2r)
library(ggplot2)
library(plyr)
library(dplyr)

target <- "pysd2r/pysd2r_scripts/models/SIR.mdl"

cr <- seq(0,10,by=0.1)

py <- pysd_connect()
py <- read_vensim(py, target)

ans <- lapply(cr, function (c){
  l <- list("Contact Rate"=c)
  set_components(py,l)
  out     <- run_model(py)
  out$CR <-  c
  out     <- slice(out,nrow(out)) %>% 
             mutate(IFraction=Recovered/10000) %>%
             select(TIME,R0,Susceptible,IFraction,CR)
})

full <- rbind.fill(ans)

ggplot(data=full)+
  geom_line(aes(x=R0,y=IFraction))

ggplotly(ggplot(data=full)+
  geom_line(aes(x=R0,y=IFraction)))

