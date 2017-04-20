library(gdata)
#sim <- read.xls("workshop/R code/01 session/SimData.xlsx",
#                stringsAsFactors=FALSE)

load("workshop/models/01 session/SimData.Rda")

sim<-pop

# Add the total population for year time as a column to the data frame
sim$Total<-apply(sim[,2:5],MARGIN = 1,sum)

# Subset the data frame so that only the actual yearly values are shown
# Time step is 1/8, so we only extract 1/8 of the data
sub<-sim[c( TRUE, rep(FALSE,7)),]
