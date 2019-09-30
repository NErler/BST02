#################
# Load packages #
#################

#install.packages("JM")
library(JM)

####################
# The apply family #
####################

## apply
apply(pbc2.id[, c(2,5)], 2, mean)
apply(pbc2.id[, c("years", "age")], 2, mean)

X <-  sample(0:200, 100)
Mat <- matrix(X, 50, 50) 
apply(Mat, 1, mean)
apply(Mat, 2, mean)
apply(Mat, 2, function(x) x^2)

## lapply

lapply(1:3, function(x) x^2)

X <- list(Mat, Mat^2)
lapply(X, mean)

A <- matrix(1:9, 3,3)
B <- matrix(4:15, 4,3)
C <- matrix(8:10, 3,2)
MyList <- list(A,B,C) 
lapply(MyList,"[", 1, )
lapply(MyList,"[", , 2)

## sapply

sapply(1:3, function(x) x^2)

X <- list(Mat, Mat^2)
sapply(X, mean)

sapply(MyList,"[", 2, 1)

## tapply 

tapply(pbc2.id$age, pbc2.id$sex, mean)
tapply(pbc2.id$years, pbc2.id$sex, mean)

tapply(pbc2.id$age, pbc2.id$sex, function(x) mean(x/2))

## mapply 

mapply(rep, 1:4, 4:1)
#### list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))

mapply(rep, times = 1:4, x = 4)
#### list(rep(4, times = 1), rep(4, times = 2), rep(4, times = 3), rep(4, times = 4))

mapply(rep, 1:4, 4)
### X = matrix(c(rep(1, 4), rep(2, 4), rep(3, 4), rep(4, 4)), 4, 4)

mapply(function(x,y) seq_len(x) + y,
       c(a = 1, b = 2, c = 3),  
       c(A = 10, B = 0, C = -10))
#### list(c(1) + 10, c(1, 2) + 0, c(1, 2, 3) - 10)

X <- list(Mat, Mat^2)
mapply(mean, X)

mapply(mean, MyList)
sapply(MyList, mean)

mapply(function(x,y) {x^y}, x = c(2, 3), y = c(4))
#### list(2^4, 3^4)



####################
# Long format data #
####################

## Let's assume that only the long format of the data set is available. 
## We want to obtain the mean serum bilirubin of the last follow-up 
## measurements per event group. 
## Each patient is counted once!
head(pbc2)

## sort data
pbc2 <- pbc2[order(pbc2$id, pbc2$year), ]

## select the last follow-up measurement of each patient
pbc2.idNEW2 <- pbc2[!duplicated(pbc2[c("id")], fromLast = TRUE), ]

duplicated(pbc2[c("id")])
duplicated(pbc2[c("id")], fromLast = TRUE)
!duplicated(pbc2[c("id")], fromLast = TRUE)

## obtain the mean serum bilirubin per event group
tapply(pbc2.idNEW2$serBilir, pbc2.idNEW2$status, mean)



## Let's assume that we want to obtain the mean serum bilirubin 
## of the last stage of edema per event group.
## Each patient and edema stage is counted once!

## sort data
pbc2 <- pbc2[order(pbc2$id, pbc2$edema), ]

## select the last stage of edema of each patient
pbc2.idNEW3 <- pbc2[!duplicated(pbc2[c("id")], fromLast = TRUE), ]

duplicated(pbc2[c("id")])
duplicated(pbc2[c("id")], fromLast = TRUE)
!duplicated(pbc2[c("id")], fromLast = TRUE)

## obtain the mean serum bilirubin per event group
tapply(pbc2.idNEW3$serBilir, pbc2.idNEW3$status, mean)




