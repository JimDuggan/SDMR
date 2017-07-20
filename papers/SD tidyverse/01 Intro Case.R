library(tidyverse)

inc <- read_csv("papers/SD tidyverse/data/Incidence.csv")

t_inc <- gather(inc,Cohort,Incidence,Young:Elderly)

ggplot(filter(t_inc,Cohort=="Young"),aes(x=Week,y=Incidence)) + geom_line() + geom_point()

ggplot(t_inc,aes(x=Week,y=Incidence,color=Cohort)) + geom_line()

ggplot(t_inc,aes(x=Week,y=Incidence,fill=Cohort)) + geom_area()


