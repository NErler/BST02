#' ---
#' title: "Demo: Common R Objects"
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
#' If you are using the package for the first time, you will have to first install it \
# install.packages("survival") 
library(survival)

#' ## Get data
#' Load data set from package
pbc <- survival::pbc

#' ## Vectors \
#' Create vectors from a data set
pbc$age
pbc$time

#' Create other vectors \
#' Continuous
vec1 <- c(1:100)
vec2 <- c(2, 32, 14, 23, 54, 13, 45)

#' Categorical
vec3 <- c("male", "female", "female", "male", "female", "female")

#' Logical
vec4 <- c(TRUE, TRUE, FALSE)

#' ## Matrices \
#' Create matrices from a data set
matrix(pbc$time[1:9], 3, 3)
age_time <- cbind(pbc$age, pbc$time)
age_time <- rbind(pbc$age, pbc$time)

#' Create other matrices
matrix(1:4, 2, 2)

#' Fill matrix in by row
matrix(1:4, 2, 2, byrow = TRUE)

#' TAKE CARE
Columns_com <- cbind(c(1:4), c(1:8))

#' ## Data frames \
#' Create data frames from a data set
age_time_sex <- data.frame(pbc$age, pbc$time, pbc$sex)

#' Add names to a data frame
age_time_sex <- data.frame(age = pbc$age, time = pbc$time, sex = pbc$sex)

#' Create other data frames
DF <- data.frame(Age = c(30, 20, 50),
                 Sex = c("male", "female", "female"),
                 Drug = c("yes", "yes", "no"))
head(DF)

DF <- data.frame(Age = runif(30, 1, 80),
                 Sex = sample(1:2, 30, replace = TRUE),
                 Drug = sample(1:3, 30, replace = TRUE))
head(DF)

#' ## Lists \
#' Create lists from a data set
list_pbc <- list(pbc$id, pbc$time)

#' Create other lists
myList <- list(x = c(1:20), sex = c("male", "female")) 
myList
mylist = list(names = c("Jack","Mary"), child.ages = c(4,7,9,10,11))
mylist
