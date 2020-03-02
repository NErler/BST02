#' ---
#' title: "Demo: The Apply family"
#' subtitle: "NIHES BST02"
#' author: "Eleni-Rosalina Andrinopoulou, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: 
#'   html_document:
#'     toc: true
#'     toc_float:
#'       collapsed: false
#' ---
#' 

#' ## Load packages 
#' If you are using the package for the first time, you will have to first install it
# install.packages("survival") 
library(survival)

#' ## Get data
#' Load data sets from package
pbc <- survival::pbc
pbcseq <- survival::pbcseq

#' ## Wide format data

#' ### apply

#' Obtain the mean of columns `time` and `age` in the `pbc` data set
apply(pbc[, c(2,5)], 2, mean)
apply(pbc[, c("time", "age")], 2, mean)

#' Obtain the mean of rows in the `pbc` data set \
#' Before running the code, think if it is meaningful 
# apply(pbc[, ], 1, mean)

#' Obtain the standardized values of columns `time`, `age` and `bili` in the `pbc` data set
head(apply(pbc[, c("time", "age", "bili")], 2, function(x) (x-mean(x))/sd(x)))

#' Other examples \
#' Create a matrix
X <-  sample(0:200, 100)
Mat <- matrix(X, 50, 50) 

#' Obtain the mean value of each row for matrix `Mat`
apply(Mat, 1, mean)

#' Obtain the mean value of each column for matrix `Mat`
apply(Mat, 2, mean)

#' Calculate the sum of each column for matrix `Mat`
apply(Mat, 2, sum)
apply(Mat, 2, function(x) sum(x))

#' Calculate the sum of each row for matrix `Mat`
apply(Mat, 1, sum)
apply(Mat, 1, function(x) sum(x))

#' There is no one way of doing things in R!
colSums(Mat)
rowSums(Mat)


#' ### lapply

#' Obtain the summary of the `pbc` data set
lapply(pbc, summary)

#' Ontain the number of missing values per `pbc` variable
lapply(pbc, function(x) sum(is.na(x))) 

#' Other examples \
#' Obtain the quadratic term of the vector `1:3` \
#' Present the results as a list
lapply(1:3, function(x) x^2)

#' Create a list that consist of `Mat` and `Mat^2` \
#' Obtain the mean of each element \
#' Present the results as a list
X <- list(Mat, Mat^2)
lapply(X, mean)

#'Create a list
A <- matrix(1:9, 3,3)
B <- matrix(4:15, 4,3)
C <- matrix(8:10, 3,2)

#' Select elements in a list
MyList <- list(A,B,C) 

#' Select the first row of each element \
#' Present the results as a list
lapply(MyList,"[", 1, )

#' Select the second column of each element \
#' Present the results as a list
lapply(MyList,"[", , 2)


#' ### sapply

#' Obtain the number of missing values per `pbc` variable
sapply(pbc, function(x) sum(is.na(x))) 

#' Other examples \
#' Obtain the quadratic term of the vector `1:3` \
#' Present the results as a vector
sapply(1:3, function(x) x^2)

#' Create a list that consist of `Mat` and `Mat^2` \
#' Obtain the mean of each element \
#' Present the results as a vector
X <- list(Mat, Mat^2)
sapply(X, mean)

#' Select the second column and first row of each element \
#' Present the results as a vector
sapply(MyList,"[", 2, 1)


#' ### tapply

#' Obtain the mean `age` and `time` per `sex`
tapply(pbc$age, pbc$sex, mean)
tapply(pbc$time, pbc$sex, mean)

#' Obtain the mean `age` and `time` (both elements of the variables devided by two) per `sex`
tapply(pbc$age, pbc$sex, function(x) mean(x/2))
tapply(pbc$time, pbc$sex, function(x) mean(x/2))

#' Obtain the mean `age` and `time` per `sex` and `status`
tapply(pbc$age, list(pbc$status, pbc$sex), mean)
tapply(pbc$time, list(pbc$status, pbc$sex), mean)


