# Load required libraries
library(testthat)
library(simpleEnsembleGroup6)
library(glmnet)

# Test for elastic net regression
test_that("Elastic net regression fits a model using mtcars", {
  y <- mtcars$mpg
  X <- as.matrix(mtcars[, -which(names(mtcars) == "mpg")])

  model <- elastic_net_regression(y, X, alpha = 0.5)

  expect_s3_class(model, "glmnet")
})
