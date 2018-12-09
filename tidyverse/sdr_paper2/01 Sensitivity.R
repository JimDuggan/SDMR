library(dplyr)
library(ggplot2)

source("tidyverse/sdr_paper2/R/tidy_sens.R")

lst_file  <- "tidyverse/sdr_paper2/vensim/BusinessStructures.lst"
vsc_file  <- "tidyverse/sdr_paper2/vensim/BusinessStructures.vsc"
sens_file <- "tidyverse/sdr_paper2/data/Sensitivity.tab"


sens_vars <- get_sens_vars(lst_file)
params    <- get_sens_params(vsc_file)

ans <- tidy_vensim(sens_vars, params, sens_file, DT=0.125, START=0)

ggplot(filter(ans,ModelVariable=="Effect of Land Fraction Occupied on Growth Rate"),aes(x=Time,y=Value,color=Simulation, group=Simulation)) + 
  geom_path() + scale_colour_gradientn(colours=rainbow(10))+
  ylab("Business Structures") +
  xlab("Time (Days)")  + guides(color=FALSE) 


cor <- filter(ans,ModelVariable=="Business Structures") %>% group_by(Time) %>% 
  summarise(CorNGR=cor(Value,`Normal Growth Rate`),
            CorDF=cor(Value,`Demolition Fraction`),
            MeanBusinessStructures=mean(Value)) %>%
  mutate(MeanBusinessStructures=MeanBusinessStructures/max(MeanBusinessStructures)) %>%
  gather(Parameter,Value,2:4)


ggplot(data=cor,aes(x=SimTime,y=Value,colour=Parameter))+geom_line()

