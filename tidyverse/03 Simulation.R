library(tidyverse)

res <- read_csv("tidyverse/data/SimulationOutput.csv")

colnames(res)

# Selecting specific variables (stocks)

out <- res %>% 
         select(Time,starts_with("Susceptible"),
                     starts_with("Infected"),
                     starts_with("Recovered"))


out_td <- out %>% gather(key=Variable,value = Amount,`Susceptible A`:`Recovered Y`)

new_td <- out_td %>% 
           mutate(Cohort=case_when(
                   grepl("A$",Variable) ~ "Adult", 
                   grepl("E$",Variable) ~ "Elderly", 
                   grepl("Y$",Variable) ~ "Young"),
                  Class=case_when(
                   grepl("^S",Variable) ~ "Susceptible", 
                   grepl("^I",Variable) ~ "Infected", 
                   grepl("^R",Variable) ~ "Recovered"))


ggplot(new_td) + geom_path(aes(x=Time,y=Amount,colour=Variable))+
  ylab("Number of Cases")+
  facet_wrap(~Cohort)+guides(colour=F)

ggplot(new_td) + geom_line(aes(x=Time,y=Amount,colour=Class))+
  facet_wrap(~Variable)

ggplot(new_td) + geom_area(aes(x=Time,y=Amount,fill=Cohort))+
  facet_wrap(~Class)

peaks <- new_td %>% filter(Class=="Infected") %>% 
                    group_by(Variable) %>% 
                    summarise(MaxInfected=max(Amount),
                              TimeMaxInfected=Time[which.max(Amount)])

agg <- new_td %>% group_by(Time,Class) %>%
         summarise(Total=sum(Amount))

slice(agg,1:6)

fig.4 <- ggplot(agg,aes(x=Time,y=Total,colour=Class, shape=Class)) + geom_point() +geom_line()

#fig.4.bw <- ggplot(agg,aes(x=Time,y=Total,shape=Class)) + geom_point() +
#            geom_line()+scale_fill_grey()

ggsave("Figure_4.eps",dpi=600,plot = fig.4)
ggsave("Figure_4_bw.eps",dpi=600,plot = fig.4.bw)





