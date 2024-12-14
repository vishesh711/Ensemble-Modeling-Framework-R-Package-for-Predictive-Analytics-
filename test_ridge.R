# Load required libraries
library(testthat)
library(simpleEnsembleGroup6)
library(glmnet)

# Test for ridge regression
test_that("Ridge regression fits a model using mtcars", {
  y <- mtcars$mpg
  X <- as.matrix(mtcars[, -which(names(mtcars) == "mpg")])

  model <- ridge_regression(y, X)

  expect_s3_class(model, "glmnet")
})


