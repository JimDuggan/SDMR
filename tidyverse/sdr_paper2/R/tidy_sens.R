library(stringr)
library(dplyr)
library(readr)
library(tidyr)
library(purrr)

# get the sensitivity variables from the .lst file
get_sens_vars <- function(lst_file){
  readLines(lst_file)
}

# get the sensitivity paameters from the .vsc file
#get_sens_params <- function(vsc_file){
#  vsc_info     <- readLines(vsc_file)
#  params <- unname(sapply(vsc_info[2:length(vsc_info)],function(v){
#    str_split(v,"=")[[1]][1]
#  }))
#  params
#}

get_sens_params <- function(vsc_file){
  vsc_info     <- readLines(vsc_file)
  params <- map_chr(vsc_info[2:length(vsc_info)],function(v){
    str_split(v,"=")[[1]][1]
  })
  params
}

# convert the sensitivity file to tidy data format
tidy_vensim <- function(vars, params, sens_file, DT, START_TIME){

  sens         <- read_tsv(sens_file)
  
  regex_params <- str_c(params,collapse = "|")

  res <- map_df(vars, function(vi){
    df         <- select(sens,Simulation,matches(regex_params),contains(vi))
    n_steps    <- ncol(df) - (length(params)+1)
    FINAL_TIME <- START_TIME + (n_steps-1)*DT
    simtime    <- seq(START_TIME,FINAL_TIME,DT)
    t_df    <- gather(df,Variable,Value,(length(params)+2):ncol(df))          %>%
               mutate(TimeIndex=parse_integer(str_extract(Variable,"\\d+")))  %>%
               mutate(Time=simtime[TimeIndex])                                %>%
               mutate(Variable=vi)                                            %>%
               select(Simulation, Time, everything())                         %>%
               select(-TimeIndex)
    t_df
  })
  
  res
}



