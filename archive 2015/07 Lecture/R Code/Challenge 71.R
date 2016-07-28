getOdd<-function(v){
  length(v[v%%2 == 0])
}

filterEvens<-function(v){
  v[v[v%%2==1]]
}


unique<-function(v){
  v[!duplicated(v)]
}
