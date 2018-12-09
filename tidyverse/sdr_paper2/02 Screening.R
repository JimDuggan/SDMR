library(dplyr)
library(ggplot2)

source("tidyverse/sdr_paper2/R/tidy_sens.R")
source("tidyverse/sdr_paper2/R/stat_screen.R")

lst_file  <- "tidyverse/sdr_paper2/vensim/BusinessStructures.lst"
vsc_file  <- "tidyverse/sdr_paper2/vensim/BusinessStructures.vsc"
sens_file <- "tidyverse/sdr_paper2/data/Sensitivity.tab"


sens_vars <- get_sens_vars(lst_file)
params    <- get_sens_params(vsc_file)
ans       <- tidy_vensim(sens_vars, params, sens_file, DT=0.125, START=0)

cors <- stat_screen(ans, sens_vars, params)

ggplot(data=cors,aes(x=Time,colour=ModelParameter,y=Correlation))+
       geom_path()+
       facet_wrap(~ModelVariable)


