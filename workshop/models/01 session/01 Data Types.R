# 1. exploring vector types

v1<-c(T,FALSE)
v2<-c(10L,20L)
v3<-c(3.5,12.2)
v4<-c("system","dynamics")


typeof(v1)
typeof(v2)
typeof(v3)
typeof(v4)

# checking how coercions work
v5<-c(v1,v2)
v5
typeof(v5)


