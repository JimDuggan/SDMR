# read in R data set for cars as a data frame
ds<-data.frame(mpg)

ds$status<-ifelse(ds$year<2005,"OLD","NEW")



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
# have saved the excel file as a binary
#library(gdata)
#pop <- read.xls("workshop/models/01 session/SimData.xlsx",
#                stringsAsFactors=FALSE)
#save(pop,file="workshop/models/01 session/SimData.Rda")

load("workshop/models/01 session/SimData.Rda")





