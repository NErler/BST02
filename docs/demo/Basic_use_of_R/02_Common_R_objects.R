#' ---
#' title: "Demo: Common R objects"
#' subtitle: "NIHES BST02"
#' author: "Eleni-Rosalina Andrinopoulou, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: html_document
#' ---
#' 

#' Load packages \
#' If you are using the package for the first time, you will have to first install it \
# install.packages("survival") 
library(survival)

#' Create vectors
vec1 <- c(1:100)
vec2 <- c(2, 32, 14, 23, 54, 13, 45)
vec3 <- c("male", "female", "female", "male", "female", "female")

#' Create matrices
matrix(1:4, 2, 2)

#'Fill matrix in by row
matrix(1:4, 2, 2, byrow = TRUE)

weight_columns <- cbind(pbc$age, pbc$time)
weight_Rows <- rbind(pbc$age, pbc$time)
matrix(weight_columns, , 2)
matrix(weight_Rows, , 2, byrow = TRUE)

#' TAKE CARE
Columns_com <- cbind(c(1:4), c(1:8))

#' Create data frames
DF <- data.frame(Age = c(30, 20, 50),
                 Sex = c("male", "female", "female"),
                 Drug = c("yes", "yes", "no"))

DF <- data.frame(Age = runif(30, 1, 80),
                 Sex = sample(1:2, 30, replace = TRUE),
                 Drug = sample(1:3, 30, replace = TRUE))
head(DF)

#' Create lists
myList <- list(x = c(1:20), sex = c("male", "female")) 
myList
mylist = list(names = c("Jack","Mary"), child.ages = c(4,7,9,10,11))
mylist
