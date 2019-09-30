#################
# Load packages #
#################

#install.packages("JM")
library(JM)

################################
# Most Frequently Used Objects #
################################

## Create matrices
weight_columns <- cbind(pbc2.id$age, pbc2.id$years)
weight_Rows <- rbind(pbc2.id$age, pbc2.id$years)
matrix(weight_columns, , 2)
matrix(weight_Rows, , 2, byrow = TRUE)

# TAKE CARE
Columns_com <- cbind(c(1:4), c(1:8))


## Create data frames

DF <- data.frame(Age = c(30, 20, 50),
                 Sex = c("male", "female", "female"),
                 Drug = c("yes", "yes", "no"))

DF <- data.frame(Age = runif(30, 1, 80),
                 Sex = sample(1:2, 30, replace = TRUE),
                 Drug = sample(1:3, 30, replace = TRUE))
head(DF)

## Create lists
myList <- list(x = c(1:20), sex = c("male", "female")) 
myList
