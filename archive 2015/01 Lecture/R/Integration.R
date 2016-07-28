INIT<-100
DT<-0.5
time<-seq(0,10,by=DT)
deriv<-4*time # dy/dt = 4t
integral<-time*0 # just to setup the vector size

#initialise stock for the first time unit
integral[1]<-INIT

for(i in 2:length(time))
{
  integral[i]<-integral[i-1]+deriv[i-1]*DT
}

plot(time,deriv, main = "Derivative")
plot(time,integral, main = "Integral of y = 4t")


