library(ggplot2)

t1<-seq(0,10,by=1)
t2<-seq(0,5,by=0.5)
t3<-seq(0,5,by=0.25)
t4<-seq(0,5,by=0.125)
x1<-2.0*t1
x2<-2.0*t2
x3<-2.0*t3
x4<-2.0*t4

df1<-data.frame(Time=t1,NetFlow=x1)
df2<-data.frame(Time=t2,NetFlow=x2)
df3<-data.frame(Time=t3,NetFlow=x3)
df4<-data.frame(Time=t4,NetFlow=x4)



ggplot()+geom_line(data=df1,size=2,aes(Time,NetFlow,color="NetFlow"))+
  geom_step(data=df1,size=0.5,aes(Time,NetFlow,color="Step_DT1"))+
  ylab("Units/Time")+
  geom_segment(aes(x=1,xend=1,y=0,yend=2),linetype="dashed")+
  geom_rect(aes(xmin=1, xmax=2, ymin=0, ymax=2),alpha=0.5)+
  geom_rect(aes(xmin=2, xmax=3, ymin=0, ymax=4),alpha=0.25)+
  geom_rect(aes(xmin=3, xmax=4, ymin=0, ymax=6),alpha=0.5)+
  geom_rect(aes(xmin=4, xmax=5, ymin=0, ymax=8),alpha=0.25)+
  geom_rect(aes(xmin=5, xmax=6, ymin=0, ymax=10),alpha=0.5)+
  geom_rect(aes(xmin=6, xmax=7, ymin=0, ymax=12),alpha=0.25)+
  geom_rect(aes(xmin=7, xmax=8, ymin=0, ymax=14),alpha=0.5)+
  geom_rect(aes(xmin=8, xmax=9, ymin=0, ymax=16),alpha=0.25)+
  geom_rect(aes(xmin=9, xmax=10, ymin=0, ymax=18),alpha=0.5)+
  ggtitle("")+
  theme(legend.position="bottom")+
  scale_colour_manual(name="",
                      values=c(NetFlow="blue",
                               Step_DT1="red"),
                      labels=c("True Net Flow",
                               "Approx With DT=1"))

ggsave("Fig1_4.png",dpi=1600)