# Examples based on:
# "ggplot2: Elegant Graphics for Data Analysis" by Hadley Wickham, 2nd Ed
#  Springer 2015.
# 
library(ggplot2)

# Every ggplot has three key components: (Wickham p13)
#  1) data
#  2) A set of aesthetic mappings between variables in the data and visual properties
#  3) A least one layer which describes how to render each observation
#


# mpg: A data frame with 234 rows and 11 variables
# manufacturer.
# model.
# displ. engine displacement, in litres
# year.
# cyl. number of cylinders
# trans. type of transmission
# drv. f = front-wheel drive, r = rear wheel drive, 4 = 4wd
# cty. city miles per gallon
# hwy. highway miles per gallon
# fl.
# class.

# simple plot
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point()


# differentiating wrt colour, size, shape
ggplot(mpg,aes(x=displ,y=hwy,colour=class)) + geom_point()
ggplot(mpg,aes(x=displ,y=hwy,size=cyl)) + geom_point()
ggplot(mpg,aes(x=displ,y=hwy,shape=drv)) + geom_point()

# Using the facet wrap 
ggplot(mpg,aes(x=displ,y=hwy))+geom_point()+facet_wrap(~class)
ggplot(mpg,aes(x=displ,y=hwy))+geom_point()+facet_wrap(~cyl)

# Adding a smoother
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point() +geom_smooth()
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point() +geom_smooth(span=0.2)

# Adding a linear model
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point() +geom_smooth(method="lm")


# boxplots
ggplot(mpg,aes(x=drv,y=hwy)) +geom_boxplot()

# histograms
ggplot(mpg,aes(hwy))+geom_histogram()
ggplot(mpg,aes(hwy))+geom_freqpoly()

# time series - economics
# A data frame with 478 rows and 6 variables
# date. Month of data collection
# psavert, personal savings rate
# pce, personal consumption expenditures, in billions of dollars
# unemploy, number of unemployed in thousands
# uempmed, median duration of unemployment, in week
# pop, total population, in thousands

ggplot(economics,aes(date,unemploy/pop))+geom_line()

ggplot(economics,aes(unemploy/pop,uempmed))+geom_path()+geom_point()


# Modifying the axes

ggplot(mpg,aes(cty,hwy))+geom_point(alpha=1/3)+
  xlab("city driving (mpg)")+
  ylab("Highway driving (mpg)")

