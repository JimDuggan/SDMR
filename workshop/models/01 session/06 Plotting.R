library(gdata)
library(ggplot2)
library(reshape2)

# open excel file..
sim <- read.xls("workshop/R code/01 session/SimData.xlsx",
                stringsAsFactors=FALSE)
sim$Total<-apply(sim[,2:5],MARGIN = 1,sum)
sub<-sim[c( TRUE, rep(FALSE,7)),]

# a simple plot
plot(y=sim$Total,x=sim$Time,xlab="Time",ylab="Population")

# simple ggplot example
df<-data.frame(xval=1:4,
               yval=c(3,3,9,8),
               group=c("A","A","B","B"))
ggplot()+geom_point(data=df,aes(x=xval,y=yval),colour="blue",size=5)+
         xlab("X Axis") + ylab("Y Axis")

ggplot()+geom_line(data=df,aes(x=xval,y=yval),colour="red",size=2)+
  geom_point(data=df,aes(x=xval,y=yval),colour="blue",size=5)+
  xlab("X Axis") + ylab("Y Axis")

# a nice way to visualise information, colouring by group
ggplot(df,aes(x=xval,y=yval))+geom_point(aes(colour=group),size=5)


# one time series
ggplot()+geom_point(data=sub,aes(x=Time,y=Total))

# multiple time series
ggplot()+geom_line(data=sub,aes(x=Time,y=Age.0.14),color="red")+
         geom_line(data=sub,aes(x=Time,y=Age.15.39),color="blue")+
         geom_line(data=sub,aes(x=Time,y=Age.40.64),color="green")+
         geom_line(data=sub,aes(x=Time,y=Age.Over.65),color="black")+
         ylab("Cohorts")

# using the power of ggplot
sub$Total<-NULL
msub<-melt(sub,id.vars = "Time")
names(msub)<-c("Year","Cohort","Population")
ggplot()+geom_area(data=msub,aes(x=Year,y=Population,fill=Cohort))


