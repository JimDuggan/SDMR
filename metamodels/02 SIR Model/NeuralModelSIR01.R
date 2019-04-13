library(readr)
library(neuralnet)
library(dplyr)
source("metamodels/02 SIR Model/RunModel.R")

normalise <- function(x){
  (x - min(x)) / (max(x) - min(x))
}

normalise_single <- function(val,x){
  (val - min(x)) / (max(x) - min(x))
}

denormalise <- function(den_x, orig_x){
  den_x * (max(orig_x) - min(orig_x)) + min(orig_x)
}

data <- read_csv("metamodels/02 SIR Model/SIRData.csv") %>%
        select(-Trial)

# normalise the data
data_n <- data.frame(lapply(data,normalise))

sample_rows <- sample(1:nrow(data_n),nrow(data_n)*.70)
data_n_train <- data_n[sample_rows,]
data_n_test  <- data_n[-(sample_rows),]


# create the model
#sir_mod <- neuralnet(Susceptible~Time+R0+DelayI, data=data_n_train,hidden = 5,linear.output = F)

mods <- lapply(rev(seq(1,10,by=2)),function(nodes){
  print(sprintf("Running model with hidden =  %d",nodes))
  sir_mod <- neuralnet(Infected~Time+R0+DelayI, data=data_n_train,hidden = nodes,linear.output = F)
})

sir_mod <- mods[[1]]

plot(sir_mod)

test_data <- sample_n(data,1)

test_run <- data.frame(Time=normalise(unique(data$Time)),
                       R0=normalise_single(2.0,data$R0),
                       DelayI=normalise_single(4.0,data$DelayI))

test_results <- neuralnet::compute(sir_mod, test_run)

pred <- denormalise(test_results$net.result,data$Infected)

plot(pred)

data_compare <- data.frame(time=unique(data$Time),
                           Prediction=pred)

init_connection("metamodels/02 SIR Model/Vensim/01 SIR Aggregate.mdl")
data_compare$Actual <- run_sir_model(1,
                                      2.0,
                                      4.0)$Infected[-1]

ggplot(data=data_compare)+geom_line(aes(x=time,y=Prediction),colour="red")+
  geom_line(aes(x=time,y=Actual),colour="blue")




