library(dplyr)
library(readxl)
library(tidyr)
library(ggplot2)

res <- read_xlsx("workshops/03 Southampton 2021/Models/01 SIR Cohorts/SimulationOutput.xlsx")

colnames(res)

# Selecting specific variables (stocks)

out <- res %>% 
         select(Time,starts_with("Susceptible"),
                     starts_with("Infected"),
                     starts_with("Recovered"))

out_td <- out %>% pivot_longer(names_to="Variable",
                               values_to="Value",
                               `Susceptible A`:`Recovered Y`)

new_td <- out_td %>% 
           mutate(Cohort=case_when(
                   grepl("A$",Variable) ~ "Adult", 
                   grepl("E$",Variable) ~ "Elderly", 
                   grepl("Y$",Variable) ~ "Young"),
                  Class=case_when(
                   grepl("^S",Variable) ~ "Susceptible", 
                   grepl("^I",Variable) ~ "Infected", 
                   grepl("^R",Variable) ~ "Recovered"))


ggplot(new_td) + geom_path(aes(x=Time,y=Value,colour=Variable))+
  ylab("Number of Cases")+
  facet_wrap(~Cohort)+guides(colour=F)

ggplot(new_td) + geom_line(aes(x=Time,y=Value,colour=Class))+
  facet_wrap(~Variable)

ggplot(new_td) + geom_area(aes(x=Time,y=Value,fill=Cohort))+
  facet_wrap(~Class)

agg <- new_td %>% group_by(Time,Class) %>%
         summarise(Total=sum(Value))

slice(agg,1:6)

ggplot(agg,aes(x=Time,y=Total,colour=Class, shape=Class)) + 
  geom_point() +
  geom_line()


peaks <- new_td %>% filter(Class=="Infected") %>% 
  group_by(Variable) %>% 
  summarise(MaxInfected=max(Value),
            TimeMaxInfected=Time[which.max(Value)])


#fig.4.bw <- ggplot(agg,aes(x=Time,y=Total,shape=Class)) + geom_point() +
#            geom_line()+scale_fill_grey()

#ggsave("Figure_4.eps",dpi=600,plot = fig.4)
#ggsave("Figure_4_bw.eps",dpi=600,plot = fig.4.bw)





