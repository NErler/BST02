#############
# Example 1 #
#############

set.seed(2018)
dat <- data.frame(
  id = rep(c(1:2), each = 5),
  sex = rep(c("male", "female"), each = 5),
  time = rep(c(1:5), times = 2),
  value = rnorm(10)
)

dat

reshape(dat, idvar = "id", timevar = "time", direction = "wide", 
        v.names = "value")

#############
# Example 2 #
#############

set.seed(2018)
dat <- data.frame(
  id = unlist(mapply(rep, x = 1:3, each = 3:5)),
  time = unlist(mapply(seq_len, c(3:5))),
  scores = rnorm(12)
)

dat

reshape(dat, idvar = "id", timevar = "time", direction = "wide", 
        v.names = "scores")
