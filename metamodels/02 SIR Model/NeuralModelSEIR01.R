library(readr)
library(neuralnet)
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

data <- read_csv("metamodels/02 SIR Model/SEIRData.csv") %>%
        select(-Trial)

# normalise the data
data_n <- data.frame(lapply(data,normalise))

sample_rows <- sample(1:nrow(data_n),nrow(data_n)*.70)
data_n_train <- data_n[sample_rows,]
data_n_test  <- data_n[-(sample_rows),]


# create the model
sir_mod <- neuralnet(Infected~Time+R0+DelayI, data=data_n_train,hidden = 2)
plot(sir_mod)

test_data <- sample_n(data,1)

test_run <- data.frame(Time=normalise(unique(data$Time)),
                       R0=normalise_single(test_data$R0,data$R0),
                       DelayI=normalise_single(test_data$DelayI,data$DelayI))

test_results <- neuralnet::compute(sir_mod, test_run)

pred <- denormalise(test_results$net.result,data$Infected)

plot(pred)

data_compare <- data.frame(time=unique(data$Time),
                           Prediction=pred)

init_connection("metamodels/02 SIR Model/Vensim/01 SEIR.mdl")
data_compare$Actual <- run_seir_model(1,
                                      test_data$R0,
                                      test_data$DelayE,
                                      test_data$DelayI)$Infected[-1]

ggplot(data=data_compare)+geom_line(aes(x=time,y=Prediction),colour="red")+
  geom_line(aes(x=time,y=Actual),colour="blue")




