library(stringr)
library(stringi)

sim <- new.env(parent=emptyenv())
#-------------------------------------------------------------------
# Functions to prepare the input for processing
sim$get_input_vensim<-function(file){
  #input<-readLines("./reader/vensim.txt",n=-1)
  sim$input<<-readLines(file,n=-1)
}

sim$is_stock<-function(rhs){
  grepl("^INTEG\\(.+)$", rhs)
}

sim$get_stock<-function(s){
  leftb_loc<-str_locate(s,"\\(")[1,1]
  comma_loc<-str_locate(s,"\\,")[1,1]
  rightb_loc<-str_locate(s,"\\)")[1,1]
  eqn<-str_trim(substr(s,leftb_loc+1,comma_loc-1))
  init<-str_trim(substr(s,comma_loc+1,rightb_loc-1))
  has_aux<-init %in% sim$eqs$Left
  list(EQN=eqn,INIT=init,HAS_AUX=has_aux)
}

sim$get_eqns<-function (input){
  clean<-str_trim(input[input!= "\t"])
  spl<-strsplit(clean,"=")
  #LHS<-str_trim(sapply(spl,function(l)l[1]))
  #RHS<-str_trim(sapply(spl,function(l)l[2]))
  LHS<-gsub(" ","",str_trim(sapply(spl,function(l)l[1])))
  RHS<-gsub(" ","",str_trim(sapply(spl,function(l)l[2])))
  S<-sim$is_stock(RHS)
  G<-vector(mode = "logical",length = length(S))
  G[1:max(which(S==T))]=T
  P<-vector(mode = "logical",length = length(S))
  sim$eqs<<-list(Left=LHS,Right=RHS,isStock=S,Globals=G,Processed=P)
}
#-------------------------------------------------------------------


#-------------------------------------------------------------------
# Step 1 - Get the header information
sim$get_header<-function(){
  output<-"###########################################"
  output<-c(output,"# Translation of Vensim file.")
  output<-c(output,sprintf("# Date created: %s",Sys.time()))
  output<-c(output,"###########################################")
  output<-c(output,"library(deSolve)")
  output<-c(output,"library(ggplot2)")
  output<-c(output,"library(reshape2)")

}

#-------------------------------------------------------------------
# Step 2 - get the start time, finish time and time step
sim$get_sim_info<-function(){
  output<-"#Displaying the simulation run parameters"
  START_TIME<-as.numeric(sim$eqs$Right[which(sim$eqs$Left=="INITIALTIME")])
  output<-c(output,sprintf("START_TIME <- %f",START_TIME))
  
  FINISH_TIME<-as.numeric(sim$eqs$Right[which(sim$eqs$Left=="FINALTIME")])
  output<-c(output,sprintf("FINISH_TIME <- %f",FINISH_TIME))
  DT<-as.numeric(sim$eqs$Right[which(sim$eqs$Left=="TIMESTEP")])
  output<-c(output,sprintf("TIME_STEP <- %f",DT))
  
  output<-c(output,"#Setting aux param to NULL")
  output<-c(output,"auxs<-NULL")
  
  
  # superassignment operator...
  sim$eqs$Processed[which(sim$eqs$Left=="INITIALTIME")]<<-TRUE
  sim$eqs$Processed[which(sim$eqs$Left=="FINALTIME")]<<-TRUE
  sim$eqs$Processed[which(sim$eqs$Left=="TIMESTEP")]<<-TRUE
  sim$eqs$Processed[which(sim$eqs$Left=="SAVEPER")]<<-TRUE
  
  output<-c(output,"", "#Generating the simulation time vector")
  
  output<-c(output,sprintf("simtime<-seq(%f,%f,by=%f)",START_TIME,FINISH_TIME,DT))
  
  output
}

