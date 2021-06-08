library(aimsir17)
library(dplyr)
library(ggplot2)

target <- c("DUBLIN AIRPORT",
            "MACE HEAD",
            "SherkinIsland")

data <- observations %>%
          filter(month==1) %>%
          filter(station %in% target)

ggplot(data,aes(x=date,y=temp,colour=station,size=rain))+geom_point()
