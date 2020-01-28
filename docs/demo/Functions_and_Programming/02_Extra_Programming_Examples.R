#' ---
#' title: "Demo: Extra Programming examples"
#' subtitle: "NIHES BST02"
#' author: "Eleni-Rosalina Andrinopoulou, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: html_document
#' ---
#' 

#' Load packages
#' If you are using the package for the first time, you will have to first install it:
# install.packages("survival") 
library(survival)


#' Calculate the sum per row
A <- matrix(rnorm(1e06), 1000, 1000)
A[1:10 , 1:10]
#?rnorm
res1 <- replicate(100, z <- apply(A, 1, sum))
res2 <- replicate(100, z <- rowSums(A)) # Use specialized functions

#' Compute the cumulative sum
x <- rnorm(1000000, 10, 10)

cSum <- 0
for (k in 1:length(x)){
  cSum <- cSum + x[k]
  cSum
}

#' Explore how does it work
i <- 1
cSum <- 0
cSum <- cSum + x[i]
x[1]

i <- 2
cSum <- cSum + x[i]


res <- cumsum(x)
tail(res)

#' Explore the timing of the code
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

#' More than one ways exist to code something in R! \
#' Create a dichotomous variable for age
for (i in 1:dim(pbc)[1]) {
  pbc$ageCat[i] <- as.numeric(pbc$age[i] > 42)
}

i <- 1
pbc$ageCat[i] <- as.numeric(pbc$age[i] > 42)


head(pbc)

pbc[i, ]



#' Do the same thing as a vector
pbc$ageCat <- as.numeric(pbc$age > 42)


#' calculate the mean weight of males and females in 100 datasets \
#' If we would do that manually...
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


#' .....

#' Now use a loop
for (i in 1:100) {
  set.seed(2015+i)
  patient <- c(1:20)
  weight <- rnorm(20, 70, 10)
  sex <- sample(1:2, 20, replace = T)
  sex <- factor(sex, levels = 1:2, labels = c("male", "female"))
  
  datlist[[i]] <- data.frame(patient, weight, sex)
}


#' We will have to go through all data sets to calculate the mean age \ 
#' If we would do that manually...
means <- matrix(NA, length(datlist), 2)


i <- 1
dat <- datlist[[i]]
means[i, ] <- tapply(dat$weight, dat$sex, mean)

i <- 2
dat <- datlist[[i]]
means[i, ] <- tapply(dat$weight, dat$sex, mean)


#' Now use a loop
for (i in 1:length(datlist)) {
  dat <- datlist[[i]]
  means[i, ] <- tapply(dat$weight, dat$sex, mean)
}

means

#' Select datasets were more than 39% of the patients are females
newList <- list()
k <- 1

for (i in 1:length(datlist)) {
  dat <- datlist[[i]]
  if (sum(dat$sex == "female")/20 >= 0.4) {
    newList[[k]] <- dat
    k <- k + 1
  }
}

length(newList)

#' Select datasets where more than 49% of the patients are males
newList <- list()
k <- 1
for (i in 1:length(datlist)) {
  dat <- datlist[[i]]
  if (sum(dat$sex == "male")/20 >= 0.5) {
    newList[[k]] <- dat
    k <- k + 1
  }
}

#' Now make a function that takes as input the data sets in a list format, the name of the sex variable and the name of the male category
#' This function returns the data sets where more than 49% of the patients are males in a list

subset_data <- function(dataset = x, sex_var = "sex", male_cat = "male"){
  newList <- list()
  k <- 1
  for (i in 1:length(dataset)) {
    dat <- dataset[[i]]
    if (sum(dat[[sex_var]] == male_cat)/20 >= 0.5) {
      newList[[k]] <- dat
      k <- k + 1
    }
  }
  newList
}

res <- subset_data(dataset = datlist, sex_var = "sex", male_cat = "male")

length(res)

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
