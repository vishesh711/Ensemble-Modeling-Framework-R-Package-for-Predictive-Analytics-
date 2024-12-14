#' Ensemble Learning Function
#'
#' This function combines predictions from multiple models to improve the overall prediction.
#' It supports averaging for regression and majority voting for classification.
#'
#' @param data The data frame containing the predictors and the response.
#' @param response_column The name of the response variable.
#' @param model_functions A list of model functions that take data and response_column and return a fitted model.
#' @param method The method to combine predictions: "average" for regression and "vote" for classification.
#'
#' @return Returns combined predictions based on the specified ensemble method.
#' @examples
#' \dontrun{
#'   results <- ensemble_learning(mtcars, "mpg", list(lm_model, glm_model), method = "average")
#'   print(results)
#' }
#' @export

ensemble_learning_old <- function(X, y, model_functions, method = "average", test_size = 0.2) {

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

  data <- cbind(X, y)

  # Determine the number of rows for the test set
  n_test <- round(nrow(data) * test_size)

  # Randomly sample row indices for the test set
  test_indices <- sample(nrow(data), n_test)

  # Split the data into train and test sets
  train_data <- data[-test_indices, ]
  test_data <- data[test_indices, ]

  # Extract features and target from train and test sets
  X_train <- train_data[, -ncol(train_data)]
  Y_train <- train_data[, ncol(train_data)]
  X_test <- test_data[, -ncol(test_data)]
  Y_test <- test_data[, ncol(test_data)]

  # Storage for predictions from each model
  predictions_list <- list()

  # Apply each model function to the data
  for (model_function in model_functions) {
    model <- model_function(Y_train, X_train)
    predictions <- predict(model, X_test)
    predictions_list[[length(predictions_list) + 1]] <- predictions
  }

  # Combine predictions based on the specified method
  if (method == "average") {
    # Average predictions for regression
    final_predictions <- Reduce("+", predictions_list) / length(model_functions)
  } else if (method == "vote") {
    # Majority vote for classification
    final_predictions <- apply(do.call(cbind, predictions_list), 1, function(x) names(which.max(table(x))))
  }

  return(final_predictions)
}
