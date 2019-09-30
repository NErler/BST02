#################
# Load packages #
#################

#install.packages("JM")
library(JM)

##############
# Statistics #
##############

# Statistical Tests

## t-test
t.test(pbc2.id$serBilir[pbc2.id$drug == "D-penicil"], 
       pbc2.id$serBilir[pbc2.id$drug == "placebo"])

t.test(pbc2.id$serBilir ~ pbc2.id$drug)

## anova
aov(pbc2.id$age ~ pbc2.id$status)
summary(aov(pbc2.id$age ~ pbc2.id$status))

aov(pbc2.id$age ~ pbc2.id$status + pbc2.id$sex)
summary(aov(pbc2.id$age ~ pbc2.id$status + pbc2.id$sex))

## wilcoxon
wilcox.test(pbc2.id$serBilir[pbc2.id$drug == "D-penicil"], 
            pbc2.id$serBilir[pbc2.id$drug == "placebo"])

wilcox.test(pbc2.id$serBilir ~ pbc2.id$drug)
  
## kruskal test
kruskal.test(list(pbc2.id$age[pbc2.id$status == "alive"], 
                  pbc2.id$age[pbc2.id$status == "transplanted"], 
                  pbc2.id$age[pbc2.id$status == "dead"]))

kruskal.test(pbc2.id$age ~ pbc2.id$status)


mean(pbc2.id$age[pbc2.id$status == "alive"])
median(pbc2.id$age[pbc2.id$status == "alive"])
mean(pbc2.id$age[pbc2.id$status == "transplanted"])
median(pbc2.id$age[pbc2.id$status == "transplanted"])
mean(pbc2.id$age[pbc2.id$status == "dead"])
median(pbc2.id$age[pbc2.id$status == "dead"])

## chi-squared test
tbl <- table(pbc2.id$status, pbc2.id$drug) 
chisq.test(tbl)

## fisher test
fisher.test(tbl)

## correlations
cor(pbc2.id$age, pbc2.id$serBilir)

plot(pbc2.id$age, pbc2.id$serBilir)

cor(pbc2.id$age, pbc2.id$serBilir, method = "spearman")

cor.test(pbc2.id$age, pbc2.id$serBilir)
cor.test(pbc2.id$age, pbc2.id$serBilir, method = "spearman")

# Outliers

## Create some

ind <- sample(pbc2.id$id, 5)
pbc2.id$age[pbc2.id$id %in% ind] <- 
  pbc2.id$age[pbc2.id$id %in% ind] + 70

boxplot(pbc2.id$age)


dim(pbc2.id[ pbc2.id$age <= 100, ])

head(pbc2.id[pbc2.id$age <= 100, ])

## exclude them
pbc2.id <- pbc2.id[pbc2.id$age <= 100, ]

dim(pbc2.id)

# Regression Models

## linear regression
fm1 <- lm(serBilir ~ age + sex + drug, data = pbc2.id)
summary(fm1)
coef(fm1)
head(fitted(fm1))
head(residuals(fm1))
AIC(fm1)
confint(fm1)

# plotting the fitted model
plot(fm1)

par(mfrow = c(2, 2))
plot(fm1)

# exclude intercept
fm1b <- lm(serBilir ~ -1 + age + sex + drug, data = pbc2.id)
summary(fm1b)

# interaction effects
fm2 <- lm(serBilir ~ age + sex + drug + age:sex, data = pbc2.id)

fm2 <- lm(serBilir ~ age*sex, data = pbc2.id)
fm2 <- lm(serBilir ~ age + sex + age:sex, data = pbc2.id)

summary(fm2)
fm2b <- lm(serBilir ~ age*drug + age*sex, data = pbc2.id)
summary(fm2b)

# polynomial effects
fm3 <- lm(serBilir ~ age + I(age^2) + I(age^3), data = pbc2.id)
summary(fm3)

# include smooth terms
library(splines)
fm3b <- lm(serBilir ~ ns(age, df = 3), data = pbc2.id)
summary(fm3b)

# compare models
fm4 <- lm(serBilir ~ age, pbc2.id)
fm5 <- lm(serBilir ~ age*sex, pbc2.id)
anova(fm4, fm5)

## logistic regression
gl1 <- glm(drug ~ age, data = pbc2.id, family = binomial)

gl2 <- glm(drug ~ age + sex, data = pbc2.id, family = binomial)

summary(gl1)
summary(gl2)
confint(gl1)
anova(gl1, gl2)
anova(gl1, gl2, test ="Chisq") 


exp(cbind(coef(gl2), confint(gl2))) # odds ratio
