# Load required libraries
library(testthat)
library(simpleEnsembleGroup6)  # Replace with your actual package name if different
library(caret)

set.seed(123)

# Test that it returns the correct number of predictors
test_that("returns correct number of top predictors", {
  y <- mtcars$mpg
  X <- as.matrix(mtcars[, -which(names(mtcars) == "mpg")])
  top_predictors <- pre_screen_predictors_corr(X, y, top_k = 3)
  print("\ntop_predictors:\n")
  print(top_predictors)
  expect_length(top_predictors, 3)
})

# Test that it correctly identifies the top predictor based on highest correlation
test_that("identifies top predictor correctly", {
  y <- mtcars$mpg
  X <- as.matrix(mtcars[, -which(names(mtcars) == "mpg")])
  top_predictors <- pre_screen_predictors_corr(X, y, top_k = 1)
  print(top_predictors)
})
