library(ggplot2)

t11<-seq(0,5,by=1)
t12<-seq(5,10,by=1)

t21<-seq(0,5,by=0.5)
t22<-seq(5,10,by=0.5)

SLOPE<-2.0
MAX<-10.0
x11<-SLOPE*t11
x12<-MAX-SLOPE*(t12-5)

x21<-SLOPE*t21
x22<-MAX-SLOPE*(t22-5)

t1<-c(t11,t12)
x1<-c(x11,x12)

t2<-c(t21,t22)
x2<-c(x21,x22)


df1<-data.frame(Time=t1,NetFlow=x1)
df2<-data.frame(Time=t2,NetFlow=x2)

ggplot()+geom_line(data=df1,size=2,aes(Time,NetFlow,color="NetFlow"))+
  geom_step(data=df1,size=1,aes(Time,NetFlow,color="Step_DT2"))+
  ylab("Units/Time")+
  ggtitle("")+
  scale_colour_manual(guide=FALSE,
                      name="",
                      values=c(NetFlow="red",
                               Step_DT2="blue"),
                      labels=c("True Net Flow",
                               "Approx DR=0.5"))


ggplot()+geom_line(data=df1,size=2,aes(Time,NetFlow,color="NetFlow"))+
  geom_step(data=df2,size=1,aes(Time,NetFlow,color="Step_DT2"))+
  ylab("Units/Time")+
  ggtitle("")+
  scale_colour_manual(guide=FALSE,
                      name="",
                      values=c(NetFlow="red",
                               Step_DT2="blue"),
                      labels=c("True Net Flow",
                               "Approx DR=0.5"))
