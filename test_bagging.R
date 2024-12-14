library(testthat)
library(simpleEnsembleGroup6)  # Load your package
library(glmnet)
library(dplyr)
library(caret)

test_that("bagging regression function works correctly", {
  data(mtcars)
  y <- mtcars$mpg
  X <- as.matrix(mtcars[, -which(names(mtcars) == "mpg")])
  # Using a simple linear model function from your package for demonstration
  results <- bagging(X, y, 50,linear_logistic_regression)
  print(results)

  # Check if variable importance scores are non-negative
  expect_true(all(results$variable_importance >= 0))

})
