#################
# Load packages #
#################

#install.packages("JM")
#install.packages("memisc")
library(JM)
library(memisc)

###############
# Basics in R #
###############

### expressions/assignments
head(pbc2.id)
head(pbc2.id$age)
mean(pbc2.id$age)

meanAge <- mean(pbc2.id$age)
meanAge

percDrug <- percent(pbc2.id$drug)
percDrug

### more examples
# u needs to be defined otherwise it will not print anything
10
u <- 10
u

# p needs to be defined otherwise it will not print anything
1
p = 1
p

# o == 3

### case sensitive
# maen(pbc2.id$age) will not run because there is a typo
names(pbc2.id)
pbc2.id$Age
pbc2.id$Drug

### missing data
is.na(p)
is.na(pbc2.id)

### if you are looking at the whole data set, you need to get a summary.
table(is.na(pbc2.id))
is.na(pbc2.id$age)
table(is.na(pbc2.id$age)) 

### infinity
is.infinite(pbc2.id$age)


