#################
# Load packages #
#################

#install.packages("JM")
#install.packages("memisc")
library(JM)
library(memisc)

require(JM)
require(memisc)

########################
# In Practice Examples #
########################

## present data
head(pbc2.id)
tail(pbc2.id)

## What is the average age?
mean(pbc2.id$age)
?mean

### What is the percentage of drug?
percent(pbc2.id$drug)
?percent
