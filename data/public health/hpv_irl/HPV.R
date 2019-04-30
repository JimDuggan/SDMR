library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)

d <- read_csv("data/public health/hpv_irl/HPV Ireland Summary Data.csv")
d$VMax <-  apply(d[,2:3],1,max)
d$VMin <-  apply(d[,2:3],1,min)
d$Percent <- round(100*d$Vaccinations/d$Denominator,2)

d <- select(d, Year, VMin, VMax, everything())

td <- gather(d,key = Variable,value = Total, 4:5) %>% arrange(Year)


ggplot(d,aes(x=Year,y=Percent))+geom_line(colour="blue")+geom_point(colour="black")+
  coord_cartesian(ylim=c(0,100))+
  ggtitle("Uptake(%) of Stage 1 HPV Vaccine 2012-2017")


ggplot(td) + 
  geom_point(aes(x=Year, y=Total, colour=Variable)) +
  geom_ribbon(aes(x=Year, ymin=VMin, ymax=VMax), fill="red", alpha=.3) +
  geom_line(aes(x=Year, y=Total, colour=Variable))+
  scale_color_manual(values=c("black", "blue"))+
  theme(legend.position="top")+
  ggtitle("Actual Uptake of Stage 1 HPV Vaccine 2012-2017")
