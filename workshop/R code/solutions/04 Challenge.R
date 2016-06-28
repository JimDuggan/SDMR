library(gdata)
library(ggplot2)
library(reshape2)

sim <- read.xls("workshop/R code/01 session/SimData.xlsx",
                stringsAsFactors=FALSE)
sim$Total<-apply(sim[,2:5],MARGIN = 1,sum)

prop<-data.frame(Time=sim$Time,
                 Age.0.14=sim$Age.0.14/sim$Total,
                 Age.15.39=sim$Age.15.39/sim$Total,
                 Age.40.64=sim$Age.40.64/sim$Total,
                 Age.Over.65=sim$Age.Over.65/sim$Total)

CheckSum<-apply(prop[,2:5],MARGIN = 1,sum)
unique(CheckSum) # check that all props sum to 1

mprop<-melt(prop,id.vars = "Time")
names(mprop)<-c("Year","Cohort","Population")
ggplot()+geom_area(data=mprop,aes(x=Year,y=Population,fill=Cohort))


