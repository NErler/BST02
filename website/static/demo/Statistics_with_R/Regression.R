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
#' ### Fitting the model
#' Fit a linear regression model
mod <- lm(Infant.Mortality ~ Fertility + Agriculture + Education + Catholic,
          data = swiss)

#' ### Model results
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


#' ### Model evaluation
#' To evaluate how well the model fits the data we can check the diagnostic 
#' plots that are obtained when plotting the model:
#+ fig.width  = 8, fig.height = 6
par(mfrow = c(2, 2), mar = c(4, 4.2, 2, 1.3)) # graphical settings
plot(mod)

#' We can re-create some of these plots ourselves.

#' Residuals and fitted values can be obtained from a linear regression model in two ways:
mod$residuals
residuals(mod)

mod$fitted.values
fitted(mod) # also: fitted.values(mod)

scatter.smooth(mod$fitted.values, mod$residuals, lpars = list(col = 'red'))
abline(h = 0, lty = 2, col = 'grey')

#' #### QQ-plot
#' To create a normal QQ-plot we plot the quantiles of the standardized 
#' residuals against the quantiles of a normal distribution:
qqnorm(rstandard(mod))
abline(a = 0, b = 1, lty = 1, col = 'grey')




# ------------------------------------------------------------------------------
#' ## Logistic Regression
mod2 <- glm(case ~ age + education + spontaneous, data = infert, family = binomial())
summary(mod2)
#' Note: the coefficients are on the log odds ratio scale.

#' The functions `coef()` and `confint()` also work on GLMs.
#' 
#' 

#' ### Changing parts of the model
#' To re-fit the model with a small change, the function `update()` is useful:
mod2b <- update(mod2, formula = . ~ . - education)

#' In `update()` we specify the model we want to update and only those arguments
#' that need to be changed. In our case, the model formula.
#' Using `.` we can specify to keep parts of the formula the same.
#' This allows us to "subtract" `education` from the original formula.

#' `update()` also works for other types of objects (not just regression models):
formula(mod2)
update(formula(mod2), . ~ . - education)


#' ### Comparing Models
#' To check if `education` is needed in the model, we can use a likelihood ratio
#' test to compare the models with and without `education`.
#' This is implemented in the function `anova()`.
anova(mod2, mod2b, test = "LRT")

#' To compare non-nested models (where one model is not a special case of the
#' other model) we can use the `AIC()` or `BIC()`:

mod3 <- update(mod2b, formula = . ~ . - age + induced)

AIC(mod3, mod2b)
