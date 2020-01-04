#' ---
#' title: "Demo: Data Exploration"
#' subtitle: "NIHES BST02"
#' author: "Eleni-Rosalina Andrinopoulou, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: html_document
#' ---
#' 

#' Load packages
#' If you are using the package for the first time, you will have to first install it:
# install.packages("survival") 
# install.packages("memisc")
library(survival)
library(memisc)

#' What is the mean and sd for age?
mean(pbc$age)
mean(pbc$age, na.rm = TRUE)
sd(pbc$age)

#' What is the mean and sd for time?
mean(pbc$time)
mean(pbc$time, na.rm = TRUE)
sd(pbc$time)

#' What is the median and interquartile range for age?
median(pbc$age)
IQR(pbc$age)

#' What is the percentage of placebo patients?
percent(pbc$trt)

#' What is the percentage of females?
percent(pbc$sex)

#' What is the mean and sd for age in males?
pbc_males <- pbc[pbc$sex == "m", ]
mean(pbc_males$age)
sd(pbc_males$age)

#' What is the mean and sd for serum bilirubin?
mean(pbc$bili)
sd(pbc$bili)