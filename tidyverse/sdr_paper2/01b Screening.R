library(dplyr)
library(ggplot2)

source("tidyverse/sdr_paper2/R/tidy_sens.R")
source("tidyverse/sdr_paper2/R/stat_screen.R")

lst_file  <- "tidyverse/sdr_paper2/vensim/BusinessStructures.lst"
vsc_file  <- "tidyverse/sdr_paper2/vensim/BusinessStructures.vsc"
sens_file <- "tidyverse/sdr_paper2/data/Sensitivity.tab"


sens_vars <- get_sens_vars(lst_file)
params    <- get_sens_params(vsc_file)
sens_data <- get_sens_data(sens_file)

ans <- tidy_vensim(sens_vars, params, sens_data, DT=0.125, START=0)

cors <- stat_screen(ans, "Business Structures", params)

fig.4 <- ggplot(data=cors,aes(x=Time,y=Correlation, colour=Parameter))+
       geom_path()+ theme(legend.position = "top")+geom_point()+
       scale_y_continuous(limits = c(-1.0,1.0))

cors1 <- cors[c(T,F,F,F,F,F,F,F), ]
fig.4b <- ggplot(data=cors1,aes(x=Time,y=Correlation, colour=Parameter))+ 
  theme(legend.position = "top")+geom_point(aes(shape=Parameter))+
  scale_y_continuous(limits = c(-1.0,1.0))

  

ggsave("04_Figure.eps", dpi=600,plot = fig.4,height=4,width=6,units="in")
ggsave("04b_Figure.eps", dpi=600,plot = fig.4b,height=4,width=6,units="in")

