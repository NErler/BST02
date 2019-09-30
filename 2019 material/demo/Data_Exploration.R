#################
# Load packages #
#################

#install.packages("JM")
library(JM)

####################
# Data Exploration #
####################

## What is the mean and sd for age?
mean(pbc2$age)
mean(pbc2$age, na.rm = TRUE)
sd(pbc2$age)

## What is the mean and sd for follow-up years?
mean(pbc2$years)
mean(pbc2$years, na.rm = TRUE)
sd(pbc2$years)

## What is the mean and sd for age in males?
tapply(pbc2.id$age, pbc2.id$sex, mean)

## What is the mean follow-up year per patient?
tapply(pbc2$year, pbc2$id, mean)

## What is the mean age of all patients atthe end of the study?
mean(tapply(pbc2$age, pbc2$id, tail, n = 1))

## What is the mean age of all patients at baseline?
mean(tapply(pbc2$age, pbc2$id, head, n = 1))

