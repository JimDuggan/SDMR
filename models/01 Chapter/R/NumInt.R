library(ggplot2)

t1<-seq(0,5,by=1)
t2<-seq(0,5,by=0.5)
t3<-seq(0,5,by=0.25)
t4<-seq(0,5,by=0.125)
x1<-1.5*t1
x2<-1.5*t2
x3<-1.5*t3
x4<-1.5*t4

df1<-data.frame(Time=t1,NetFlow=x1)
df2<-data.frame(Time=t2,NetFlow=x2)
df3<-data.frame(Time=t3,NetFlow=x3)
df4<-data.frame(Time=t4,NetFlow=x4)

ggplot()+geom_line(data=df1,size=2,aes(Time,NetFlow,color="NetFlow"))+
  geom_step(data=df1,size=1,aes(Time,NetFlow,color="Step_DT1"))+
  geom_step(data=df2,size=1,aes(Time,NetFlow,color="Step_DT2"))+
  geom_step(data=df3,size=1,aes(Time,NetFlow,color="Step_DT3"))+
  geom_step(data=df4,size=1,aes(Time,NetFlow,color="Step_DT4"))+
  ylab("Units/Time")+
  ggtitle("")+
  scale_colour_manual(name="",
                      values=c(NetFlow="red",
                               Step_DT1="blue",
                               Step_DT2="purple",
                               Step_DT3="black",
                               Step_DT4="green"),
                      labels=c("True Net Flow",
                               "Approx DT=1",
                               "Approx DT=0.5",
                               "Approx DT=0.25",
                               "Approx DT=0.125"))
