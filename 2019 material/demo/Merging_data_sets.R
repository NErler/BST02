#################
# Load packages #
#################

#install.packages("JM")
library(JM)

#####################
# Merging data sets #
#####################

## Example 1

dat1 = data.frame(Id = c(1:6), drug = c(rep("placebo", 3), rep("treatment", 3)))
dat1
dat2 = data.frame(Id = c(1:6), Country = c(rep("Netherlands", 2), rep("Belgium", 4)))
merge(dat1, dat2)

dat1 = data.frame(Id = c(1:6), time = c(0, 0.2, 0.4, 0, 0.2, 1), 
                  drug = c(rep("placebo", 3), rep("treatment", 3)))
dat2 = data.frame(Id = c(1:6), time = c(0, 0.2, 0.4, 0, 0.2, 1), 
                  Country = c(rep("Netherlands", 2), rep("Belgium", 4)))
merge(dat1, dat2)
merge(dat1, dat2, by = c("Id", "time"))

## Example 2

dat1 = data.frame(Id = c(1:6), drug = c(rep("placebo", 3), rep("treatment", 3)))
dat2 = data.frame(Id = c(2, 4, 6), Country = c(rep("Netherlands", 2), rep("Belgium", 1)))
merge(dat1, dat2)

merge(dat1, dat2, all = TRUE)
merge(dat1, dat2, all = FALSE)
merge(dat1, dat2, all.x = TRUE)
merge(dat1, dat2, all.y = TRUE)

## Example 3

dat1 = data.frame(Id = c(1,1,1,2,2,2), score = c(sample(1:20, 6)))
dat2 = data.frame(Id = c(1,2), Country = c(rep("Netherlands", 1), rep("Belgium", 1)))
merge(dat1, dat2)

merge(dat1, dat2, by = "Id")

## Example 4

dat1 = data.frame(Id = c(1,1,1,2,2,2), score = c(sample(1:20, 6)))
dat2 = data.frame(IDs = c(1,2), Country = c(rep("Netherlands", 1), rep("Belgium", 1)))
merge(dat1, dat2)

merge(dat1, dat2, by.x = c("Id"), by.y = c("IDs"))

## Example 5

dat1 = data.frame(Id = c(1:6), drug = c(rep("placebo", 3), 
                    rep("treatment", 3)), x1 = c(1:6), x2 = c(6:1))
dat2 = data.frame(Id = c(2, 4, 6), Country = c(rep("Netherlands", 2), 
                    rep("Belgium", 1)), x1 = sample(1:10, 3), x2 = sample(1:10, 3))
merge(dat1, dat2)

merge(dat1, dat2, by.x = c("Id"), by.y = c("Id"))
merge(dat1, dat2, by = c("Id"))
