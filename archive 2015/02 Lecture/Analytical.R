library(ggplot2)
library(scales)
require(gridExtra)

INIT<-100
DT<-0.5
time<-seq(0,10,by=DT)
flow<-4*time # dy/dt = 4t
stock<-INIT + 2*time^2

p1<-ggplot()+
  geom_line(aes(time,flow,color="Flow"))+
  scale_y_continuous(breaks = seq(0, 100, 2))+
  scale_x_continuous(minor_breaks = seq(0 , 100, 0.5), breaks = seq(0, 100, 1))+
  geom_segment(aes(x=0,xend=1,y=0,yend=0),color="blue")+
  geom_rect(aes(xmin = 1, xmax = 2,   ymin = 0, ymax = 4),fill="red") +
  geom_rect(aes(xmin = 2, xmax = 3,   ymin = 0, ymax = 8),fill="blue") +
  geom_rect(aes(xmin = 3, xmax = 4,   ymin = 0, ymax = 12),fill="red") +
  geom_rect(aes(xmin = 4, xmax = 5,   ymin = 0, ymax = 16),fill="blue") +
  geom_rect(aes(xmin = 5, xmax = 6,   ymin = 0, ymax = 20),fill="red") +
  geom_rect(aes(xmin = 6, xmax = 7,   ymin = 0, ymax = 24),fill="blue") +
  geom_rect(aes(xmin = 7, xmax = 8,   ymin = 0, ymax = 28),fill="red") +
  geom_rect(aes(xmin = 8, xmax = 9,   ymin = 0, ymax = 32),fill="blue") +  
  geom_rect(aes(xmin = 9, xmax = 10,   ymin = 0, ymax = 36),fill="red") +
  ylab("Net Flow")+
  xlab("Time") +
  labs(color="")+
  theme(legend.position="bottom")


p2<-ggplot()+
  geom_line(aes(time,stock,color="Stock"))+
  scale_y_continuous(labels = comma)+
  ylab("Stock")+
  xlab("Time") +
  labs(color="")+
  theme(legend.position="bottom")

p3<-ggplot()+
  geom_line(aes(time,flow,color="Flow"))+
  scale_y_continuous(breaks = seq(0, 100, 2))+
  scale_x_continuous(minor_breaks = seq(0 , 100, 0.5), breaks = seq(0, 100, 1))+
  geom_segment(aes(x=0,xend=0.5,y=0,yend=0),color="blue")+
  geom_rect(aes(xmin = 0.5, xmax = 1,   ymin = 0, ymax = 2),fill="red") +
  geom_rect(aes(xmin = 1, xmax = 1.5,   ymin = 0, ymax = 4),fill="blue") +
  geom_rect(aes(xmin = 1.5, xmax = 2,   ymin = 0, ymax = 6),fill="red") +
  geom_rect(aes(xmin = 2, xmax = 2.5,   ymin = 0, ymax = 8),fill="blue") +
  geom_rect(aes(xmin = 2.5, xmax = 3,   ymin = 0, ymax = 10),fill="red") +
  geom_rect(aes(xmin = 3, xmax = 3.5,   ymin = 0, ymax = 12),fill="blue") +
  geom_rect(aes(xmin = 3.5, xmax = 4,   ymin = 0, ymax = 14),fill="red") +
  geom_rect(aes(xmin = 4, xmax = 4.5,   ymin = 0, ymax = 16),fill="blue") +  
  geom_rect(aes(xmin = 4.5, xmax = 5,   ymin = 0, ymax = 18),fill="red") +
  geom_rect(aes(xmin = 5, xmax = 5.5,   ymin = 0, ymax = 20),fill="blue") +  
  geom_rect(aes(xmin = 5.5, xmax = 6,   ymin = 0, ymax = 22),fill="red") +
  geom_rect(aes(xmin = 6, xmax = 6.5,   ymin = 0, ymax = 24),fill="blue") +  
  geom_rect(aes(xmin = 6.5, xmax = 7,   ymin = 0, ymax = 26),fill="red") +
  geom_rect(aes(xmin = 7, xmax = 7.5,   ymin = 0, ymax = 28),fill="blue") +  
  geom_rect(aes(xmin = 7.5, xmax = 8,   ymin = 0, ymax = 30),fill="red") + 
  geom_rect(aes(xmin = 8, xmax = 8.5,   ymin = 0, ymax = 32),fill="blue") +  
  geom_rect(aes(xmin = 8.5, xmax = 9,   ymin = 0, ymax = 34),fill="red") + 
  geom_rect(aes(xmin = 9, xmax = 9.5,   ymin = 0, ymax = 36),fill="blue") +  
  geom_rect(aes(xmin = 9.5, xmax = 10,   ymin = 0, ymax = 38),fill="red") + 
  ylab("Net Flow")+
  xlab("Time") +
  labs(color="")+
  theme(legend.position="bottom")

