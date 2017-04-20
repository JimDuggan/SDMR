library(dplyr)
library(gdata) 
library(tidyr)



nyc <- nycflights13::flights

filter(nyc,arr_delay > 120)

filter(nyc,dest=="IAH" | dest == "HOU")

filter(nyc, dep_delay <=0 & arr_delay > 120)

arrange(nyc,year,month,day)

arrange(nyc,desc(arr_delay))

select(nyc,year, month,day)

flights_sml <- select(nyc,year:day,ends_with("delay"),distance,air_time)

mutate(flights_sml, 
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)


by_day <- group_by(nyc,year,month,day)

summarize(by_day, AverageDelay = mean(dep_delay,na.rm=T))

group_by(nyc,year,month,day) %>% 
  summarize(AverageDelay = mean(dep_delay,na.rm=T))

data <- as_data_frame(read.xls("data/energy/ExamData.xlsx"),stringsAsFactors=F)

tdata <- gather(data,key = Subject, value = Result,CX1000:CX1009)

tdata %>% group_by(Student.ID) %>% 
           summarise(Average=mean(Result),Minimum=min(Result),Maximum=max(Result)) 

tdata %>% group_by(Subject) %>% 
  summarise(Average=mean(Result),Minimum=min(Result),Maximum=max(Result)) 

tdata %>% group_by(Student.ID) %>% 
  summarise(Average=mean(Result), Minimum=min(Result),Maximum=max(Result),
            ExamsTaken= n(),Fails=sum(Result<40),Passed=sum(Result>=40 & Result<50),
            H2.2=sum(Result>=50 & Result<60), H2.1=sum(Result>=60 & Result<70),
            H1.1=sum(Result>=70 & Result<100))
            









