#' ---
#' title: "Demo: Regression Basics"
#' subtitle: "NIHES BST02"
#' author: "Nicole Erler, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: 
#'   html_document:
#'     toc: true
#'     toc_float:
#'       collapsed: false
#' ---

#+  echo = FALSE
# This is not part of the demo. 
# It just allows the output to be wider (to make the html look nicer)
options(width = 105)

# ------------------------------------------------------------------------------

#' ## Linear Regression
#' Fit a linear regression model
mod <- lm(Infant.Mortality ~ Fertility + Agriculture + Education + Catholic,
          data = swiss)


#' ## Model Formula
#' We can extract the model formula using the `formula()` function:
formula(mod)

#' Add an interaction term:
fmla1 <- Infant.Mortality ~ Fertility * Agriculture + Education + Catholic
fmla1


#' Within `lm()` a `model.matrix` is generated from the model `formula` and the
#' `data`. We can do the same to see how a `formula` is translated into
#' variables:

X <- model.matrix(fmla1, data = swiss)
head(X)

#' To get all pairwise interaction terms:
fmla2 <- Infant.Mortality ~ (Fertility + Agriculture + Education + Catholic)^2
head(model.matrix(fmla2, data = swiss))


#' Remove the intercept:
fmla3 <- Infant.Mortality ~ 0 + Fertility + Agriculture + Education + Catholic
fmla4 <- Infant.Mortality ~ -1 + Fertility + Agriculture + Education + Catholic

head(model.matrix(fmla3, data = swiss))
head(model.matrix(fmla4, data = swiss))


#' Use all 2-way interactions except for one:
fmla5 <- Infant.Mortality ~ (Fertility + Agriculture + Education + 
                               Catholic)^2 - Agriculture:Education
head(model.matrix(fmla5, data = swiss))


#' ## The `subset` argument:
mod_sub <- lm(Infant.Mortality ~ Fertility + Agriculture + Education + Catholic,
              data = swiss, subset = Catholic > 5)

summary(mod_sub)

# ------------------------------------------------------------------------------
#' ## Logistic Regression
mod2 <- glm(case ~ age + education + spontaneous, data = infert,
            family = binomial())

mod2a <- glm(case ~ age + education + spontaneous, data = infert,
             family = binomial)
mod2b <- glm(case ~ age + education + spontaneous, data = infert,
             family = 'binomial')
mod2c <- glm(case ~ age + education + spontaneous, data = infert,
             family = binomial(link = 'probit'))

mod2
mod2a
mod2b
mod2c

#' We can also fit a linear regression model using glm:
mod_lm <- glm(Infant.Mortality ~ Fertility + Agriculture + Education + Catholic,
              data = swiss, family = gaussian())

mod_lm
mod


#' ## Formula: Categorical covariates
#' When we have categorical covariates (coded as `factor`) R automatically
#' creates dummy variables:
head(model.matrix(formula(mod2), data = infert))

#' `contrasts()` shows us the coding of the variable that is used:
contrasts(infert$education)


#' Note that for **ordered** factors R does not use dummy coding:
contrasts(as.ordered(infert$education))





#' ## Model results
#' Get the model summary
summary(mod)
summary(mod2)
#' Note: Coefficients are on the scale of the linear predictor, i.e., 
#' the log odds ratio for a logistic regression model.


#' Extract the regression coefficients
coef(mod)
coef(mod2)

#' Obtain the confidence interval
confint(mod)
confint(mod2)

#' The function `confint()` also has arguments `parm` and `level` that let us
#' specify for which parameters we want to get the confidence interval and 
#' the confidence level.
confint(mod, level = 0.9, parm = -1)