#-------------------------------------------------------------------
# Step 3 - Get the global variables (stocks and dependent auxs)
sim$get_globals<-function(){
  output<-"# Writing global variables (stocks and dependent auxs)"
  stocks_str <- "stocks <-c("
  for(i in 1:length(sim$eqs$Left)){
    if(sim$eqs$Processed[i]==TRUE) {
      next
    }
    if(sim$eqs$Globals[i] == T){
      if(sim$eqs$isStock[i]==TRUE){
        st<-sim$get_stock(sim$eqs$Right[i])
        stocks_str<-paste(stocks_str,sim$eqs$Left[i],"=",st$INIT,",")
        sim$eqs$Processed[i]<<-TRUE
      }
      else{
        output<-c(output,sprintf("%s = %s",sim$eqs$Left[i],sim$eqs$Right[i]))
        sim$eqs$Processed[i]<<-TRUE
      }
    }
  }
  stocks_str<-stringi::stri_replace_last_fixed(stocks_str, ",", ")")
  output<-c(output,stocks_str)
}

#-------------------------------------------------------------------
# Step 4 - Construct the model function
sim$get_function<-function(n="model"){
  output<-"# This is the model function called from ode"
  output<-c(output,sprintf("%s <- function(time, stocks, auxs){",n))
  output<-c(output,sprintf("  with(as.list(c(stocks, auxs)),{"))
  
  # Process all the variables
  for(i in 1:length(sim$eqs$Left)){
    if(sim$eqs$Processed[i]==TRUE) {
      next
    }
    if(sim$eqs$Globals[i] == F){
      output<-c(output,sprintf("    %s <- %s",sim$eqs$Left[i],sim$eqs$Right[i]))
      sim$eqs$Processed[i]<-TRUE
    }
  }
  
  # now process the stocks
  stocks<-sim$eqs$Left[sim$eqs$isStock]
  dt_names<-paste0("d_DT_",stocks)
  stock_equations<-lapply(sim$eqs$Right[sim$eqs$isStock],function(l)sim$get_stock(l))
  
  for(i in 1:length(stocks)){
    output<-c(output,sprintf("    %s  <- %s",dt_names[i],stock_equations[[i]]$EQN))
  }
  
  # now return the integrals
  
  return_str <- "return (list(c("
  
  for(i in 1:length(dt_names)){
    return_str<-paste0(return_str,dt_names[i],",")
  }
  
  return_str<-stringi::stri_replace_last_fixed(return_str, ",", ")))")

  output<-c(output,sprintf("    %s",return_str))
  output<-c(output,"  })")
  output<-c(output,"}")

  output
}

#-------------------------------------------------------------------
# Step 5 - Call the model
sim$call_ode<-function(m="model"){
  output<-"# Function call to run simulation"
  s<-sprintf("ode(y=stocks,times=simtime,func=%s,parms=auxs,method=%s)",
             m,shQuote("euler"))
  output<-c(output,sprintf("o<-data.frame(%s)",s))
  
  output<-c(output,sprintf("mo<-melt(o,id.vars = %s)",shQuote("time")))
  output<-c(output,sprintf("names(mo)<-c(%s,%s,%s)",
                           shQuote("Time"),shQuote("Stock"),shQuote("Value")))
  output<-c(output,
            sprintf("ggplot(data=mo)+geom_line(aes(x=Time,y=Value,colour=Stock))"))
}

#-------------------------------------------------------------------
# Step 6 - Write original equations
sim$list_original<-function(){
  output<-"#----------------------------------------------------"
  output<-c(output,"# Original text file exported from Vensim")
  output<-c(output,paste("# ",sim$input[sim$input != "\t"]))
  output<-c(output,"#----------------------------------------------------")
}



sim$save_model<-function(output,name){
  fileConn<-file(name)
  writeLines(output, fileConn)
  close(fileConn)
}

sim$process_all<-function(){
  o<-sim$get_header()
  o<-c(o,sim$get_sim_info())
  o<-c(o,sim$get_globals())
  o<-c(o,sim$get_function())
  o<-c(o,sim$call_ode())
  o<-c(o,sim$list_original())
  o
}

#sim$get_eqns(sim$get_input_vensim("./reader/SIR.txt"))
#sim$o<-sim$process_all()
#sim$save_model(sim$o,"./reader/Test.R")

sim$translate_vensim<-function(f){
  sim$get_eqns(sim$get_input_vensim(f))
  sim$o<-sim$process_all()
}







