library(tidyverse)

inc <- read_csv("papers/SD tidyverse/data/Incidence.csv")

t_inc <- gather(inc,Cohort,Incidence,Young:Elderly)

ggplot(filter(t_inc,Cohort=="Young"),aes(x=Week,y=Incidence)) + geom_line() + geom_point()

ggplot(t_inc,aes(x=Week,y=Incidence,color=Cohort)) + geom_line()

ggplot(t_inc,aes(x=Week,y=Incidence,fill=Cohort)) + geom_area()

# get the totals sick by cohort
t_inc %>% group_by(Cohort) %>% 
           summarise(TotalInfected=sum(Incidence),
                     PeakValue=max(Incidence),
                     AvrValue=mean(Incidence),
                     SD=sd(Incidence),
                     MinValue=min(Incidence),
                     MaxValue=max(Incidence))

# get the totals sick by week

