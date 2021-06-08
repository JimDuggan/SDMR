library(dplyr)
library(readxl)
library(tidyr)
library(ggplot2)
library(purrr)
library(stringr)

res <- read_xlsx("workshops/06 Atlantec 21/models/SENS.xlsx")

v1_tib <- res %>% select(Days,contains("IR")) %>%
  pivot_longer(names_to="Temp",values_to="Incidence",-Days) %>%
  mutate(RunNumber=as.integer(str_extract(Temp,"\\d+"))) %>%
  select(-Temp) %>%
  select(RunNumber,Days,everything())

sim <- v1_tib

v2_tib <- res %>% select(Days,contains("QF")) %>%
  pivot_longer(names_to="Temp",values_to="QF",-Days) %>%
  mutate(RunNumber=as.integer(str_extract(Temp,"\\d+"))) %>%
  select(-Temp) %>%
  select(RunNumber,Days,everything())

sim <- full_join(sim,v2_tib)

v3_tib <- res %>% select(Days,contains("Infectivity")) %>%
  pivot_longer(names_to="Temp",values_to="Infectivity",-Days) %>%
  mutate(RunNumber=as.integer(str_extract(Temp,"\\d+"))) %>%
  select(-Temp) %>%
  select(RunNumber,Days,everything())

sim <- full_join(sim,v3_tib)

sim_nested <- sim %>% 
  group_by(RunNumber) %>% 
  nest()

summ <- sim_nested %>% 
  pull(data) %>% 
  map_df(~{
    tibble(MaxIncidence=max(.$Incidence),
           Infectivity=first(.$Infectivity),
           QuarantineFraction=first(.$QF))
  })

sim_nested <- bind_cols(sim_nested, summ)


ggplot(sim_nested,aes(x=Infectivity,y=QuarantineFraction,size=MaxIncidence,colour=MaxIncidence))+
  geom_point()+
  scale_color_gradient(low="blue", high="red")+
  geom_vline(xintercept = 0.075,size=1.5,alpha=0.6)+
  geom_hline(yintercept = 0.25,size=1.5,alpha=0.6)





