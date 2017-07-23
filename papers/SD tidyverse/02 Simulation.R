library(tidyverse)

res <- read_csv("papers/SD tidyverse/data/SimulationOutput.csv")

# Example of filter to show all times that end in whole number
filter(res, Time %% 1 == 0)
filter(res, Time %% 1 == 0) %>% filter(Time > 0, Time <=10)

colnames(res)

# Selecting specific variables (stocks)

select(res,Time,contains("Susceptible"),contains("Infected"),contains("Recovered"))




