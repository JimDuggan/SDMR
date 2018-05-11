
t <- seq(from = 0,to = 10)

# access the first element of t
t[1]

# access the first three elements of t
t[1:3]


g <- 0.02

init_pop <- 1000
init_pop


pop1 <- init_pop * exp(g*t) 

f1 <- function(init,t, g) {init * exp(g*t) }

pop2 <- f1(1000,0:10,0.02)

