library(tidyverse)

res <- read_csv("papers/SD tidyverse/data/SimulationOutput.csv")

colnames(res)

# Selecting specific variables (stocks)

out <- res %>% 
         select(Time,starts_with("Susceptible"),
                     starts_with("Infected"),
                     starts_with("Recovered"))

out_td <- out %>% gather(key=Variable,value = Amount,-(Time)) %>%
                  mutate(Cohort=case_when(
                                 grepl("A$",Variable) ~ "Adult", 
                                 grepl("E$",Variable) ~ "Elderly", 
                                 grepl("Y$",Variable) ~ "Young"),
                         Class=case_when(
                                 grepl("^S",Variable) ~ "Susceptible", 
                                 grepl("^I",Variable) ~ "Infected", 
                                 grepl("^R",Variable) ~ "Recovered")) %>%
                  mutate(Class=factor(Class,
                                       levels=c("Susceptible","Infected","Recovered")))


ggplot(out_td) + geom_path(aes(x=Time,y=Amount,colour=Variable))+
  facet_wrap(~Cohort)+guides(colour=F)

ggplot(out_td) + geom_area(aes(x=Time,y=Amount,fill=Variable))+
  facet_wrap(~Variable)

ggplot(out_td) + geom_area(aes(x=Time,y=Amount,fill=Cohort))+
  facet_wrap(~Class)

peaks <- out_td %>% filter(Class=="Infected") %>% 
                    group_by(Variable) %>% 
                    summarise(MaxInfected=max(Amount),
                              TimeMaxInfected=Time[which.max(Amount)])




