###########################################
# Translation of Vensim file.
# Date created: 2018-03-04 20:19:13
###########################################
library(deSolve)
library(ggplot2)
library(tidyr)
#Displaying the simulation run parameters
START_TIME <- 0.000000
FINISH_TIME <- 20.000000
TIME_STEP <- 0.125000
#Setting aux param to NULL
auxs<-NULL

#Generating the simulation time vector
simtime<-seq(0.000000,20.000000,by=0.125000)
# Writing global variables (stocks and dependent auxs)
stocks <-c( A = 2000 , A0to4 = 0 , A15to64 = 0 , A5to14 = 0 , A65 = 0 , Deaths0to4 = 0 , Deaths15to64 = 0 , Deaths5to14 = 0 , Deaths65 = 0 , E0to4 = 0 , E15to64 = 0 , E5to14 = 0 , E65 = 0 , IMil0to4 = 1 , IMil15to64 = 1 , IMil5to14 = 1 , IMil65 = 1 , IMod0to4 = 0 , IMod15to64 = 0 , IMod5to14 = 0 , IMod65 = 0 , ISev0to4 = 0 , ISev15to64 = 0 , ISev5to14 = 0 , ISev65 = 0 , R0to4 = 0 , R15to64 = 0 , R5to14 = 0 , R65 = 0 , S0to4 = 9999 , S15to64 = 9999 , S5to14 = 9999 , S65 = 9999 , V = 2000 , V0to4 = 0 , V15to64 = 0 , V5to14 = 0 , V65 = 0 )
# This is the model function called from ode
model <- function(time, stocks, auxs){
  with(as.list(c(stocks, auxs)),{
    ADelay0to4 <- 2
    ADelay15to64 <- 2
    ADelay5to14 <- 2
    ADelay65 <- 2
    AEff0to4 <- 0.9
    AEff15to64 <- 0.9
    AEff5to14 <- 0.9
    AEff65 <- 0.9
    AGiven0to4 <- min((A/ADelay0to4)*AEff0to4,ISev0to4)
    AGiven15to64 <- min((A/ADelay15to64)*AEff15to64,ISev15to64)
    AGiven5to14 <- min((A/ADelay5to14)*AEff5to14,ISev5to14)
    AGiven65 <- min((A/ADelay65)*AEff65,ISev65)
    AProduced <- 2
    ARatio0to4 <- 0.2
    AProp0to4 <- A*ARatio0to4
    ARatio15to64 <- 0.2
    AProp15to64 <- A*ARatio15to64
    ARatio5to14 <- 0.2
    AProp5to14 <- A*ARatio5to14
    ARatio65 <- 0.2
    AProp65 <- A*ARatio65
    AUsed0to4 <- AGiven0to4
    AUsed15to64 <- AGiven15to64
    AUsed5to14 <- AGiven5to14
    AUsed65 <- AGiven65
    CE0to40to4 <- 2
    Pop0to4 <- IMil0to4+IMod0to4+ISev0to4+E0to4+S0to4+R0to4
    Beta0to40to4 <- CE0to40to4/Pop0to4
    CE0to415to64 <- 2
    Beta0to415to64 <- CE0to415to64/Pop0to4
    CE0to45to14 <- 2
    Beta0to45to14 <- CE0to45to14/Pop0to4
    CE0to465 <- 2
    Beta0to465 <- CE0to465/Pop0to4
    CE15to640to4 <- 2
    Pop15to64 <- IMil15to64+IMod15to64+ISev15to64+E15to64+S15to64+R15to64
    Beta15to640to4 <- CE15to640to4/Pop15to64
    CE15to6415to64 <- 2
    Beta15to6415to64 <- CE15to6415to64/Pop15to64
    CE15to645to14 <- 2
    Beta15to645to14 <- CE15to645to14/Pop15to64
    CE15to6465 <- 2
    Beta15to6465 <- CE15to6465/Pop15to64
    CE5to140to4 <- 2
    Pop5to14 <- E5to14+IMil5to14+IMod5to14+ISev5to14+R5to14+S5to14
    Beta5to140to4 <- CE5to140to4/Pop5to14
    CE5to1415to64 <- 2
    Beta5to1415to64 <- CE5to1415to64/Pop5to14
    CE5to145to14 <- 2
    Beta5to145to14 <- CE5to145to14/Pop5to14
    CE5to1465 <- 2
    Beta5to1465 <- CE5to1465/Pop5to14
    CE650to4 <- 2
    Pop65 <- E65+IMil65+IMod65+ISev65+R65+S65
    Beta650to4 <- CE650to4/Pop65
    CE6515to64 <- 2
    Beta6515to64 <- CE6515to64/Pop65
    CE655to14 <- 2
    Beta655to14 <- CE655to14/Pop65
    CE6565 <- 2
    Beta6565 <- CE6565/Pop65
    CohortTot0to4 <- IMil0to4+IMod0to4+ISev0to4+E0to4+S0to4+R0to4+Deaths0to4
    CohortTot15to64 <- IMil15to64+IMod15to64+ISev15to64+E15to64+S15to64+R15to64+Deaths15to64
    CohortTot5to14 <- E5to14+IMil5to14+IMod5to14+ISev5to14+R5to14+S5to14+Deaths5to14
    CohortTot65 <- E65+IMil65+IMod65+ISev65+R65+S65+Deaths65
    DelayMil15to64 <- 2
    DelayMil5to14 <- 2
    DelayMil65 <- 2
    DelayMild0to4 <- 2
    DelayMod0to4 <- 2
    DelayMod15to64 <- 2
    DelayMod5to14 <- 2
    DelayMod65 <- 2
    DelaySev0to4 <- 2
    DelaySev15to64 <- 2
    DelaySev5to14 <- 2
    DelaySev65 <- 2
    DP0to4 <- 0.001
    DP15to64 <- 0.001
    DP5to14 <- 0.001
    DP65 <- 0.001
    DR0to4 <- ISev0to4*DP0to4
    DR15to64 <- ISev15to64*DP15to64
    DR5to14 <- ISev5to14*DP5to14
    DR65 <- ISev65*DP65
    LPMil15to64 <- 2
    ERMil15to64 <- E15to64/LPMil15to64
    LPMil5to14 <- 2
    ERMil5to14 <- E5to14/LPMil5to14
    LPMil65 <- 2
    ERMil65 <- E65/LPMil65
    LPMil0to4 <- 2
    ERMild0to4 <- E0to4/LPMil0to4
    LPMod0to4 <- 2
    ERMod0to4 <- E0to4/LPMod0to4
    LPMod15to64 <- 2
    ERMod15to64 <- E15to64/LPMod15to64
    LPMod5to14 <- 2
    ERMod5to14 <- E5to14/LPMod5to14
    LPMod65 <- 2
    ERMod65 <- E65/LPMod65
    LPSev0to4 <- 2
    ERSev0to4 <- E0to4/LPSev0to4
    LPSev15to64 <- 2
    ERSev15to64 <- E15to64/LPSev15to64
    LPSev5to14 <- 2
    ERSev5to14 <- E5to14/LPSev5to14
    LPSev65 <- 2
    ERSev65 <- E65/LPSev65
    TotI0to4 <- IMil0to4+IMod0to4+ISev0to4
    TotI5to14 <- IMil5to14+IMod5to14+ISev5to14
    TotI15to64 <- IMil15to64+IMod15to64+ISev15to64
    TotI65 <- IMil65+IMod65+ISev65
    Lambda0to4 <- Beta0to40to4*TotI0to4+Beta0to45to14*TotI5to14+Beta0to415to64*TotI15to64+Beta0to465*TotI65
    IR0to4 <- Lambda0to4*S0to4
    Lambda15to64 <- Beta15to640to4*TotI0to4+Beta15to645to14*TotI5to14+Beta15to6415to64*TotI15to64+Beta15to6465*TotI65
    IR15to64 <- Lambda15to64*S15to64
    Lambda5to14 <- Beta5to140to4*TotI0to4+Beta5to145to14*TotI5to1+Beta5to1415to64*TotI15to64+Beta5to1465*TotI65
    IR5to14 <- Lambda5to14*S5to14
    Lambda65 <- Beta650to4*TotI0to4+Beta655to14*TotI5to14+Beta6515to64*TotI15to64+Beta6565*TotI65
    IR65 <- Lambda65*S65
    RRMil15to64 <- IMil15to64/DelayMil15to64
    RRMil5to14 <- IMil5to14/DelayMil5to14
    RRMil65 <- IMil65/DelayMil65
    RRMild0to4 <- IMil0to4/DelayMild0to4
    RRMod0to4 <- IMod0to4/DelayMod0to4
    RRMod15to64 <- IMod15to64/DelayMod15to64
    RRMod5to14 <- IMod5to14/DelayMod5to14
    RRMod65 <- IMod65/DelayMod65
    RRSev0to4 <- ISev0to4/DelaySev0to4
    RRSev15to64 <- ISev15to64/DelaySev15to64
    RRSev5to14 <- ISev5to14/DelaySev5to14
    RRSev65 <- ISev65/DelaySev65
    TotalI <- TotI0to4+TotI15to64+TotI5to14+TotI65
    VDelay0to4 <- 2
    VDelay15to64 <- 2
    VDelay5to14 <- 2
    VDelay65 <- 2
    VEff0to4 <- 0.7
    VEff15to64 <- 0.7
    VEff5to14 <- 0.7
    VEff65 <- 0.7
    VGiven0to4 <- min(S0to4,(V0to4/VDelay0to4)*VEff0to4)
    VGiven15to64 <- min(S15to64,(V15to64/VDelay15to64)*VEff15to64)
    VGiven5to14 <- min(S5to14,(V5to14/VDelay5to14)*VEff5to14)
    VGiven65 <- min(S65,(V65/VDelay65)*VEff65)
    VProduced <- 2
    VRatio0to4 <- 0.2
    VProp0to4 <- V*VRatio0to4
    VRatio15to64 <- 0.2
    VProp15to64 <- V*VRatio15to64
    VRatio5to14 <- 0.2
    VProp5to14 <- V*VRatio5to14
    VRatio65 <- 0.2
    VProp65 <- V*VRatio65
    VUsed0to4 <- VGiven0to4
    VUsed15to64 <- VGiven15to64
    VUsed5to14 <- VGiven5to14
    VUsed65 <- VGiven65
    d_DT_A  <- AProduced-AProp0to4-AProp15to64-AProp5to14-AProp65
    d_DT_A0to4  <- AProp0to4-AUsed0to4
    d_DT_A15to64  <- AProp15to64-AUsed15to64
    d_DT_A5to14  <- AProp5to14-AUsed5to14
    d_DT_A65  <- AProp65-AUsed65
    d_DT_Deaths0to4  <- DR0to4
    d_DT_Deaths15to64  <- DR15to64
    d_DT_Deaths5to14  <- DR5to14
    d_DT_Deaths65  <- DR65
    d_DT_E0to4  <- IR0to4-ERMod0to4-ERMild0to4-ERSev0to4
    d_DT_E15to64  <- IR15to64-ERMod15to64-ERMil15to64-ERSev15to64
    d_DT_E5to14  <- IR5to14-ERMod5to14-ERMil5to14-ERSev5to14
    d_DT_E65  <- IR65-ERMod65-ERMil65-ERSev65
    d_DT_IMil0to4  <- ERMild0to4-RRMild0to4
    d_DT_IMil15to64  <- ERMil15to64-RRMil15to64
    d_DT_IMil5to14  <- ERMil5to14-RRMil5to14
    d_DT_IMil65  <- ERMil65-RRMil65
    d_DT_IMod0to4  <- AGiven0to4+ERMod0to4-RRMod0to4
    d_DT_IMod15to64  <- AGiven15to64+ERMod15to64-RRMod15to64
    d_DT_IMod5to14  <- AGiven5to14+ERMod5to14-RRMod5to14
    d_DT_IMod65  <- AGiven65+ERMod65-RRMod65
    d_DT_ISev0to4  <- ERSev0to4-AGiven0to4-DR0to4-RRSev0to4
    d_DT_ISev15to64  <- ERSev15to64-AGiven15to64-DR15to64-RRSev15to64
    d_DT_ISev5to14  <- ERSev5to14-AGiven5to14-DR5to14-RRSev5to14
    d_DT_ISev65  <- ERSev65-AGiven65-DR65-RRSev65
    d_DT_R0to4  <- RRMild0to4+RRMod0to4+RRSev0to4+VGiven0to4
    d_DT_R15to64  <- RRMil15to64+RRMod15to64+RRSev15to64+VGiven15to64
    d_DT_R5to14  <- RRMil5to14+RRMod5to14+RRSev5to14+VGiven5to14
    d_DT_R65  <- RRMil65+RRMod65+RRSev65+VGiven65
    d_DT_S0to4  <- -VGiven0to4-IR0to4
    d_DT_S15to64  <- -VGiven15to64-IR15to64
    d_DT_S5to14  <- -VGiven5to14-IR5to14
    d_DT_S65  <- -VGiven65-IR65
    d_DT_V  <- VProduced-VProp0to4-VProp5to14-VProp15to64-VProp65
    d_DT_V0to4  <- VProp0to4-VUsed0to4
    d_DT_V15to64  <- VProp15to64-VUsed15to64
    d_DT_V5to14  <- VProp5to14-VUsed5to14
    d_DT_V65  <- VProp65-VUsed65
    return (list(c(d_DT_A,d_DT_A0to4,d_DT_A15to64,d_DT_A5to14,d_DT_A65,d_DT_Deaths0to4,d_DT_Deaths15to64,d_DT_Deaths5to14,d_DT_Deaths65,d_DT_E0to4,d_DT_E15to64,d_DT_E5to14,d_DT_E65,d_DT_IMil0to4,d_DT_IMil15to64,d_DT_IMil5to14,d_DT_IMil65,d_DT_IMod0to4,d_DT_IMod15to64,d_DT_IMod5to14,d_DT_IMod65,d_DT_ISev0to4,d_DT_ISev15to64,d_DT_ISev5to14,d_DT_ISev65,d_DT_R0to4,d_DT_R15to64,d_DT_R5to14,d_DT_R65,d_DT_S0to4,d_DT_S15to64,d_DT_S5to14,d_DT_S65,d_DT_V,d_DT_V0to4,d_DT_V15to64,d_DT_V5to14,d_DT_V65)))
  })
}
# Function call to run simulation
o<-data.frame(ode(y=stocks,times=simtime,func=model,parms=auxs,method='euler'))
to<-gather(o,key=Stock,value=Value,2:ncol(o))
ggplot(data=to)+geom_line(aes(x=time,y=Value,colour=Stock))
#----------------------------------------------------
# Original text file exported from Vensim
#  A = INTEG( A Produced - A Prop 0to4 - A Prop 15to64 - A Prop 5to14 - A Prop 65, 2000) 
#  A 0to4 = INTEG( A Prop 0to4 - A Used 0to4 , 0) 
#  A 15to64 = INTEG( A Prop 15to64 - A Used 15to64 , 0) 
#  A 5to14 = INTEG( A Prop 5to14 - A Used 5to14 , 0) 
#  A 65 = INTEG( A Prop 65 - A Used 65 , 0) 
#  Deaths 0to4 = INTEG( DR 0to4 , 0) 
#  Deaths 15to64 = INTEG( DR 15to64 , 0) 
#  Deaths 5to14 = INTEG( DR 5to14 , 0) 
#  Deaths 65 = INTEG( DR 65 , 0) 
#  E 0to4 = INTEG( IR 0to4 - ER Mod 0to4 - ER Mild 0to4 - ER Sev 0to4 , 0) 
#  E 15to64 = INTEG( IR 15to64 - ER Mod 15to64 - ER Mil 15to64 - ER Sev 15to64, 0) 
#  E 5to14 = INTEG( IR 5to14 - ER Mod 5to14 - ER Mil 5to14 - ER Sev 5to14 , 0) 
#  E 65 = INTEG( IR 65 - ER Mod 65 - ER Mil 65 - ER Sev 65 , 0) 
#  I Mil 0to4 = INTEG( ER Mild 0to4 - RR Mild 0to4 , 1) 
#  I Mil 15to64 = INTEG( ER Mil 15to64 - RR Mil 15to64 , 1) 
#  I Mil 5to14 = INTEG( ER Mil 5to14 - RR Mil 5to14 , 1) 
#  I Mil 65 = INTEG( ER Mil 65 - RR Mil 65 , 1) 
#  I Mod 0to4 = INTEG( A Given 0to4 + ER Mod 0to4 - RR Mod 0to4 , 0) 
#  I Mod 15to64 = INTEG( A Given 15to64 + ER Mod 15to64 - RR Mod 15to64 , 0) 
#  I Mod 5to14 = INTEG( A Given 5to14 + ER Mod 5to14 - RR Mod 5to14 , 0) 
#  I Mod 65 = INTEG( A Given 65 + ER Mod 65 - RR Mod 65 , 0) 
#  I Sev 0to4 = INTEG( ER Sev 0to4 - A Given 0to4 - DR 0to4 - RR Sev 0to4 , 0) 
#  I Sev 15to64 = INTEG( ER Sev 15to64 - A Given 15to64 - DR 15to64 - RR Sev 15to64, 0) 
#  I Sev 5to14 = INTEG( ER Sev 5to14 - A Given 5to14 - DR 5to14 - RR Sev 5to14, 0) 
#  I Sev 65 = INTEG( ER Sev 65 - A Given 65 - DR 65 - RR Sev 65 , 0) 
#  R 0to4 = INTEG( RR Mild 0to4 + RR Mod 0to4 + RR Sev 0to4 + V Given 0to4 , 0) 
#  R 15to64 = INTEG( RR Mil 15to64 + RR Mod 15to64 + RR Sev 15to64 + V Given 15to64, 0) 
#  R 5to14 = INTEG( RR Mil 5to14 + RR Mod 5to14 + RR Sev 5to14 + V Given 5to14, 0) 
#  R 65 = INTEG( RR Mil 65 + RR Mod 65 + RR Sev 65 + V Given 65 , 0) 
#  S 0to4 = INTEG( - V Given 0to4 - IR 0to4 , 9999) 
#  S 15to64 = INTEG( - V Given 15to64 - IR 15to64 , 9999) 
#  S 5to14 = INTEG( - V Given 5to14 - IR 5to14 , 9999) 
#  S 65 = INTEG( - V Given 65 - IR 65 , 9999) 
#  V = INTEG( V Produced - V Prop 0to4 - V Prop 5to14 - V Prop 15to64 - V Prop 65, 2000) 
#  V 0to4 = INTEG( V Prop 0to4 - V Used 0to4 , 0) 
#  V 15to64 = INTEG( V Prop 15to64 - V Used 15to64 , 0) 
#  V 5to14 = INTEG( V Prop 5to14 - V Used 5to14 , 0) 
#  V 65 = INTEG( V Prop 65 - V Used 65 , 0) 
#  A Delay 0to4 = 2
#  A Delay 15to64 = 2
#  A Delay 5to14 = 2
#  A Delay 65 = 2
#  A Eff 0to4 = 0.9
#  A Eff 15to64 = 0.9
#  A Eff 5to14 = 0.9
#  A Eff 65 = 0.9
#  A Given 0to4 = min ( ( A / A Delay 0to4 ) * A Eff 0to4 , I Sev 0to4 ) 
#  A Given 15to64 = min ( ( A / A Delay 15to64 ) * A Eff 15to64 , I Sev 15to64) 
#  A Given 5to14 = min ( ( A / A Delay 5to14 ) * A Eff 5to14 , I Sev 5to14 ) 
#  A Given 65 = min ( ( A / A Delay 65 ) * A Eff 65 , I Sev 65 ) 
#  A Produced = 2
#  A Ratio 0to4 = 0.2
#  A Prop 0to4 = A * A Ratio 0to4 
#  A Ratio 15to64 = 0.2
#  A Prop 15to64 = A * A Ratio 15to64 
#  A Ratio 5to14 = 0.2
#  A Prop 5to14 = A * A Ratio 5to14 
#  A Ratio 65 = 0.2
#  A Prop 65 = A * A Ratio 65 
#  A Used 0to4 = A Given 0to4 
#  A Used 15to64 = A Given 15to64 
#  A Used 5to14 = A Given 5to14 
#  A Used 65 = A Given 65 
#  CE 0to4 0to4 = 2
#  Pop 0to4 = I Mil 0to4 + I Mod 0to4 + I Sev 0to4 + E 0to4 + S 0to4 + R 0to4 
#  Beta 0to4 0to4 = CE 0to4 0to4 / Pop 0to4 
#  CE 0to4 15to64 = 2
#  Beta 0to4 15to64 = CE 0to4 15to64 / Pop 0to4 
#  CE 0to4 5to14 = 2
#  Beta 0to4 5to14 = CE 0to4 5to14 / Pop 0to4 
#  CE 0to4 65 = 2
#  Beta 0to4 65 = CE 0to4 65 / Pop 0to4 
#  CE 15to64 0to4 = 2
#  Pop 15to64 = I Mil 15to64 + I Mod 15to64 + I Sev 15to64 + E 15to64 + S 15to64+ R 15to64 
#  Beta 15to64 0to4 = CE 15to64 0to4 / Pop 15to64 
#  CE 15to64 15to64 = 2
#  Beta 15to64 15to64 = CE 15to64 15to64 / Pop 15to64 
#  CE 15to64 5to14 = 2
#  Beta 15to64 5to14 = CE 15to64 5to14 / Pop 15to64 
#  CE 15to64 65 = 2
#  Beta 15to64 65 = CE 15to64 65 / Pop 15to64 
#  CE 5to14 0to4 = 2
#  Pop 5to14 = E 5to14 + I Mil 5to14 + I Mod 5to14 + I Sev 5to14 + R 5to14 + S 5to14
#  Beta 5to14 0to4 = CE 5to14 0to4 / Pop 5to14 
#  CE 5to14 15to64 = 2
#  Beta 5to14 15to64 = CE 5to14 15to64 / Pop 5to14 
#  CE 5to14 5to14 = 2
#  Beta 5to14 5to14 = CE 5to14 5to14 / Pop 5to14 
#  CE 5to14 65 = 2
#  Beta 5to14 65 = CE 5to14 65 / Pop 5to14 
#  CE 65 0to4 = 2
#  Pop 65 = E 65 + I Mil 65 + I Mod 65 + I Sev 65 + R 65 + S 65 
#  Beta 65 0to4 = CE 65 0to4 / Pop 65 
#  CE 65 15to64 = 2
#  Beta 65 15to64 = CE 65 15to64 / Pop 65 
#  CE 65 5to14 = 2
#  Beta 65 5to14 = CE 65 5to14 / Pop 65 
#  CE 65 65 = 2
#  Beta 65 65 = CE 65 65 / Pop 65 
#  Cohort Tot 0to4 = I Mil 0to4 + I Mod 0to4 + I Sev 0to4 + E 0to4 + S 0to4 + R 0to4 + Deaths 0to4 
#  Cohort Tot 15to64 = I Mil 15to64 + I Mod 15to64 + I Sev 15to64 + E 15to64 + S 15to64 + R 15to64 + Deaths 15to64 
#  Cohort Tot 5to14 = E 5to14 + I Mil 5to14 + I Mod 5to14 + I Sev 5to14 + R 5to14+ S 5to14 + Deaths 5to14 
#  Cohort Tot 65 = E 65 + I Mil 65 + I Mod 65 + I Sev 65 + R 65 + S 65 + Deaths 65
#  Delay Mil 15to64 = 2
#  Delay Mil 5to14 = 2
#  Delay Mil 65 = 2
#  Delay Mild 0to4 = 2
#  Delay Mod 0to4 = 2
#  Delay Mod 15to64 = 2
#  Delay Mod 5to14 = 2
#  Delay Mod 65 = 2
#  Delay Sev 0to4 = 2
#  Delay Sev 15to64 = 2
#  Delay Sev 5to14 = 2
#  Delay Sev 65 = 2
#  DP 0to4 = 0.001
#  DP 15to64 = 0.001
#  DP 5to14 = 0.001
#  DP 65 = 0.001
#  DR 0to4 = I Sev 0to4 * DP 0to4 
#  DR 15to64 = I Sev 15to64 * DP 15to64 
#  DR 5to14 = I Sev 5to14 * DP 5to14 
#  DR 65 = I Sev 65 * DP 65 
#  LP Mil 15to64 = 2
#  ER Mil 15to64 = E 15to64 / LP Mil 15to64 
#  LP Mil 5to14 = 2
#  ER Mil 5to14 = E 5to14 / LP Mil 5to14 
#  LP Mil 65 = 2
#  ER Mil 65 = E 65 / LP Mil 65 
#  LP Mil 0to4 = 2
#  ER Mild 0to4 = E 0to4 / LP Mil 0to4 
#  LP Mod 0to4 = 2
#  ER Mod 0to4 = E 0to4 / LP Mod 0to4 
#  LP Mod 15to64 = 2
#  ER Mod 15to64 = E 15to64 / LP Mod 15to64 
#  LP Mod 5to14 = 2
#  ER Mod 5to14 = E 5to14 / LP Mod 5to14 
#  LP Mod 65 = 2
#  ER Mod 65 = E 65 / LP Mod 65 
#  LP Sev 0to4 = 2
#  ER Sev 0to4 = E 0to4 / LP Sev 0to4 
#  LP Sev 15to64 = 2
#  ER Sev 15to64 = E 15to64 / LP Sev 15to64 
#  LP Sev 5to14 = 2
#  ER Sev 5to14 = E 5to14 / LP Sev 5to14 
#  LP Sev 65 = 2
#  ER Sev 65 = E 65 / LP Sev 65 
#  FINAL TIME = 20
#  INITIAL TIME = 0
#  Tot I 0to4 = I Mil 0to4 + I Mod 0to4 + I Sev 0to4 
#  Tot I 5to14 = I Mil 5to14 + I Mod 5to14 + I Sev 5to14 
#  Tot I 15to64 = I Mil 15to64 + I Mod 15to64 + I Sev 15to64 
#  Tot I 65 = I Mil 65 + I Mod 65 + I Sev 65 
#  Lambda 0to4 = Beta 0to4 0to4 * Tot I 0to4 + Beta 0to4 5to14 * Tot I 5to14 + 
#             Beta 0to4 15to64 * Tot I 15to64 + Beta 0to4 65 * Tot I 65 
#  IR 0to4 = Lambda 0to4 * S 0to4 
#  Lambda 15to64 = Beta 15to64 0to4 * Tot I 0to4 + Beta 15to64 5to14 * Tot I 5to14
#                  + Beta 15to64 15to64 * Tot I 15to64 + Beta 15to64 65 * Tot I 65
#  IR 15to64 = Lambda 15to64 * S 15to64 
#  Lambda 5to14 = Beta 5to14 0to4 * Tot I 0to4 + Beta 5to14 5to14 * Tot I 5to14
#                  + Beta 5to14 15to64 * Tot I 15to64 + Beta 5to14 65 * Tot I 65
#  IR 5to14 = Lambda 5to14 * S 5to14 
#  Lambda 65 = Beta 65 0to4 * Tot I 0to4 + Beta 65 5to14 * Tot I 5to14 + Beta 65 15to64 * Tot I 15to64 + Beta 65 65 * Tot I 65 
#  IR 65 = Lambda 65 * S 65 
#  RR Mil 15to64 = I Mil 15to64 / Delay Mil 15to64 
#  RR Mil 5to14 = I Mil 5to14 / Delay Mil 5to14 
#  RR Mil 65 = I Mil 65 / Delay Mil 65 
#  RR Mild 0to4 = I Mil 0to4 / Delay Mild 0to4 
#  RR Mod 0to4 = I Mod 0to4 / Delay Mod 0to4 
#  RR Mod 15to64 = I Mod 15to64 / Delay Mod 15to64 
#  RR Mod 5to14 = I Mod 5to14 / Delay Mod 5to14 
#  RR Mod 65 = I Mod 65 / Delay Mod 65 
#  RR Sev 0to4 = I Sev 0to4 / Delay Sev 0to4 
#  RR Sev 15to64 = I Sev 15to64 / Delay Sev 15to64 
#  RR Sev 5to14 = I Sev 5to14 / Delay Sev 5to14 
#  RR Sev 65 = I Sev 65 / Delay Sev 65 
#  TIME STEP = 0.125
#  SAVEPER = TIME STEP 
#  Total I = Tot I 0to4 + Tot I 15to64 + Tot I 5to14 + Tot I 65 
#  V Delay 0to4 = 2
#  V Delay 15to64 = 2
#  V Delay 5to14 = 2
#  V Delay 65 = 2
#  V Eff 0to4 = 0.7
#  V Eff 15to64 = 0.7
#  V Eff 5to14 = 0.7
#  V Eff 65 = 0.7
#  V Given 0to4 = min ( S 0to4 , ( V 0to4 / V Delay 0to4 ) * V Eff 0to4 ) 
#  V Given 15to64 = min ( S 15to64 , ( V 15to64 / V Delay 15to64 ) * V Eff 15to64) 
#  V Given 5to14 = min ( S 5to14 , ( V 5to14 / V Delay 5to14 ) * V Eff 5to14 ) 
#  V Given 65 = min ( S 65 , ( V 65 / V Delay 65 ) * V Eff 65 ) 
#  V Produced = 2
#  V Ratio 0to4 = 0.2
#  V Prop 0to4 = V * V Ratio 0to4 
#  V Ratio 15to64 = 0.2
#  V Prop 15to64 = V * V Ratio 15to64 
#  V Ratio 5to14 = 0.2
#  V Prop 5to14 = V * V Ratio 5to14 
#  V Ratio 65 = 0.2
#  V Prop 65 = V * V Ratio 65 
#  V Used 0to4 = V Given 0to4 
#  V Used 15to64 = V Given 15to64 
#  V Used 5to14 = V Given 5to14 
#  V Used 65 = V Given 65 
#----------------------------------------------------
