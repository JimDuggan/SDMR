# define three vectors
time<-seq(1,7) 
v1<-rep(10,length(time))
sm<-cumsum(v1)

# group into a data frame
df<-data.frame(Time=time,Var1=v1,SumVar=sm)


# filter by rows
df[1,]
df[1:4,]
df[,1]
df[,2:3]

# filter using conditional statements

b<-df$SumVar<mean(df$SumVar)
b
df[b,]

df[df$SumVar<mean(df$SumVar),]

df$Category<-ifelse(df$SumVar<mean(df$SumVar),"Lower","Higher")

s<-subset(df,df$SumVar>mean(df$SumVar))

# Reading from Excel files
library(gdata)
sim <- read.xls("workshop/models/01 session/SimData.xlsx",
                stringsAsFactors=FALSE)


