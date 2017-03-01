library(gdata)
library(ggplot2)

traffic <- read.xls("Polynomial Fit/Count.xlsx")

t_data  <- traffic[,3]
x       <- 1:length(t_data)

m       <- lm(t_data ~ poly(x,3,raw = T))  # similar to polyfit

y_est   <- predict(m,data.frame(x))   # similar to polyval

f_poly3 <- y ~ poly(x, 3, raw = TRUE)
f_poly6 <- y ~ poly(x, 6, raw = TRUE)

df<-data.frame(x=x,y=t_data)
p <- ggplot(df, aes(x, y)) 
p <- p + geom_point(alpha=2/10, shape=21, fill="blue", colour="black", size=5)
p <- p + geom_smooth(method = "lm", se = FALSE, formula = f_poly6, colour = "red")
p <- p + geom_smooth(method = "lm", se = F, formula = f_poly3, colour = "blue")

