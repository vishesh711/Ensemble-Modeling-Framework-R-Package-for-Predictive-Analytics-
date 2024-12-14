#' Elastic Net Regression
#'
#' This function performs elastic net regression using glmnet.
#'
#' @param y The response variable.
#' @param X The matrix of predictor variables.
#' @param alpha The elastic net mixing parameter (0 <= alpha <= 1).
#' @param lambda The regularization parameter. If NULL, glmnet will calculate it.
#'
#' @return A glmnet model object.
#' @export
elastic_net_regression <- function(y, X, alpha = 0, lambda = NULL) {
  # default alpha = 0, will act as rigde regression
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

  # Perform elastic net regression
  model <- glmnet(x = X_frame, y = y, alpha = alpha, lambda = lambda)

  return(model)
}
