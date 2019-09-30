test1 <- function(x){
  rv <- c()
  for (i in 1:NROW(x)){
   rv <- c(rv,  mean(x[i, ]))
  }
  rv
}
library("microbenchmark")
fn2 <- function(reps){
  for( i in 1:reps){
    y <- matrix(rnorm(100000), 100)
    print(test1(y))
  }
}

microbenchmark(test1=fn2(50), times=50)
