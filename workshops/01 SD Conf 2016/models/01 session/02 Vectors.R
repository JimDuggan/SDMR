# create a vector
v1<- c(1,2,4,16,25)

# R statistical functions...
max(v1)
mean(v1)
median(v1)

# Vectorisation
v2<-v1+10

# Accessing a vector
v1[1]
v1[1:3]
v1[-(1:4)]

# Conditional expressions on a vector
b<-v1 %% 2 == 0
v1[b]

# Finding the location of a value
which(v1 == min(v1))




