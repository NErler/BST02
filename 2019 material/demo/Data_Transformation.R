#################
# Load packages #
#################

#install.packages("JM")
library(JM)

#####################
# Data Manipulation #
#####################

## Round continuous variables
pbc2.id$years <- round(pbc2.id$years, digits = 2)
pbc2.id$age <- round(pbc2.id$age, digits = 2)
head(pbc2.id)


## Set age40higher as factor
factor(pbc2.id$age40higher, levels = c(0:1),
       labels = c("low","high"))

# why do I not get the new dichotomous variable?
pbc2.id$age40higher <- pbc2.id$age > 40
pbc2.id$age40higher <- as.numeric(pbc2.id$age40higher)
head(pbc2.id)

pbc2.id$age40higher <- factor(pbc2.id$age40higher, levels = c(0:1),
                              labels = c("low","high"))
head(pbc2.id)

## Transform variables
pbc2.id$ageST <- (pbc2.id$age-mean(pbc2.id$age))/(sd(pbc2.id$age))


## Wide/long format
head(pbc2)

vec <- table(pbc2$id)
vec2 <- sequence(vec)

pbc2$visit <- vec2

library(reshape2)
pbc2Wide <- reshape(pbc2, idvar = c("id"), 
                    drop = c("years", "status", "drug", "year", "hepatomegaly", 
                             "serChol", "spiders", "albumin", "alkaline", 
                             "SGOT", "platelets", "prothrombin", "age", "sex", 
                             "ascites", "edema", "histologic", "status2"),
                    timevar = "visit", direction = "wide")


head(pbc2Wide)

pbc2Long <- reshape(pbc2Wide, idvar = c("id"), timevar = "visit", 
                    varying = list(names(pbc2Wide)[2:17]),
                    v.names = "serBilir", direction = "long", times = 1:16)
head(pbc2Long)
pbc2Long <- pbc2Long[order(pbc2Long$id),]
head(pbc2Long)


## Missings
?mean
