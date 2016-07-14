library(gdata)
library(ggplot2)
library(reshape2)

# open excel file..
sim <- read.xls("workshop/models/01 session/SimData.xlsx",
                stringsAsFactors=FALSE)
sim$Total<-apply(sim[,2:5],MARGIN = 1,sum)
sub<-sim[c( TRUE, rep(FALSE,7)),]

# a simple plot
plot(y=sim$Total,x=sim$Time,xlab="Time",ylab="Population")

# simple ggplot example
df<-data.frame(xval=1:4,
               yval=c(3,3,9,8),
               group=c("A","A","B","B"))

ggplot(data=df,aes(x=xval,y=yval))+
        geom_point(colour="blue",size=5)+
        xlab("X Axis") + ylab("Y Axis")


ggplot(data=df,aes(x=xval,y=yval))+
  geom_line(colour="red")+
  xlab("X Axis") + ylab("Y Axis")

ggplot(data=df,aes(x=xval,y=yval))+
  geom_point(colour="blue",size=5)+
  geom_line(colour="red")+
  xlab("X Axis") + ylab("Y Axis")


# a nice way to visualise information, colouring by group
ggplot(df,aes(x=xval,y=yval))+
  geom_point(aes(colour=group),size=5)


# one time series
ggplot(data=sub,aes(x=Time,y=Total))+
       geom_point()

# multiple time series
ggplot(data=sub)+geom_line(aes(x=Time,y=Age.0.14),color="red")+
         geom_line(aes(x=Time,y=Age.15.39),color="blue")+
         geom_line(aes(x=Time,y=Age.40.64),color="green")+
         geom_line(aes(x=Time,y=Age.Over.65),color="black")+
         ylab("Cohorts")

# using the power of ggplot
sub$Total<-NULL
msub<-melt(sub,id.vars = "Time")
names(msub)<-c("Year","Cohort","Population")
ggplot(data=msub)+geom_area(aes(x=Year,y=Population,fill=Cohort))

ggplot(data=msub)+geom_line(aes(x=Year,y=Population,colour=Cohort))

# Controllimg plot resolution
p1<-ggplot(data=msub)+geom_area(aes(x=Year,y=Population,fill=Cohort))
ggsave(file="workshop/models/01 session/hq_plot.png", height=5,width=7,units="in",
       dpi=400,p1)


