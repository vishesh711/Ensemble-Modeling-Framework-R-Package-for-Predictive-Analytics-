# Load required libraries
library(testthat)
library(simpleEnsembleGroup6)  # Load your package
library(glmnet)
data(mtcars)
data(iris)

# Test for linear regression using mtcars
test_that("Linear regression performs correctly on mtcars", {
  y <- mtcars$mpg
  X <- as.matrix(mtcars[, -which(names(mtcars) == "mpg")])

  model <- linear_logistic_regression(y, X, binary = FALSE)

  expect_equal(class(model), "lm")
  expect_true(length(coef(model)) > 0)
  expect_true(sum(is.na(coef(model))) == 0)
  expect_true(sum(residuals(model)^2) < sum((y - mean(y))^2))  # Check that model performs better than mean baseline
})


# Test for logistic regression using iris
test_that("Logistic regression performs correctly on iris", {
  y <- ifelse(iris$Species == "setosa", 1, 0)
  X <- as.matrix(iris[, 1:4])

  model <- linear_logistic_regression(y, X, binary = TRUE)

  print(model)

  expect_true(inherits(model, "glm"))
  expect_equal(model$family$family, "binomial")
  expect_true(length(coef(model)) > 0)
  expect_true(sum(is.na(coef(model))) == 0)
})

