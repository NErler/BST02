# First we make some example data

library(JM)
set.seed(2015+1)
patient <- c(1:20)
name <- paste('Patient', LETTERS[1:20])
height <- rnorm(20, 1.70, 0.1)
weight <- rnorm(20, 70, 10)
sex <- sample(0:1, 20, replace = TRUE)
sex <- factor(sex, levels = 0:1, labels = c("male", "female"))

dat <- data.frame(patient, name, height, weight, sex)



#' ## Functions

## How many patients do we have in the "dat" dataset
length(dat$patient)

#take care
length(dat)
dim(dat)
nrow(dat)

#however
nrow(dat[,c(1)])
NROW(dat[,c(1)])

M<-matrix(1:9,3)
nrow(M)

## Summation of height
sum(dat$height)

## Mean of weight and height
mean(dat$weight)
mean(dat$height)

apply(dat[,3:4], 2, mean) # explained later

## Median of height
median(dat$weight)

## Quantiles of height
quantile(dat$weight)
quantile(dat$weight, probs = c(0.333, 0.667))

## Variance of weight
var(dat$weight)

## Standard deviation of weight
sd(dat$weight)

## Min of height
min(dat$height)

## Max of height
max(dat$height)

## Range of height
range(dat$height)

## Calculate the mean weight
ave(dat$weight)
ave(dat$weight, FUN=median)
(dat$grpmed <-ave(dat$weight, dat$sex, FUN=median))

## Cumulative summation of weight
cumsum(dat$weight)

## Log of height
log(dat$height)
log(dat$height, base = exp(1))
log10(dat$height) # base 10
log2(dat$height) # base 2

## Exp of height
exp(dat$height)

## Calculate the mean of weight per sex and weight group
dat$weight_65higher <- as.numeric(dat$weight > 65)
dat$weight_65higher <- factor(dat$weight_65higher, levels = c(0:1),
                              labels = c("low","high"))
dat$weight_65higher

dat$weight_65higher <- (as.numeric(dat$weight > 65) + 3)
dat$weight_65higher <- factor(dat$weight_65higher, levels = c(3:4),
                              labels = c("low","high"))
dat$weight_65higher

tapply(dat$weight, list(dat$sex, dat$weight_65higher), mean)

## Sort the values of height
sort(dat$height)

## Reverse the values of height
rev(dat$height)

dat[order(dat$weight), ]
dat[order(dat$weight, dat$height), ]
dat[order(dat$weight, -dat$height), ]
dat[order(dat$weight, dat$height,
          decreasing=c(FALSE, TRUE)), ]

rank(dat$weight)

## Check for duplicates
duplicated(dat$weight)
duplicated(c( 1, 1, 1, 2, 2, 1))

unique(c(1,4,1,2,3, 1)) # unique values

## Split the dataset for males and females
split(dat, dat$sex)

## Split weight in two intervals
cut(dat$weight, 2)

cut(dat$weight, c(54, 70, 85))
cut(dat$weight, 3)

## Obtain frequencies
table(dat$weight_65higher)

## Tables
table(dat$weight_65higher, dat$sex)

dat$BMI <- dat$weight/(dat$height^2)
dat$BMIcat <- as.numeric(cut(dat$BMI, 2))
ftable(xtabs(~ dat$weight_65higher + dat$sex + dat$BMIcat))

## Exclude patients with missing values in more than one covariates
dat1 <- dat
dat1$weight[2] <- NA
dat1 <- dat1[complete.cases(dat1$weight, dat1$height, dat1$sex), ]
dat <- dat[complete.cases(dat$weight, dat$height, dat$sex), ]

### General functions
## repeat values
rep(1:2, 2)
rep(1:2, time = 2)
rep(1:2, each = 2)
rep(mean(dat$weight), 20)

## Generate sequences
2:20


seq(1, 10, by = 2)
seq(1,10, length.out=100)
ind <- seq(min(dat$patient), max(dat$patient), by = 2)

dat[ind, ]


## For character vectors
ch1 <- letters[1:6]
ch2 <- LETTERS[1:6]
ch1
ch2
toupper(ch1) # to upper case
tolower(ch2) # to lower case

paste(ch1, ch2)
paste(ch1, ch2, sep = "-")
paste(ch1, ch2, collapse = ",")

paste("Hello", "world")
paste("Hello", "world", sep = "")
paste0("Hello", "world")


## Dimensions
dim(dat)
ncol(dat)
nrow(dat)

## Obtain diagonal
mat <- matrix(1:9, 3, 3)
diag(mat)
diag(5) # create an identity matrix
diag(1:3) # create a diagonal matrix

## Compute the row sums
rowSums(mat) # sum values in each row / sum of the columns
colSums(mat)

## Matrix Transpose
t(mat)

## arithmetics
mat + mat
mat - mat
mat %*% mat
det(mat) # matrix determinant
solve(matrix(c(2,1,3,1),2)) # matrix inverse

var(matrix(c(1,2,1,3,4,6,7,12,8,9),5)) # variance-covariance matrix
cor(matrix(c(1,2,1,3,4,6,7,12,8,9),5)) # correlation matrix

## Obtain all possible combinations
groups <- list(gp1 = 1:3, gp2 = 4:5, gp3 = 6:7, gp4 = 8:10, gp5 = 11)
expand.grid(groups$gp1, groups$gp2)
expand.grid(groups)

cond1 <- c("Type 1", "Type 2", "Type 3")
cond2 <- c("Mild", "Moderate", "Severe")
cond3 <- c("Placebo", "Active")
expand.grid(cond1, cond2, cond3)

## Combine vectors by column
cbind(dat$weight, dat$height)

## Combine vectors by row
rbind(dat$weight, dat$height)

#' ## Create your own functions

g <- function(x=34) {
  x + 100
}



# calculate the standardized values of a covariate
f <- function(x){
  sds <- (x - mean(x))/sd(x)
  return(sds)
}
f(12)



f <- function(y) {
  (y - mean(y))/sd(y)
}
f(dat$weight)
f(dat$height)


m <- 1
s <- 0.1

f <- function(y) {
  (y - m)/s
}
s<-0.2
f(dat$height)


f1 <- function(x) {
  k <- x + 2
  f2 <- function(y) {
    y + 2
  }
  f2(k)
}

f1(10)
#f2(10) # not working


f1 <- function(x) {
  m <- mean(x)
  s <- sd(x)
  function(x){(x-m)/s}
}
f2 <- f1(dat$height)
f(10)

y<- 1:10
func4<-function(x){
  return(x+y )
}
y<-6
func4(3)

# when a variable inside a function is not defined it will look for it in the
# environment where the function is defined
g<-function(x){
  y<-10
  func4(x)
}


