#' ---
#' title: "Demo: Basics in R"
#' subtitle: "NIHES BST02"
#' author: "Eleni-Rosalina Andrinopoulou, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: html_document
#' ---
#' 

#' Load packages \
#' If you are using the package for the first time, you will have to first install it \
# install.packages("survival") 
# install.packages("memisc") 
library(survival)
library(memisc)

#' Load data set from package
pbc <- survival::pbc

#' Print the first 6 rows of the data set
head(pbc)

#' Select the first 5 rows and columns 1 until 6, 11, 12
pbc[1:5, c(1:6,11,12)]

#' What is the average `age`?
mean(pbc$age)

#' What is the average `serum bilirubin`?
mean(pbc$bili)

#' What is the average `serum cholesterol`?
mean(pbc$chol, na.rm = TRUE)

#' What is the percentage of `females`?
percent(pbc$sex)

#' What is the average `serum bilirubin` and `serum cholesterol`?
mean(pbc$chol, na.rm = TRUE)
mean(pbc$bili, na.rm = TRUE)

#' We obtained a lot of information in R but we did not save anything \
"Hello"

#' In order to store information, the expression should assign the command
hi <- "Hello"
hi

#' We need to define any object before we use it \
#' E.g. `number` and `x` are first defined 
# number
number <- 10
number
# x
x = 1
x

#' NOTE! `o == 3` \
#' \
#' Case sensitive \
#' `mean(pbc$Age)` will not run because there is a typo \
#' We need to check the names first
names(pbc)
pbc$age

#' Check for missing data
is.na(x)
head(is.na(pbc))

#' If you are looking at the whole data set, you need to get a summary.
table(is.na(pbc))
is.na(pbc$age)
table(is.na(pbc$age)) 

#' Check for infinity data
is.infinite(pbc$age)
