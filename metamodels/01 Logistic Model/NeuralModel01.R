library(readr)
library(neuralnet)

normalise <- function(x){
  (x - min(x)) / (max(x) - min(x))
}

normalise_single <- function(val,x){
  (val - min(x)) / (max(x) - min(x))
}

denormalise <- function(den_x, orig_x){
  den_x * (max(orig_x) - min(orig_x)) + min(orig_x)
}

data <- read_csv("metamodels/01 Logistic Model/data/Logistic.csv")
data <- data[,2:5]

# normalise the data
data_n <- data.frame(lapply(data,normalise))

sample_rows <- sample(1:nrow(data_n),nrow(data_n)*.70)
data_n_train <- data_n[sample_rows,]
data_n_test  <- data_n[-(sample_rows),]
data_n_train<- data_n

# create the model
log_mod <- neuralnet(Population~time+InitialValue+GrowthRate, data=data_n_train,hidden = 1)
plot(log_mod)

# compute the model results 
mod_results <- neuralnet::compute(log_mod, data_n_test[,1:3])

results <- data.frame(time=data_n_test[,1],
                      actual=data_n_test[,4], 
                      prediction=mod_results$net.result)

cor_result <- cor(results$actual,results$prediction)

test_run <- data.frame(time=normalise(1:100),
                       InitialValue=normalise_single(5.33,data$InitialValue),
                       GrowthRate=normalise_single(0.141022268,data$GrowthRate))

test_results <- neuralnet::compute(log_mod, test_run)

pred <- denormalise(test_results$net.result,data$Population)

plot(pred)

data_pred <- data.frame(time=1:100,Prediction=pred)
data_pred$actual <- dplyr::pull(logistic(TR = 1,
                                         Cap = 10000,
                                         P0 = 5.33,
                                         r =0.141022268,
                                         t = 1:100 )[,5])

ggplot(data=data_pred)+geom_line(aes(x=time,y=Prediction),colour="red")+
  geom_line(aes(x=time,y=actual),colour="blue")




