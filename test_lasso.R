# Load required libraries
library(testthat)
library(simpleEnsembleGroup6)
library(glmnet)

# Test for lasso regression
test_that("Lasso regression fits a model using mtcars", {
  y <- mtcars$mpg
  X <- as.matrix(mtcars[, -which(names(mtcars) == "mpg")])

  model <- lasso_regression(y, X, lambda=0.5)

  expect_s3_class(model, "glmnet")
})
