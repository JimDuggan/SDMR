###########################################
# Translation of Vensim file.
# Date created: 2017-10-27 13:17:14
###########################################
library(deSolve)
library(ggplot2)
library(reshape2)
#Displaying the simulation run parameters
START_TIME <- 0.000000
FINISH_TIME <- 20.000000
TIME_STEP <- 0.031250
#Setting aux param to NULL
auxs<-NULL

#Generating the simulation time vector
simtime<-seq(0.000000,20.000000,by=0.031250)
# Writing global variables (stocks and dependent auxs)
stocks <-c( NumberofVaccines = 30000 , PeopleNotVaccinated = 100000 , PeopleVaccinated = 0 )
# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    AverageDispensingProductivity <- 200
    NumberofHealthWorkers <- 10
    VaccineAdministrationCapacity <- AverageDispensingProductivity*NumberofHealthWorkers
    TotalAvailableVaccineCapacity <- min(VaccineAdministrationCapacity,NumberofVaccines)
    Vaccinations <- min(PeopleNotVaccinated,TotalAvailableVaccineCapacity)
    VaccinesAdministered <- Vaccinations
    d_DT_NumberofVaccines  <- -VaccinesAdministered
    d_DT_PeopleNotVaccinated  <- -Vaccinations
    d_DT_PeopleVaccinated  <- Vaccinations
    return (list(c(d_DT_NumberofVaccines,d_DT_PeopleNotVaccinated,d_DT_PeopleVaccinated)))
  })
}
# Function call to run simulation
o<-data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))
mo<-melt(o,id.vars = 'time')
names(mo)<-c('Time','Stock','Value')
ggplot(data=mo)+geom_line(aes(x=Time,y=Value,colour=Stock))
#----------------------------------------------------
# Original text file exported from Vensim
#  Number of Vaccines = INTEG( - Vaccines Administered , 30000) 
#  People Not Vaccinated = INTEG( - Vaccinations , 100000) 
#  People Vaccinated = INTEG( Vaccinations , 0) 
#  Average Dispensing Productivity = 200
#  FINAL TIME = 20
#  INITIAL TIME = 0
#  Number of Health Workers = 10
#  TIME STEP = 0.03125
#  SAVEPER = TIME STEP 
#  Vaccine Administration Capacity = Average Dispensing Productivity * Number of Health Workers
#  Total Available Vaccine Capacity = min ( Vaccine Administration Capacity , Number of Vaccines ) 
#  Vaccinations = min ( People Not Vaccinated , Total Available Vaccine Capacity) 
#  Vaccines Administered = Vaccinations 
#----------------------------------------------------
