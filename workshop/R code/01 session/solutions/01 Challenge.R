# Solution for Challenge 1

# Create an R vector of squares of 1 to 10
v  <- (1:10)^2

# Find the minimum
mn <- min(v)

# Find the maximum
mx <- max(v)

# Get the mean
mn <- mean(v)

# Display all those greater than the mean
v[v > mn]

# Display all those less than the mean
v[v < mn]

# Display every second vector element
v[c(FALSE,TRUE)]

# Find the index location of the maximum value
which(v == max(v))