#' ### mapply

#' Create a list: \
#' 
#' * 1st element: repeats 1 four times \
#' * 2nd element: repeats 2 three times  \  \
#' * 3rd element: repeats 3 two times  \ \
#' * 4th element: repeats 4 one time
mapply(rep, 1:4, 4:1)
#### alternative run: list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))

#' Create a list: \
#' 
#' * 1st element: repeats 4 one times \
#' * 2nd element: repeats 4 two times \  \
#' * 3rd element: repeats 4 three times \  \
#' * 4th element: repeats 4 four time
mapply(rep, times = 1:4, x = 4)
#### alternative run: list(rep(4, times = 1), rep(4, times = 2), rep(4, times = 3), rep(4, times = 4))

#' Create a list: \
#'
#' * 1st element: repeats 1 four times \ \
#' * 2nd element: repeats 2 four times \ \
#' * 3rd element: repeats 3 four times \  \
#' * 4th element: repeats 4 four time
mapply(rep,1:4, 4, SIMPLIFY = FALSE)
### alternative run: list(rep(1, 4), rep(2, 4), rep(3, 4), rep(4, 4))

#' Note: if the length is the same we can obtain a simplified output
mapply(rep,1:4, 4, SIMPLIFY = TRUE)
### alternative run: matrix(c(rep(1, 4), rep(2, 4), rep(3, 4), rep(4, 4)), 4, 4)

#' Other examples
mapply(function(x,y) seq_len(x) + y,
       c(a = 1, b = 2, c = 3),  
       c(A = 10, B = 0, C = -10))
#### alternative run: list(c(1) + 10, c(1, 2) + 0, c(1, 2, 3) - 10)

X <- list(Mat, Mat^2)
mapply(mean, X)

#' Note!
mapply(mean, MyList)
sapply(MyList, mean)

mapply(function(x,y) {x^y}, x = c(2, 3), y = c(4))
#### alternative run: list(2^4, 3^4)


#' ## Long format data

#' Let's assume that only the long format data set `pbcseq` is available \
#' We want to obtain the mean `serum bilirubin` of the last follow-up measurement (specified as `day`) per `status` group \
#' Each patient is counted once! \
head(pbcseq)

#' Sort data
pbcseq <- pbcseq[order(pbcseq$id, pbcseq$day), ]

#' Select the last follow-up measurement of each patient
pbcseq.idNEW2 <- pbcseq[tapply(rownames(pbcseq), pbcseq$id, tail,  1), ]

#' Step by step
tapply(rownames(pbcseq), pbcseq$id, tail,  1)

### alternative run: pbcseq.idNEW2 <- pbcseq[!duplicated(pbcseq[c("id")], fromLast = TRUE), ]

#' Obtain the mean `serum bilirubin` per `status` group
tapply(pbcseq.idNEW2$bili, pbcseq.idNEW2$status, mean)


#' Let's again assume that only the long format data set `pbcseq` is available \
#' We want to obtain the mean `serum bilirubin` of the last stage of `edema` (for multiple cases select last follow-up measurement) per `status` group \
#' Each patient and `edema` stage is counted once! \
head(pbcseq)

#' Sort data
pbcseq <- pbcseq[order(pbcseq$id, pbcseq$edema, pbcseq$day), ]

#' Select the last stage of `edema` of each patient
pbcseq.idNEW3 <- pbcseq[tapply(rownames(pbcseq), pbcseq$id, tail,  1), ]

#' Step by step
tapply(rownames(pbcseq), pbcseq$id, tail,  1)

### alternative run: pbcseq.idNEW3 <- pbcseq[!duplicated(pbcseq[c("id")], fromLast = TRUE), ]

#' Obtain the mean `serum bilirubin` per `status` group
tapply(pbcseq.idNEW3$bili, pbcseq.idNEW3$status, mean)




