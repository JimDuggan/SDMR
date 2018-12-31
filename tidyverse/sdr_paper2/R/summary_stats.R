summary_stats1 <- function(model, data){
  rss <- sum((model - data) ^2)
  tss <- sum((data-mean(data)) ^ 2)
  1 - rss/tss
}

coeff_det <- function(model, data){
  n       <- length(data)
  s_m     <- sqrt(sum((data - mean(data)) ^ 2)/n)
  s_d     <- sqrt(sum((model - mean(model)) ^ 2)/n)
  r       <- (1/n)*sum((data-mean(data))*(model-mean(model))/(s_d*s_m))
  
  r^2
}