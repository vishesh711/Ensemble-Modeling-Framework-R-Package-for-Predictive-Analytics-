library(testthat)
library(randomForest)  # Ensure the randomForest package is loaded
library(simpleEnsembleGroup6)  # Replace with the actual name of your package

# Sample data for testing
data(iris)
data(mtcars)

# Prepare binary target for iris
iris$BinarySpecies <- ifelse(iris$Species == "setosa", 1, 0)
iris$BinarySpecies <- as.factor(iris$BinarySpecies)  # Ensure it is a factor for classification

# Test for classification
test_that("random_forest_model handles classification correctly", {
  model <- random_forest_model(iris$BinarySpecies, iris[, -which(names(iris) == "BinarySpecies")])
  expect_s3_class(model, "randomForest")
  expect_equal(model$type, "classification")
})

# Test for regression
test_that("random_forest_model handles regression correctly", {
  model <- random_forest_model(mtcars$mpg , mtcars[, -which(names(mtcars) == "mpg")])
  expect_s3_class(model, "randomForest")
  expect_equal(model$type, "regression")
})
