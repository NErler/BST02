#' ---
#' title: "Demo: Data Exploration"
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

#' What is the mean and standard deviation for `age`?
mean(pbc$age)
mean(pbc$age, na.rm = TRUE)
sd(pbc$age)

#' What is the mean and standard deviation for `time`?
mean(pbc$time)
mean(pbc$time, na.rm = TRUE)
sd(pbc$time)

#' What is the median and interquartile range for `age`?
median(pbc$age)
IQR(pbc$age)

#' What is the percentage of `placebo` and `treatment` patients? \
#' In order to use the percent() function you will need to load the memisc package
percent(pbc$trt)

#' What is the percentage of `females` and `males`?
percent(pbc$sex)

#' What is the mean and standard deviation for `age` in `males`?
pbc_males <- pbc[pbc$sex == "m", ]
mean(pbc_males$age)
sd(pbc_males$age)

#' What is the mean and standard deviation for `serum bilirubin`?
mean(pbc$bili)
sd(pbc$bili)


#' **Missing values and outliers** \
#' Check if there are missing values
is.na(pbc$chol)

#' Obtain complete cases for the variable `serum cholesterol`
DF <- pbc[complete.cases(pbc$chol), ]

#' Obtain dimensions
dim(pbc)
dim(DF)

#' Obtain the rows of the `pbc` data set where the `serum cholesterol` variable has missing values
pbc_chol_na <- pbc[is.na(pbc$chol) == TRUE, ]
head(pbc_chol_na)
pbc_chol_na <- pbc[is.na(pbc$chol) == TRUE, c("id", "time", "status",
                               "trt", "age", "sex", 
                               "bili", "chol")]
head(pbc_chol_na)

#' Obtain the dimensions of the `pbc` data set where the `serum cholesterol` variable has missing
dim(pbc_chol_na)

#' Outliers: e.g. let's assume that patients with `serum bilirun` values > 25 are outliers  \
#' Check whether there are outliers \
#' Obtain all rows from the data set which correspond to `serum bilirun` outliers
pbc_out_bili <- pbc[pbc$bili > 25, ]
head(pbc_out_bili)
