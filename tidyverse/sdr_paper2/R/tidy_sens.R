library(stringr)
library(plyr)
library(dplyr)
library(readr)
library(tidyr)

# get the sensitivity variables from the .lst file
get_sens_vars <- function(lst_file){
  readLines(lst_file)
}

# get the sensitivity paameters from the .vsc file
get_sens_params <- function(vsc_file){
  vsc_info     <- readLines(vsc_file)
  params <- unname(sapply(vsc_info[2:length(vsc_info)],function(v){
    str_split(v,"=")[[1]][1]
  }))
  params
}

# convert the sensitivity file to tidy data format
tidy_vensim <- function(vars_info, params, sens_file, DT, START_TIME){

  sens         <- read_tsv(sens_file)

  regex_params <- str_c(params,collapse = "|")

  res <- lapply(vars_info, function(vi){
    df         <- select(sens,Simulation,matches(regex_params),contains(vi))
    n_steps    <- ncol(df) - (length(params)+1)
    FINAL_TIME <- START_TIME + (n_steps-1)*DT
    simtime    <- seq(START_TIME,FINAL_TIME,DT)
    tidy_df    <- gather(df,ModelVariable,Value,(length(params)+2):ncol(df))           %>%
                   mutate(TimeIndex=parse_integer(str_extract(ModelVariable,"\\d+")))  %>%
                   mutate(Time=simtime[TimeIndex])                                     %>%
                   mutate(ModelVariable=vi)                                            %>%
                   select(Simulation, Time, everything())                   
    tidy_df
  })
  
  as_data_frame(rbind.fill(res))

}



