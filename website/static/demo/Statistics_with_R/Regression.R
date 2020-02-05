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

#' Get the model summary
summary(mod)

#' Extract the regression coefficients
coef(mod)

#' Obtain the confidence interval
confint(mod)

#' The function `confint()` also has arguments `parm` and `level` that let us
#' specify for which parameters we want to get the confidence interval and 
#' the confidence level.
confint(mod, level = 0.9, parm = -1)



# ------------------------------------------------------------------------------
#' ## Logistic Regression
mod2 <- glm(case ~ age + education + spontaneous, data = infert, family = binomial())
summary(mod2)
#' Note: the coefficients are on the log odds ratio scale.

#' The functions `coef()` and `confint()` also work on GLMs.
