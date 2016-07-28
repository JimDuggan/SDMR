# Introduction to R - Sample code for manipulating vectors


# Setup the data values
c<-c("CT216","CT561","CT101","CT102")
n<-c(65,59,89,71)

# Query 1 - search for a target
target<-"CT101"
index<-which(c==target)
sprintf("Class %s has %d students",target,n[index])

# Query 2 - Find the class with the minimum number of students
min<-min(n)
index<-which(n==min)
sprintf("Class %s has the minimum number of students = %d",index,min)


# Query 3 - Find the class with the maximum number of students
max<-max(n)
index<-which(n==max)
sprintf("Class %s has the maximum number of students = %d",index,max)

# Query 4 - Display all classes greater that 70 students
b<-n>70
c[b]

# Query 5 - Display all classes greater that 60 and less than 80 students
b<-n>60 & n < 80
c[b]

# Query 6 - Display summary
summary(n)

