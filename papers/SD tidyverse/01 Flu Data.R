library(tidyverse)

inc <- read_csv("papers/SD tidyverse/data/Incidence.csv")
coh <- read_csv("papers/SD tidyverse/data/Cohorts.csv")

t_inc <- gather(inc,Cohort,Incidence,Young:Elderly)

ggplot(filter(t_inc,Cohort=="Young"),aes(x=Week,y=Incidence)) + geom_line() + geom_point()

ggplot(t_inc,aes(x=Week,y=Incidence,color=Cohort)) + geom_line()

ggplot(t_inc,aes(x=Week,y=Incidence,fill=Cohort)) + geom_area()

# Get the total per week and then show the attack rates
wk_tot <- t_inc %>% group_by(Week) %>%
             summarise(Incidence=sum(Incidence))

wk_tot <- mutate(wk_tot,AttackRate=100*Incidence/8000)

arrange(wk_tot,desc(Incidence))


# get the totals sick by cohort
t_inc %>% group_by(Cohort) %>% 
           summarise(TotalInfected=sum(Incidence),
                     PeakValue=max(Incidence),
                     AvrValue=mean(Incidence),
                     SD=sd(Incidence),
                     MinValue=min(Incidence),
                     MaxValue=max(Incidence))

# get the totals sick by week

