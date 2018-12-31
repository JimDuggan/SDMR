library(dplyr)

stat_screen <- function(tidy, vars, params){
  # Create the output tibble (zero rows initially)
  out_t <- as_data_frame(data.frame(Time=numeric(),
                                    Variable=character(),
                                    Parameter=character(),
                                    Correlation=numeric(),
                                    stringsAsFactors = F))
  
  for(i in seq_along(vars)){
    
    for(j in seq_along(params)){
      df <- tidy %>% filter(Variable==vars[i])  %>%
                     select(Simulation, Time, matches(params[j]),Value)
      
      colnames(df)[3]<-"Parameter"
      
      cor_tab <- df %>% group_by(Time) %>% 
                 dplyr::summarise(Correlation=cor(Value,Parameter)) %>%
                 mutate(Variable=vars[i],
                        Parameter=params[j])

      out_t <- dplyr::add_row(out_t,
                              Time=cor_tab$Time,
                              Variable=cor_tab$Variable,
                              Parameter=cor_tab$Parameter,
                              Correlation=cor_tab$Correlation)
    }
  }
  
  out_t
  
}

