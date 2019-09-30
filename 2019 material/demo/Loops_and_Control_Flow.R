#################
# Load packages #
#################

#install.packages("JM")
library(JM)

##########################
# Loops and Control Flow #
##########################

## Calculate the sum per row
A <- matrix(rnorm(1e06), 1000, 1000)
head(A)
A[1:10 , 1:10]
?rnorm
res1 <- replicate(100, z <- apply(A, 1, sum))
res2 <- replicate(100, z <- rowSums(A)) # Use specialized functions

## compute the cumulative sum
x <- rnorm(1000000, 10, 10)

cSum <- 0
for (k in 1:length(x)){
  cSum <- cSum + x[k]
  cSum
}

i <- 1
cSum <- 0
cSum <- cSum + x[i]
x[1]

i <- 2
cSum <- cSum + x[i]


cumsum(x)
tail(cumsum(x))



system.time({
  cSum <- 0
  for (i in 1:length(x)){
    cSum <- cSum + x[i]
    cSum
  }
})

system.time({
  cumsum(x)
}) # better

## Create a dichotomous variable for age
for (i in 1:dim(pbc2.id)[1]) {
  pbc2.id$ageCat[i] <- as.numeric(pbc2.id$age[i] > 42)
}

i <- 1
pbc2.id$ageCat[i] <- as.numeric(pbc2.id$age[i] > 42)


head(pbc2.id)

pbc2.id[i, ]




pbc2.id$ageCat <- as.numeric(pbc2.id$age > 42)

## calculate the mean weight of males and females in 100 datasets
datlist <- list()

i <- 1
set.seed(2015+i)
patient <- c(1:20)
weight <- rnorm(20, 70, 10)
sex <- sample(1:2, 20, replace = TRUE)
sex <- factor(sex, levels = 1:2, labels = c("male", "female"))

datlist[[i]] <- data.frame(patient, weight, sex)

i <- 2
set.seed(2015+i)
patient <- c(1:20)
weight <- rnorm(20, 70, 10)
sex <- sample(1:2, 20, replace = T)
sex <- factor(sex, levels = 1:2, labels = c("male", "female"))

datlist[[i]] <- data.frame(patient, weight, sex)







for (i in 1:100) {
  set.seed(2015+i)
  patient <- c(1:20)
  weight <- rnorm(20, 70, 10)
  sex <- sample(1:2, 20, replace = T)
  sex <- factor(sex, levels = 1:2, labels = c("male", "female"))
  
  datlist[[i]] <- data.frame(patient, weight, sex)
}


means <- matrix(NA, length(datlist), 2)

i <- 1
dat <- datlist[[i]]
means[i, ] <- tapply(dat$weight, dat$sex, mean)

i <- 2
dat <- datlist[[i]]
means[i, ] <- tapply(dat$weight, dat$sex, mean)


for (i in 1:length(datlist)) {
  dat <- datlist[[i]]
  means[i, ] <- tapply(dat$weight, dat$sex, mean)
}

means

## select datasets were more than 39% of the patients are females
newList <- list()
k <- 1


i=1
i=2
i=3
for (i in 1:length(datlist)) {
  dat <- datlist[[i]]
  if (sum(dat$sex == "female")/20 >= 0.4) {
    newList[[k]] <- dat
    k <- k + 1
  }
}

length(newList)

## select datasets were more than 49% of the patients are males
newList <- list()
k <- 1
for (i in 1:length(datlist)) {
  dat <- datlist[[i]]
  if (sum(dat$sex == "male")/20 >= 0.5) {
    newList[[k]] <- dat
    k <- k + 1
  }
}


## other examples
for (i in 1:10){
  if (i < 5) {
    print(i)
  }
}

for (i in 1:10){
  if (i < 5) {
    print(2*i)
  } else {
    print(i)
  } 
}

## switch
x <- sample(1:250, 100, replace = FALSE)
switch("mean",
       mean = mean(x),
       median = median(x),
       trimmed = mean(x, trim = .1))

switch("median",
       mean = mean(x),
       median = median(x),
       trimmed = mean(x, trim = .1))

switch("trimmed",
       mean = mean(x),
       median = median(x),
       trimmed = mean(x, trim = .1))



## ifelse
ifelse(x >= 100, 2*x, x/2)
