# Examples based on Chapter 2 of :
# "ggplot2: Elegant Graphics for Data Analysis" by Hadley Wickham, 2nd Ed
#  Springer 2015.
# 
library(ggplot2)

df<-data.frame(
  x=c(3,1,5),
  y=c(2,4,6),
  label=c("a","b","c")
)

# this sets up the "foundation of the plot"
p<- ggplot(df,aes(x,y,label=label))+
    labs(x=NULL,y=NULL)+  # Hide axis label
    theme(plot.title=element_text(size=10)) # shrink plot title

# display using points
p+geom_point()+ggtitle("Title here.... point")

# display text (labels)
p+geom_text()+ggtitle("Title here.... text")

# display as bar chart
p+geom_bar(stat="identity")+ggtitle("...bar")

# display as tile
p+geom_tile()+ggtitle("...raster")

# display as line
p+geom_line()+ggtitle("Line")

# display as area
p+geom_area()+ggtitle("Area")

# display as path
p+geom_path()+ggtitle("Path")

# display as polygon
p+geom_polygon()+ggtitle("Polygon")

# nice economics example
ggplot(economics,aes(date,unemploy)) + geom_line()

# annotations...
presidential <- subset(presidential,start > economics$date[1])

ggplot(data=economics) +
  geom_rect(
    aes(xmin=start,xmax=end,fill=party),
    ymin=-Inf, ymax=Inf, alpha=0.2,
    data=presidential
  )+
  geom_vline(
    aes(xintercept=as.numeric(start)),
    data=presidential,
    colour="grey50",alpha=0.5
  )+
  geom_text(
    aes(x=start,y=2500,label=name),
    data=presidential,
    size=3,vjust=0,hjust=0,nudge_x = 50
  )+
  geom_line(aes(date,unemploy))+
  scale_fill_manual(values=c("blue","red"))

# surface plots

ggplot(faithfuld,aes(eruptions,waiting))+
  geom_contour(aes(z=density, colour = ..level..))

ggplot(faithfuld,aes(eruptions,waiting))+
  geom_raster(aes(fill=density))

# maps
library(dplyr)
library('magrittr')

mi_counties <- map_data("county","michigan") %>% 
                  select(lon=long, lat, group,id=subregion)

# visualise the vector boundary

ggplot(mi_counties, aes(lon,lat))+
  geom_polygon(aes(group=group))+
  coord_quickmap()

# revealing uncertainty: 4 basic geoms
#   discrete x, continuous x

y<-c(18,11,16)
df<-data.frame(x=1:3,y=y,se=c(1.2,0.5,1.0))

base<- ggplot(df, aes(x,y,ymin=y-se,ymax=y+se))

base+geom_crossbar()
base+geom_errorbar()
base+geom_pointrange()
base+geom_smooth(stat="identity")
base+geom_linerange()
base+geom_ribbon()

                 

