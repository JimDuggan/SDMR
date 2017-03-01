library(gdata) 
library(dplyr)
library(tidyr)
library(lubridate)

ener <- as_data_frame(read.xls("data/energy/data/IrelandData January 2017.xlsx"),stringsAsFactors=F)

ener$DateTime <- ymd_hms(ener$DateTime)

ener$HourOfDay <- hour(ener$DateTime)
ener$DayOfWeek <- wday(ener$DateTime,label = T)

test <- select(ener,Date,Time,HourOfDay,DayOfWeek,Generation,Wind) %>% 
          mutate(PercentWind = Wind / Generation)

ener <- separate(ener,DateTime,c("Date","Time"),sep=" ")

daily <- ener %>% group_by(Date) %>% summarise(AverageDemand=mean(Demand),MaxDemand=max(Demand))

hourly <- ener %>% group_by(HourOfDay) %>% summarise(AverageDemand=mean(Demand),MaxDemand=max(Demand))

wkday <- ener %>% group_by(DayOfWeek) %>% summarise(AverageDemand=mean(Demand),MaxDemand=max(Demand))


ggplot(data = dt) +
  geom_point(mapping = aes(x=displ,y=hwy)) + facet_wrap(~class)





