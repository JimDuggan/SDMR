library(ggplot2)


dt <- ggplot2::mpg

test <- select(dt,Manufacturer=manufacturer,Model=model,Capacity=displ,MilesPerGallon=hwy)

ggplot(data = dt) +
  geom_point(mapping = aes(x=displ,y=hwy))

ggplot(data = dt) +
  geom_point(mapping = aes(x=displ,y=hwy,colour=class))

ggplot(data = dt) +
  geom_point(mapping = aes(x=displ,y=hwy)) + facet_wrap(~class)

ggplot(data = dt) +
  geom_point(mapping = aes(x=displ,y=hwy,colour=class)) +
  facet_wrap(~manufacturer)


x <- 10

y <- 1:10

room_temperature <- 20





us <- map_data("state")

ggplot(us,aes(long,lat,group=group))+
  geom_polygon(fill="blue",colour="white")



