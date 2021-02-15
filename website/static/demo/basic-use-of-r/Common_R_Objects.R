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
#'     df_print: paged
#' ---
#' 

#' ## Load packages 
#' If you are using the package for the first time, you will first have to install it. \
# install.packages("survival") 
#' If you have already downloaded this package in the current version of R, you will only have to load the package.
library(survival)

#' ## Get the data
#' Load a data set from a package.\
#' You can use the double colon symbol (:), to return the pbc object from the package survival. We store this data set to an object with the name pbc.
pbc <- survival::pbc

#' ## Vectors \
#' Examples of vectors can be seen below.
pbc$age
pbc$time

#' * Create vectors with continuous data.
vec1 <- c(1:100)
vec2 <- c(2, 32, 14, 23, 54, 13, 45)

#' * Create a vector with categorical data.
vec3 <- c("male", "female", "female", "male", "female", "female")

#' * Create a vector with logical data.
vec4 <- c(TRUE, TRUE, FALSE)

#' ## Matrices \
#' * Create a matrix using the time variable/vector from the pbc data set.
matrix(data = pbc$time[1:9], nrow = 3, ncol = 3)

#' Useful functions to easily combine columns or rows are the `cbind()` and `rbind()` functions.\
#' We can combine multiple columns as shown below.
age_time <- cbind(pbc$age, pbc$time)
#' We can combine multiple rows as shown below.
age_time <- rbind(pbc$age, pbc$time)

#' TAKE CARE when using these functions.
Columns_com <- cbind(c(1:4), c(1:8))
#' Since the first column has shorter length, R is repeating the numbers. \ \
#' * Create other matrices.\
#' Assume a vector with the elements 1 to 4 and assume 2 rows and 2 columns.\
#' By default the matrix will be filled in by column.
matrix(data = 1:4, nrow = 2, ncol = 2)

#' Fill matrix in by row.
matrix(data = 1:4, nrow = 2, ncol = 2, byrow = TRUE)

#' ## Arrays \
#' * Create an array with 3 rows, 3 columns and 2 matrices.
array(data = 1:18, dim = c(3, 3, 2))
#' * Create an array with 6 rows, 2 columns and 3 matrices.
array(data = 1:12, dim = c(6, 2, 3))
#' Notice that all matrices are the same. R is circulating the elements 1 to 12.
#' 

#' ## Data frames \
#' * Create a data frame using the pbc data set.
age_time_sex <- data.frame(pbc$age, pbc$time, pbc$sex)

#' Add names to the columns of the data frame.
age_time_sex <- data.frame(age = pbc$age, time = pbc$time, sex = pbc$sex)

#' * Create other data frames.
DF <- data.frame(Age = c(30, 20, 50),
                 Sex = c("male", "female", "female"),
                 Drug = c("yes", "yes", "no"))
DF

DF <- data.frame(Age = runif(30, 1, 80),
                 Sex = sample(1:2, 30, replace = TRUE),
                 Drug = sample(1:3, 30, replace = TRUE))
DF

#' ## Lists \
#' * Create a list using the pbc data set.
list_pbc <- list(pbc$id, pbc$time)

#' * Create other lists.
myList <- list(c(1:20),c("male", "female")) 
myList

#' Now add the names x to the first element and sex to the second element.
myList <- list(x = c(1:20), sex = c("male", "female")) 
myList
#' Another example.
mylist = list(names = c("Jack","Mary"), child.ages = c(4,7,9,10,11))
mylist
