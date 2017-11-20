###########################################
# Translation of Vensim file.
# Date created: 2017-11-13 17:00:54
###########################################
library(deSolve)
library(ggplot2)
library(tidyr)
library(dplyr)
library(plyr)
library(tibble)

#Displaying the simulation run parameters
START_TIME <- 0.000000
FINISH_TIME <- 50.000000
TIME_STEP <- 0.125000
#Setting aux param to NULL


#Generating the simulation time vector
simtime<-seq(0.000000,50.000000,by=0.125000)
# Writing global variables (stocks and dependent auxs)
stocks <-c( Ia = 0 , Iy = 1 , Ra = 0 , Ry = 0 , Sa = 5000 , SmoothedReportingRate = 0 , Sy = 4999 )
# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    CEAA <- 0.2
    PopulationA <- Sa+Ia+Ra
    BetaAA <- CEAA/PopulationA
    CEAY <- 0.05
    BetaAY <- CEAY/PopulationA
    LambdaA <- BetaAA*Ia+BetaAY*Iy
    AIR <- LambdaA*Sa
    RD <- 2
    ARR <- Ia/RD
    AT <- 2
    CEYA <- 0.1
    PopulationY <- Sy+Iy+Ry
    BetaYA <- CEYA/PopulationY
    CEYY <- 0.8
    
    # TEST the simulation. Schools close (but do not reopen)
    if(TestCloseFlag == T){
      if (time > CloseTime) CEYY <- CEYY * DecreaseEffect
    }
    
    BetaYY <- CEYY/PopulationY
    CloseSchoolDuration <- 10
    TotalPopulation <- PopulationY+PopulationA
    ReportedCasesPer100000 <- SmoothedReportingRate*100000/TotalPopulation
    SchoolClosureThreshold <- 300
    #CloseSchoolsFlag <- IFTHENELSE(ReportedCasesPer100000>SchoolClosureThreshold,1,0)
    
    if(ReportedCasesPer100000 > SchoolClosureThreshold)
      CloseSchoolsFlag <- T else CloseSchoolsFlag <- F
    
    LambdaY <- BetaYA*Ia+BetaYY*Iy
    YIR <- LambdaY*Sy
    TotalInfectionRate <- AIR+YIR
    ReportingFraction <- 0.4
    ReportedInfectionRate <- TotalInfectionRate*ReportingFraction
    Error <- ReportedInfectionRate-SmoothedReportingRate
    CRR <- Error/AT
    TotalInfected <- Ia+Iy
    YRR <- Iy/RD
    d_DT_Ia  <- AIR-ARR
    d_DT_Iy  <- YIR-YRR
    d_DT_Ra  <- ARR
    d_DT_Ry  <- YRR
    d_DT_Sa  <- -AIR
    d_DT_SmoothedReportingRate  <- CRR
    d_DT_Sy  <- -YIR
    return (list(c(d_DT_Ia,d_DT_Iy,d_DT_Ra,d_DT_Ry,d_DT_Sa,d_DT_SmoothedReportingRate,d_DT_Sy)))
  })
}
# Function call to run simulation


run_info <- data.frame(
  RunID          = 1:5,
  TestCloseFlag  = c(F,rep(T,4)),
  CloseTime      = c(0,seq(10,40,by=10)),
  DecreaseEffect = 0.44
)

ans <- apply(run_info,1,function(x){
  auxs<-c(TestCloseFlag=x[["TestCloseFlag"]],
          CloseTime=x[["CloseTime"]],
          DecreaseEffect=x[["DecreaseEffect"]])
  o<-data.frame(ode(y=stocks,
                    times=simtime,
                    func=model,
                    parms=auxs,
                    method='euler'))
  o$TotalInfected <- o$Ia+o$Iy
  o$RunID <- x[["RunID"]]
  o$CloseTime <-  as.factor(x[["CloseTime"]])
  o
})

ans_df <- select(as_data_frame(rbind.fill(ans)),TotalInfected,everything())

ggplot(ans_df,aes(x=time,y=TotalInfected,color=CloseTime)) + 
  geom_path() +
  ylab("Infected") +
  xlab("Time (Days)") 

#----------------------------------------------------
# Original text file exported from Vensim
#  Ia = INTEG( AIR - ARR , 0) 
#  Iy = INTEG( YIR - YRR , 1) 
#  Ra = INTEG( ARR , 0) 
#  Ry = INTEG( YRR , 0) 
#  Sa = INTEG( - AIR , 5000) 
#  Smoothed Reporting Rate = INTEG( CRR , 0) 
#  Sy = INTEG( - YIR , 4999) 
#  CE AA = 0.2
#  Population A = Sa + Ia + Ra 
#  Beta AA = CE AA / Population A 
#  CE AY = 0.05
#  Beta AY = CE AY / Population A 
#  Lambda A = Beta AA * Ia + Beta AY * Iy 
#  AIR = Lambda A * Sa 
#  RD = 2
#  ARR = Ia / RD 
#  AT = 2
#  CE YA = 0.1
#  Population Y = Sy + Iy + Ry 
#  Beta YA = CE YA / Population Y 
#  CE YY = 0.8
#  Beta YY = CE YY / Population Y 
#  Close School Duration = 10
#  Total Population = Population Y + Population A 
#  Reported Cases Per 100000 = Smoothed Reporting Rate * 100000 / Total Population
#  School Closure Threshold = 300
#  Close Schools Flag = IF THEN ELSE ( Reported Cases Per 100000 > School Closure Threshold, 1, 0) 
#  Lambda Y = Beta YA * Ia + Beta YY * Iy 
#  YIR = Lambda Y * Sy 
#  Total Infection Rate = AIR + YIR 
#  Reporting Fraction = 0.4
#  Reported Infection Rate = Total Infection Rate * Reporting Fraction 
#  Error = Reported Infection Rate - Smoothed Reporting Rate 
#  CRR = Error / AT 
#  FINAL TIME = 50
#  INITIAL TIME = 0
#  TIME STEP = 0.125
#  SAVEPER = TIME STEP 
#  Total Infected = Ia + Iy 
#  YRR = Iy / RD 
#----------------------------------------------------
