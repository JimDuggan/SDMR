# inflow
entering <- c(14, 16, 22, 37, 28, 27, 24, 29, 21, 22, 21, 22, 18, 19, 16, 
              12,  7, 13, 16, 15, 23, 10,  8, 15, 12, 11, 12, 10, 11, 10)

#outflow
leaving <-  c(10, 11, 15, 26, 18, 20, 18,  9, 16, 14, 16, 15, 16, 25, 26, 
              25, 30, 22, 28, 27, 38, 23, 21, 26, 23, 24, 25, 20, 21, 17)

people_in_store    <- vector(mode="numeric",length = 30)
people_in_store[1] <- 100 # initial stock

DT <- 1
for(i in 2:length(people_in_store)){
  people_in_store[i] <- people_in_store[i-1] + 
                          (entering[i-1] - leaving [i-1]) * DT
}

library(ggplot2)

df<- data.frame(time=1:30,Entering=entering,Leaving=leaving,People_in_Store=people_in_store)

df$net<-df$Entering-df$Leaving
df$behaviour<-ifelse(df$net>0,"Inc","Dec")

ggplot(df,aes(x=time,y=net))+
  geom_area(aes(fill=behaviour))+
  geom_line()+
  geom_hline(yintercept = 0)

ggplot(df,aes(x=time,y=People_in_Store))+
  geom_line(colour="blue")+ylab("People in Store")




