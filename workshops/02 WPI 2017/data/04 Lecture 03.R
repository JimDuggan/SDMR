library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)

library(gdata) 

ener <- as_data_frame(read.xls("workshops/02 WPI 2017/data/energy/IrelandData January 2017.xlsx"),
                      stringsAsFactors=F)

ener <- mutate(ener, DateTime    =  ymd_hms(DateTime),
                     HourOfDay   =  hour(DateTime),
                     MinuteOfDay =  minute(DateTime),
                     DayOfWeek   =  wday(DateTime,label=T))


ener <- separate(ener,DateTime,c("Date","Time"),sep=" ",remove=F)


p1 <- ggplot(data = ener) +
  geom_line(mapping = aes(x=DateTime,y=Generation)) +
xlab("Date") + ylab("Generation") + ggtitle("Monthly Generation Data")

p2 <- ggplot(data = ener) +
  geom_line(mapping = aes(x=DateTime,y=Generation),colour="blue") +
  geom_line(mapping = aes(x=DateTime,y=Wind),colour="green")+
  xlab("Date") + ylab("Generation") + ggtitle("Monthly Generation Data")



p3 <- ggplot(data = filter(ener,Date=="2017-02-01")) +
  geom_line(mapping = aes(x=DateTime,y=Generation)) +
  xlab("Time of Day") + ylab("Generation")+ 
  ggtitle("Generation Data for 1st Feb 2017")

p4 <- ggplot(data = ener) +
  geom_point(mapping = aes(x=as.factor(Time),y=NetImports)) +
  xlab("Time (15 minute intervals)") + ylab("Net Imports") + 
  ggtitle("Time v Net Imports")


p5 <- ggplot(data = ener) +
  geom_point(mapping = aes(x=as.factor(HourOfDay),y=NetImports)) +
  xlab("Time (Hours)") + ylab("Net Imports") + 
  ggtitle("Time v Net Imports")

p6 <- ggplot(data = ener) +
  geom_point(mapping = aes(x=Demand,y=NetImports)) +
  xlab("Demand") + ylab("Net Imports") + 
  ggtitle("Demand v Net Imports")

p7 <- ggplot(data = ener) +
  geom_point(mapping = aes(x=Wind,y=CO2)) +
  xlab("Wind Generation") + ylab("CO2 Emissions") + 
  ggtitle("Wind Generation v CO2 Emissions")

p8 <- ggplot(data = ener) +
  geom_point(mapping = aes(x=Wind,y=CO2,colour=DayOfWeek)) +
  xlab("Wind Generation") + ylab("CO2 Emissions") + 
  ggtitle("Wind Generation v CO2 Emissions")

p9 <- ggplot(data = ener) +
  geom_point(mapping = aes(x=Wind,y=CO2,colour=DayOfWeek)) +
  facet_wrap(~DayOfWeek)+
  xlab("Wind Generation") + ylab("CO2 Emissions") + 
  ggtitle("Wind Generation v CO2 Emissions")









