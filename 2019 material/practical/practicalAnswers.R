set.seed(2015+10)

## Practical 1.1

Sex <- sample(0:1, 50, replace = T)
Age <- sample(20:80, 50, replace = T)
Sex <- factor(Sex, levels = c(0:1), labels = c("female", "male"))
AgeCat <- as.numeric(Age > 50)
AgeCat <- factor(AgeCat, levels = c(0:1), labels = c("young", "old"))
Age <- (Age - mean(Age))/sd(Age)

## Practical 1.2

DF <- data.frame(Sex, Age, AgeCat)
DF <- data.frame("Gender" = Sex, "StandardizedAge" = Age, "DichotomousAge" = AgeCat)
dim(DF)

## Practical 1.2.1 (extra)

Treatment <- sample(1:2, 150, replace = T)
Weight <- sample(50:100, 150, replace = T)
Treatment <- factor(Treatment, levels = c(1:2), labels = c("no", "yes"))
Weight <- Weight * 1000
data.frame(Treatment, Weight)

## Practical 1.2.2 (extra)

let <- letters[1:9]
mat <- matrix(1:4 ,2, 2, byrow = TRUE)
sex <- sample(1:2, 50, replace = TRUE)
sex <- factor(sex, levels = 1:2, labels = c("males", "females"))
my_list <- list(let = let, mat = mat, sex = sex) 

## Practical 2.1

mean(DF$StandardizedAge)
sd(DF$StandardizedAge)
table(DF$Gender)
length(DF$Gender[DF$Gender == "female"])
length(DF$Gender[DF$Gender == "male"])
sum(DF$Gender == "female")
sum(DF$Gender == "male")

length(DF$DichotomousAge[DF$DichotomousAge == "young"])
length(DF$DichotomousAge[DF$DichotomousAge == "old"])
table(DF$DichotomousAge)
sum(DF$DichotomousAge == "young")
sum(DF$DichotomousAge == "old")

## Practical 2.2

tapply(DF$StandardizedAge, DF$Gender, mean)
table(DF$Gender, DF$DichotomousAge)
DF[DF$Gender == "male" & DF$DichotomousAge == "young",]
DF[DF$Gender == "female" | DF$DichotomousAge == "old",]

## Practical 2.2.1 (extra)

median(DF$StandardizedAge)
tapply(DF$StandardizedAge, DF$Gender, median)
DF[, 2]
DF[, "StandardizedAge"]

## Practical 3.1

Descriptives <- function(vec1, vec2) {
  resMin1 <- min(vec1)
  resMin2 <- min(vec2)
  resMed1 <- median(vec1)
  resMed2 <- median(vec2)
  resMax1 <- max(vec1)
  resMax2 <- max(vec2)
  resMean1 <- mean(vec1)
  resMean2 <- mean(vec2)
  ressd1 <- sd(vec1)
  ressd2 <- sd(vec2)
  resLen1 <- length(vec1)
  resLen2 <- length(vec2)
  res <- c(resMin1, resMin2, resMed1, resMed2, resMax1, resMax2, resMean1, resMean2, 
           ressd1, ressd2, resLen1, resLen2)
  mat <- matrix(res, 6 ,2 , byrow = T)
  rownames(mat) <- c("Min", "Median", "Max", "Mean", "Sd", "Length")
  mat
}

age <- sample(20:80, 100, replace = T)
weight <- sample(60:100, 200, replace = T)

Descriptives(age, weight)

#######
Descriptives2 <- function(v1, v2){
  
  sum1 <- c(min(v1), median(v1), max(v1), mean(v1), sd(v1), length(v1))
  sum2 <- c(min(v2), median(v2), max(v2), mean(v2), sd(v2), length(v2))
  res <- cbind(sum1, sum2)
  rownames(res) <- c('min', 'median', 'max', 'mean', 'sd', 'length')
  res
}

vec1 <- runif(100, 20, 80)
vec2 <- runif(200, 60, 100)

Descriptives2(vec1, vec2)


## Practical 3.1.1 (extra)

Summaries <- function(DF) {
  vec1 <- DF[, 1]
  vec2 <- DF[, 2]
  res1 <- tapply(vec2, vec1, mean)
  res2 <- tapply(vec2, vec1, median)
  res <- c(res1, res2)
  mat <- matrix(res, 2 ,2 , byrow = T)
  rownames(mat) <- c("Mean", "Median")
  colnames(mat) <- levels(vec1)
  mat
}

age <- sample(20:80, 100, replace = T)
sex <- sample(0:1, 100, replace = T)
sex <- factor(sex, levels = c(0:1), labels = c("female", "male"))
data.fr <- data.frame(sex, age)

Summaries(data.fr)

#######
Summaries2 <- function(DF) {
  vec1 <- DF[, 1]
  vec2 <- DF[, 2]
  lev <- levels(vec1)
  res1 <- mean(vec2[vec1 == lev[1]])
  res2 <- mean(vec2[vec1 == lev[2]])
  res3 <- median(vec2[vec1 == lev[1]])
  res4 <- median(vec2[vec1 == lev[2]])
  res <- c(res1, res2, res3, res4)
  mat <- matrix(res, 2 ,2 , byrow = T)
  rownames(mat) <- c("Mean", "Median")
  colnames(mat) <- c(lev[1], lev[2])
  mat
}

Summaries2(data.fr)

