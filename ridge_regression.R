# ridge_regression.R

#' Ridge Regression
#'
#' This function performs ridge regression using glmnet.
#' @param y The response variable.
#' @param X The matrix of predictor variables.
#' @param lambda The regularization parameter. If NULL, glmnet will calculate it.
#' @return A glmnet model object.
#' @export
ridge_regression <- function(y, X, lambda = NULL) {
  # Ensure that X is a dataframe
  X_frame <- as.data.frame(X)

  # Check if the variable is binary
  # Assume binary if it has exactly two unique values or it is a factor with two levels
  if (is.numeric(y) && length(unique(y)) == 2) {
    family_type <- "binomial"
  } else if (is.factor(y) && length(levels(y)) == 2) {
    family_type <- "binomial"
  } else {
    family_type <- "gaussian"
  }

  # Perform ridge regression (alpha = 0)
  model <- glmnet(x = X_frame, y = y, alpha = 0, lambda = lambda)

  return(model)
}

