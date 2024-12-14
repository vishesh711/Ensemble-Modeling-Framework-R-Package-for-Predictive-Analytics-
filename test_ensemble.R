library(testthat)
library(simpleEnsembleGroup6)  # Load your package
library(glmnet)
library(randomForest)

context("Testing ensemble_learning function")

test_that("ensemble_learning correctly applies majority voting for classification", {
  test_size <- 0.2
  data2 <- mtcars
  y <- mtcars$am
  y <- as.factor(mtcars$am) # Ensure binary response for classification
  X <- mtcars[, -which(names(mtcars) == "am")]
  model_functions <- list(lasso_regression, random_forest_model)
  results <- ensemble_learning(y, X, model_functions, method = "vote", test_size = 0.2)
  cat('\n\n\n\nVoting',results)
  expect_type(results, "character")
})

