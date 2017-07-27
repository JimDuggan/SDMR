
t <- seq(from = 0,to = 20)

gr <- 0.02
gr

init_pop <- 1000
init_pop


pop1 <- init_pop * exp(gr*t) 

f1 <- function(init,t, gr) {init * exp(gr*t) }

pop2 <- f1(1000,0:20,0.02)

