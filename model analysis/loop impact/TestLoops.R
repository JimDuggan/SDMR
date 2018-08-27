#Sys.setenv(RETICULATE_PYTHON="/usr/local/bin/python3")

# Using the pysd2r library to facilitate model analysis.
library(pysd2r)
library(ggplot2)
library(dplyr)

target <- "model analysis/loop impact/Buildings LI All.mdl"

py <- pysd_connect()

py <- read_vensim(py, target)

results <- run_model(py)

li <- results %>% 
          select(TIME,`Business Structures`,starts_with(("ABS"))) %>%
          rename(B0 = `ABS B0 Impact`,
                 B1 = `ABS B1 Impact`,
                 R1 = `ABS R1 Impact`) %>%
          mutate(Dominant=case_when(
                 R1 > (B0+B1) ~ "R1",
                 B0 + B1 > R1 ~ "B0&B1",
                 B1 > R1 ~ "B1",
                 B0 > R1 ~ "B0",
                 TRUE ~ "UNDEF")) %>%
         filter(Dominant !="UNDEF" )

ggplot(data=li)+geom_line(aes(x=TIME,y=`Business Structures`,colour=Dominant))

