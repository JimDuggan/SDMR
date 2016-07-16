simtime<-function(start, finish, DT=1){
  seq(start,finish,by = DT)
}

add<-function(a,b){
  a+b
}

number_odd<-function(v){
  length(v[v%%2 == 1])
}

x<-add(1,3)