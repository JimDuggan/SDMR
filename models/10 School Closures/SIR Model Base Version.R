###########################################
# Translation of Vensim file.
# Date created: 2017-10-26 08:22:18
###########################################
library(deSolve)
library(ggplot2)
library(tidyr)
library(dplyr)


#Displaying the simulation run parameters
START_TIME <- 0.000000
FINISH_TIME <- 70.000000
TIME_STEP <- 0.125000
#Setting aux param to NULL
auxs<-c(SchoolClosureDuration=5)

#Generating the simulation time vector
simtime<-seq(0.000000,70.000000,by=0.125000)
# Writing global variables (stocks and dependent auxs)
stocks <-c( Ia = 0 , Iy = 1 , Ra = 0 , Ry = 0 , Sa = 5000 , SmoothedReportingRate = 0 , Sy = 4999 )
# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    PopulationA <- Sa+Ia+Ra
    PopulationY <- Sy+Iy+Ry
    
    CEAA <- 0.55
    CEAY <- CEAA/4


    BetaAA <- CEAA/PopulationA

    BetaAY  <- CEAY/PopulationA
    LambdaA <- BetaAA*Ia+BetaAY*Iy
    AIR     <- LambdaA*Sa
    RD      <- 2
    ARR     <- Ia/RD
    AT <- 2
    
    CloseSchoolDuration    <- 10
    TotalPopulation        <- PopulationY+PopulationA
    ReportedCasesPer100000 <- SmoothedReportingRate*100000/TotalPopulation
    
    
    #-----------------------------------------------------------------------------------
    # School Closure Logic Needs to Go Here.
    # School closures will close when the threshold is exceeded 
    # Closures will reduce CEYY by 40%
    # CloseSchoolsFlag <- IFTHENELSE(ReportedCasesPer100000>SchoolClosureThreshold,1,0)
    
    SchoolClosureThreshold <- 300
    CEYY <- 0.6
    
    #-----------------------------------------------------------------------------------
    
    CEYA <- CEYY/4
    
    BetaYA <- CEYA/PopulationY
    BetaYY <- CEYY/PopulationY
    
    LambdaY <- BetaYA*Ia+BetaYY*Iy
    
    YIR <- LambdaY*Sy
    TotalInfectionRate <- AIR+YIR
    ReportingFraction <- 0.4
    ReportedInfectionRate <- TotalInfectionRate*ReportingFraction
    Error <- ReportedInfectionRate-SmoothedReportingRate
    CRR <- Error/AT
    TotalInfected <- Ia+Iy
    YRR <- Iy/RD
    
    # Solve for all the integrals
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
o<-as_tibble(
  data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))
)

to <- o %>% 
        select(time:Iy) %>% 
        gather(key=Stock,value=Number,Ia:Iy)

ggplot(to,aes(x=time,y=Number,fill=Stock)) + geom_area()


#----------------------------------------------------
# Original text file exported from Vensim
#  Ia = INTEG( AIR - ARR , 0) 
#  Iy = INTEG( YIR - YRR , 1) 
#  Ra = INTEG( ARR , 0) 
#  Ry = INTEG( YRR , 0) 
#  Sa = INTEG( - AIR , 5000) 
#  Smoothed Reporting Rate = INTEG( CRR , 0) 
#  Sy = INTEG( - YIR , 4999) 
#  CE AA = 0.55
#  Population A = Sa + Ia + Ra 
#  Beta AA = CE AA / Population A 
#  CE AY = CE AA / 4
#  Beta AY = CE AY / Population A 
#  Lambda A = Beta AA * Ia + Beta AY * Iy 
#  AIR = Lambda A * Sa 
#  RD = 2
#  ARR = Ia / RD 
#  AT = 2
#  CE YY = 0.6
#  CE YA = CE YY / 4
#  Population Y = Sy + Iy + Ry 
#  Beta YA = CE YA / Population Y 
#  Beta YY = CE YY / Population Y 
#  Close School Duration = 10
#  Total Population = Population Y + Population A 
#  Reported Cases Per 100000 = Smoothed Reporting Rate * 100000 / Total Population
#             
#  School Closure Threshold = 300
#  Close Schools Flag = IF THEN ELSE ( Reported Cases Per 100000 > School Closure Threshold, 1, 0) 
#  Lambda Y = Beta YA * Ia + Beta YY * Iy 
#  YIR = Lambda Y * Sy 
#  Total Infection Rate = AIR + YIR 
#  Reporting Fraction = 0.4
#  Reported Infection Rate = Total Infection Rate * Reporting Fraction 
#  Error = Reported Infection Rate - Smoothed Reporting Rate 
#  CRR = Error / AT 
#  Total Infected = Ia + Iy 
#  YRR = Iy / RD 
#  FINAL TIME = 70
#  INITIAL TIME = 0
#  TIME STEP = 0.125
#----------------------------------------------------
