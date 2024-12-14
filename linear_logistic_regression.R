#' Linear or Logistic Regression
#'
#' This function performs linear regression if the response variable is continuous
#' and logistic regression if the response variable is binary.
#'
#' @param y The response variable vector.
#' @param X The matrix of predictor variables.
#' @param binary A boolean that indicates whether the response variable is binary.
#'
#' @return The model object.
#' @export
linear_logistic_regression <- function(y, X) {

  # Determine response type
  if (is.numeric(y) && length(unique(y)) == 2) {
    # Convert to factor for classification
    y <- as.factor(y)
    response_type <- "classification"
  } else if (is.factor(y) && length(levels(y)) == 2) {
    response_type <- "classification"
  } else {
    response_type <- "regression"
  }

  # converting data from matrix to datframe
  data = as.data.frame(cbind(y, X))

  if (response_type == "regression") {
    # Linear regression
    model <- lm(y ~ ., data = data)
  }
  else {
    # Logistic regression
    model <- glm(y ~ ., family = binomial(link = 'logit'), data = data)
  }

  return(model)
}
