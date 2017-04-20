# Write a function that takes in a vector and returns the number of odd numbers
countOdd<-function(v){
  length(v[v%%2 ==0])
}

# Write a function that takes in a vector and returns a vector of even numbers
getEvens<-function(v){
  v[v%%2 ==0]
}

# Write a function that returns the unique values in a vector
getUnique<-function(v){
  v[!duplicated(v)]
}