p4<-ggplot()+
  geom_line(aes(time,flow,color="Flow"))+
  scale_y_continuous(breaks = seq(0, 100, 2))+
  scale_x_continuous(minor_breaks = seq(0 , 100, 0.5), breaks = seq(0, 100, 1))+
  geom_segment(aes(x=0,xend=0.25,y=0,yend=0),color="blue")+
  geom_rect(aes(xmin = 0.25, xmax = 0.5,   ymin = 0, ymax = 1),fill="red") +
  geom_rect(aes(xmin = 0.5, xmax = 0.75,   ymin = 0, ymax = 2),fill="blue") +
  geom_rect(aes(xmin = 0.75, xmax = 1,   ymin = 0, ymax = 3),fill="red") +
  geom_rect(aes(xmin = 1.0, xmax = 1.25,   ymin = 0, ymax = 4),fill="blue") +
  geom_rect(aes(xmin = 1.25, xmax = 1.5,   ymin = 0, ymax = 5),fill="red") +
  geom_rect(aes(xmin = 1.5, xmax = 1.75,   ymin = 0, ymax = 6),fill="blue") +
  geom_rect(aes(xmin = 1.75, xmax = 2,   ymin = 0, ymax = 7),fill="red") +
  geom_rect(aes(xmin = 2, xmax = 2.25,   ymin = 0, ymax = 8),fill="blue") +  
  geom_rect(aes(xmin = 2.25, xmax = 2.5,   ymin = 0, ymax = 9),fill="red") +
  geom_rect(aes(xmin = 2.5, xmax = 2.75,   ymin = 0, ymax = 10),fill="blue") +  
  geom_rect(aes(xmin = 2.75, xmax = 3,   ymin = 0, ymax = 11),fill="red") +
  geom_rect(aes(xmin = 3, xmax = 3.25,   ymin = 0, ymax = 12),fill="blue") +  
  geom_rect(aes(xmin = 3.25, xmax = 3.5,   ymin = 0, ymax = 13),fill="red") +
  geom_rect(aes(xmin = 3.5, xmax = 3.75,   ymin = 0, ymax = 14),fill="blue") +  
  geom_rect(aes(xmin = 3.75, xmax = 4,   ymin = 0, ymax = 15),fill="red") + 
  geom_rect(aes(xmin = 4, xmax = 4.25,   ymin = 0, ymax = 16),fill="blue") +  
  geom_rect(aes(xmin = 4.25, xmax = 4.5,   ymin = 0, ymax = 17),fill="red") + 
  geom_rect(aes(xmin = 4.5, xmax = 4.75,   ymin = 0, ymax = 18),fill="blue") +  
  geom_rect(aes(xmin = 4.75, xmax = 5,   ymin = 0, ymax = 19),fill="red") + 
  geom_rect(aes(xmin = 5, xmax = 5.25,   ymin = 0, ymax = 20),fill="blue") +  
  geom_rect(aes(xmin = 5.25, xmax = 5.5,   ymin = 0, ymax = 21),fill="red") + 
  geom_rect(aes(xmin = 5.5, xmax = 5.75,   ymin = 0, ymax = 22),fill="blue") +  
  geom_rect(aes(xmin = 5.75, xmax = 6,   ymin = 0, ymax = 23),fill="red") + 
  geom_rect(aes(xmin = 6, xmax = 6.25,   ymin = 0, ymax = 24),fill="blue") +  
  geom_rect(aes(xmin = 6.25, xmax = 6.5,   ymin = 0, ymax = 25),fill="red") + 
  geom_rect(aes(xmin = 6.5, xmax = 6.75,   ymin = 0, ymax = 26),fill="blue") +  
  geom_rect(aes(xmin = 6.75, xmax = 7,   ymin = 0, ymax = 27),fill="red") + 
  geom_rect(aes(xmin = 7, xmax = 7.25,   ymin = 0, ymax = 28),fill="blue") +  
  geom_rect(aes(xmin = 7.25, xmax = 7.5,   ymin = 0, ymax = 29),fill="red") + 
  geom_rect(aes(xmin = 7.5, xmax = 7.75,   ymin = 0, ymax = 30),fill="blue") +  
  geom_rect(aes(xmin = 7.75, xmax = 8,   ymin = 0, ymax = 31),fill="red") + 
  geom_rect(aes(xmin = 8, xmax = 8.25,   ymin = 0, ymax = 32),fill="blue") +  
  geom_rect(aes(xmin = 8.25, xmax = 8.5,   ymin = 0, ymax = 33),fill="red") + 
  geom_rect(aes(xmin = 8.5, xmax = 8.75,   ymin = 0, ymax = 34),fill="blue") +  
  geom_rect(aes(xmin = 8.75, xmax = 9,   ymin = 0, ymax = 35),fill="red") + 
  geom_rect(aes(xmin = 9, xmax = 9.25,   ymin = 0, ymax = 36),fill="blue") +  
  geom_rect(aes(xmin = 9.25, xmax = 9.5,   ymin = 0, ymax = 37),fill="red") + 
  geom_rect(aes(xmin = 9.5, xmax = 9.75,   ymin = 0, ymax = 38),fill="blue") + 
  geom_rect(aes(xmin = 9.75, xmax = 10.0,   ymin = 0, ymax = 39),fill="red") + 
    ylab("Net Flow")+
  xlab("Time") +
  labs(color="")+
  theme(legend.position="bottom")

grid.arrange(p1, p2, nrow=1, ncol=2)