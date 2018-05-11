library(tidyverse)
library(stringr)


# Read in the Vensim data
d <- read_tsv("tidyverse/data/Sensitivity.dat")

# Convert to tidy data format and calculate the simulation time

START_TIME <- 0
DT <- 0.125

td <- gather(d,TimeVariable,Value,-(Simulation:VF)) %>% 
          mutate(TSeq=parse_integer(str_extract(TimeVariable,"\\d+"))) %>%
          mutate(SimTime=START_TIME+(TSeq-1)*DT) %>%
          separate(TimeVariable,into = c("T","Variable")) %>%
          select(Simulation,SimTime,R0,VF,Variable,Value) %>%
          arrange(Simulation,SimTime)

# display all the simulation traces
       
ggplot(td,aes(x=SimTime,y=Value,color=Simulation)) + 
  geom_path() + scale_colour_gradientn(colours=rainbow(10))+
  ylab("Infected") +
  xlab("Time (Days)")  + guides(color=FALSE) 

# Find the maximum of the infection curve for each simulation

i_td <- td %>% group_by(Simulation) %>%
                 summarise(InfMax=max(Value),R0=R0[1],VF=VF[1])

# Print this on a scatter plot

ggplot(data=i_td,mapping = aes(x=R0,y=VF,size=InfMax,colour=InfMax)) + 
  geom_point() + 
  scale_colour_gradientn(colours=rev(rainbow(5)))+guides(size=F)

# Calculate the average for the simulation runs

a_td <- td %>% group_by(SimTime) %>%
              summarise(Avr=mean(Value),
                        SD=sd(Value))

ggplot()+geom_path(data=td,mapping=aes(x=SimTime,y=Value,color=Simulation)) + 
  scale_colour_gradientn(colours=rainbow(10))+
  ylab("Infected") +
  xlab("Time (Days)")  + guides(color=FALSE)+
  geom_line(data=a_td,mapping=aes(x=SimTime,y=Avr),colour="black",size=2,linetype="dotted")





