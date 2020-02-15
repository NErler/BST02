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

#' Print the first 6 rows of the data set
head(pbc)

#' Select the first 5 rows and columns 1-6, 11, 12
dt <- pbc[1:5, c(1:6,11,12)]
dt

#' What is the average age?
mean(pbc$age)

#' What is the average bili?
mean(pbc$bili)

#' What is the average chol?
mean(pbc$chol, na.rm = TRUE)

#' What is the percentage of females?
percent(pbc$sex)

#' What is the average bili and chol?
mean(c(pbc$bili, pbc$chol), na.rm = TRUE)

#' Expression is given as a command
103473

#' In order to store information, the expression should assign the command
x <- 103473
x

#' More examples
#' We need to define `u` and `p` before we use it, otherwise it will not print anything 
# u
u <- 10
u
# p
p = 1
p

#' NOTE! `o == 3`

#' Case sensitive
#' mean(pbc$Age) will not run because there is a typo
names(pbc)
pbc$age

#' Check for missing data
is.na(p)
is.na(pbc)

#' If you are looking at the whole data set, you need to get a summary.
table(is.na(pbc))
is.na(pbc$age)
table(is.na(pbc$age)) 

#' Check for infinity data
is.infinite(pbc$age)
