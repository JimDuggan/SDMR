
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


ggplot(data = ener) +
  geom_line(mapping = aes(x=DateTime,y=Generation)) +
  xlab("Date") + ylab("Generation") +
  ggtitle("Monthly Generation Data")

ggplot(data = filter(ener,Date=="2017-02-01")) +
  geom_line(mapping = aes(x=DateTime,y=Generation)) +
  xlab("Time of Day") + ylab("Generation")+
  ggtitle("Generation Data for 1st Feb 2017")

ggplot(data = ener) +
  geom_line(mapping = aes(x=DateTime,y=Wind)) +
  xlab("Date") + ylab("Generation") +
  ggtitle("Monthly Wind Generation Data")




test <- select(ener,Date,Time,HourOfDay,DayOfWeek,Generation,Wind) %>% 
          mutate(PercentWind = Wind / Generation)



daily <- ener %>% group_by(Date) %>% summarise(AverageDemand=mean(Demand),MaxDemand=max(Demand))

hourly <- ener %>% group_by(HourOfDay) %>% summarise(AverageDemand=mean(Demand),MaxDemand=max(Demand))

wkday <- ener %>% group_by(DayOfWeek) %>% summarise(AverageDemand=mean(Demand),MaxDemand=max(Demand))


ggplot(data = dt) +
  geom_point(mapping = aes(x=displ,y=hwy)) + facet_wrap(~class)





