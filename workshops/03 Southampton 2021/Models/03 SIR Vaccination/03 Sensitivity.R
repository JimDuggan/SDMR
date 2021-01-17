library(dplyr)
library(readxl)
library(tidyr)
library(ggplot2)
library(purrr)

res <- read_xlsx("workshops/03 Southampton 2021/Models/03 SIR Vaccination/Sensitivity Output.xlsx")

v1_tib <- res %>% select(Days,contains("Attack Rate")) %>%
          pivot_longer(names_to="Temp",values_to="AttackRate",-Days) %>%
          mutate(RunNumber=as.integer(str_extract(Temp,"\\d+"))) %>%
          select(-Temp) %>%
          select(RunNumber,Days,everything())

sim <- v1_tib 

v2_tib <- res %>% select(Days,contains("R0")) %>%
  pivot_longer(names_to="Temp",values_to="R0",-Days) %>%
  mutate(RunNumber=as.integer(str_extract(Temp,"\\d+"))) %>%
  select(-Temp) %>%
  select(RunNumber,Days,everything())

sim <- full_join(sim,v2_tib)

v3_tib <- res %>% select(Days,contains("Vaccination")) %>%
  pivot_longer(names_to="Temp",values_to="VF",-Days) %>%
  mutate(RunNumber=as.integer(str_extract(Temp,"\\d+"))) %>%
  select(-Temp) %>%
  select(RunNumber,Days,everything())

sim <- full_join(sim,v3_tib)

v4_tib <- res %>% select(Days,contains("DR")) %>%
  pivot_longer(names_to="Temp",values_to="DR",-Days) %>%
  mutate(RunNumber=as.integer(str_extract(Temp,"\\d+"))) %>%
  select(-Temp) %>%
  select(RunNumber,Days,everything())

sim <- full_join(sim,v4_tib)

sim_nested <- sim %>% group_by(RunNumber) %>% nest()

summ <- sim_nested %>% 
            pull(data) %>% 
                 map_df(~{
                   tibble(Max_AR=max(.$AttackRate),
                          Max_DR=max(.$DR),
                          R0=first(.$R0),
                          VF=first(.$VF))
})

sim_nested <- bind_cols(sim_nested, summ)


ggplot(sim_nested,aes(x=R0,y=VF,size=Max_DR,colour=Max_DR))+
  geom_point()+
  scale_color_gradient(low="blue", high="red")