#######
Summaries3 <- function(df){
  means <- tapply(df[,1], df[, 2], FUN = mean)
  medians <-   tapply(df[,1], df[, 2], FUN = median)
  rbind(means, medians)
}

df <- data.frame(vec1 = runif(100, 20, 80), 
                 vec2 = factor(sample(1:2, 100, replace = TRUE),
                           levels = c(1,2), labels=c('male', 'female'))
)

Summaries3(df)


## Practical 4.1

library(foreign)

dat <- read.spss("Cancer.sav",
                 to.data.frame = TRUE)

t.test(dat$AGE[dat$TRT == 0], dat$AGE[dat$TRT == 1])
res <- t.test(dat$AGE[dat$TRT == 0], dat$AGE[dat$TRT == 1])
res$p.value #res[[3]]
res$conf.int #res[[4]]

## Practical 4.2

mean1 <- res$estimate[1]  #res[[5]][1]
mean2 <- res$estimate[2]  #res[[5]][2]
diffres <- res$estimate[1] - res$estimate[2]
lowCI <- res$conf.int[1]
upCI <- res$conf.int[2]
pVal <- res$p.value

Restest <- data.frame(mean1 = mean1, mean2 = mean2, diffres = diffres, lowCI = lowCI, upCI = upCI, pVal = pVal)

## Practical 4.3

dat$WEIGHINcat <- as.numeric(dat$WEIGHIN >= mean(dat$WEIGHIN))

res1 <- t.test(dat$AGE[dat$TRT == 0], dat$AGE[dat$TRT == 1])
res2 <- t.test(dat$AGE[dat$WEIGHINcat == 0], dat$AGE[dat$WEIGHINcat == 1])

results <-c(res1$p.value, res2$p.value)

bonf.corr_alpha <- 0.05/length(results)

if (results[1] >= bonf.corr_alpha) {
  print("H0 is not rejected")
} else {
  print("H0 is rejected")
}

if (results[2] >= bonf.corr_alpha) {
  print("H0 is not rejected")
} else {
  print("H0 is rejected")
}

## Practical 4.4

fm1 <- lm(WEIGHIN ~ TRT, data = dat)
fm2 <- lm(WEIGHIN ~ TRT + STAGE, data = dat)
anova(fm1, fm2)
fm3 <- lm(WEIGHIN ~ TRT + STAGE + AGE, data = dat)
fm4 <- lm(WEIGHIN ~ TRT + STAGE*AGE, data = dat)

## Practical 4.5

Pred <- function(treatment, stage, age){
  vec <- c(1, treatment, stage, age, stage*age)
  vec%*%fm4$coefficients 
}

Pred(1, 2, 77)

library(lattice)
xyplot(WEIGHIN ~ AGE | TRT, data = dat, main = "weight vs age", xlab = "age", ylab = "weight")

TRT.factor <- factor(dat$TRT, levels = c(0:1), labels = c("no", "yes"))
xyplot(WEIGHIN ~ AGE | TRT.factor, data = dat, main = "weight vs age", xlab = "age", ylab = "weight")

## Practical 4.5.1 (extra)

sex <- sample(1:2, 100, replace = TRUE)
tr <- sample(1:4, 100, replace = TRUE)
score <- rnorm(100, 20, 5)

boxplot(score ~ sex)
boxplot(score ~ tr)

sex <- sample(1:2, 20, replace = TRUE)
tr <- sample(1:4, 20, replace = TRUE)
score <- rnorm(20, 20, 5)

boxplot(score ~ sex)
boxplot(score ~ tr)

## Practical 4.5.2 (extra)

cor(dat$WEIGHIN, dat$AGE)
cor.test(dat$WEIGHIN, dat$AGE)
plot(dat$WEIGHIN, dat$AGE)
boxplot(dat$WEIGHIN ~ dat$STAGE)
boxplot(dat$WEIGHIN ~ dat$STAGE, col = c(2,3,4,5,6))

## Practical 5.1

uniRegr <- function(DF, covariates){
 res <- matrix(NA, length(covariates), 3)
  for (i in 1:length(covariates)){
    form <- as.formula(paste("WEIGHIN ~", covariates[i]))
    fm <- lm(form, data = DF)
    res[i, ] <- summary(fm)$coefficients[2, c(1,2,4)]
  }
 colnames(res) <- c("estimate", "std error", "p-value")
 res
}


results_regr <- uniRegr(dat, c("AGE", "STAGE", "TRT"))
rownames(results_regr) <- c("AGE", "STAGE", "TRT")
results_regr

#form <- as.formula(paste("WEIGHIN ~", "TRT"))
#fm <- lm(form, data = dat)

## Practical 5.1.1 (extra)

uniLogRegr <- function(DF, covariates){
  res <- matrix(NA, length(covariates), 3)
  for (i in 1:length(covariates)){
    form <- as.formula(paste("TRT ~", covariates[i]))
    fm <- glm(form, data = DF, family = binomial)
    res[i, ] <- summary(fm)$coefficients[2, c(1,2,4)]
  }
  colnames(res) <- c("estimate", "std error", "p-value")
  res
}


results_log_regr <- uniLogRegr(dat, c("AGE", "STAGE", "WEIGHIN"))
rownames(results_log_regr) <- c("AGE", "STAGE", "WEIGHIN")
results_log_regr

#form <- as.formula(paste("TRT ~", "WEIGHIN"))
#fm <- glm(form, data = dat, family = binomial)

