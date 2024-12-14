#' Random Forest Model
#'
#' This function fits a Random Forest model to the data for either classification or regression.
#' @param X The matrix or data frame of predictors.
#' @param y The vector of the response variable.
#' @return A randomForest model object.
#' #' @details
#' This function fits a Random Forest model to the provided data. Random Forest is an ensemble learning
#' method that constructs a multitude of decision trees during training and outputs the mode (classification)
#' or mean prediction (regression) of the individual trees. It can be used for both classification and
#' regression tasks.
#'
#' @examples
#' # Fit a Random Forest model for regression
#' data(mtcars)
#' X <- mtcars[, -which(names(mtcars) == "mpg")]  # Predictors
#' y <- mtcars$mpg  # Response variable
#' model <- random_forest(X, y)
#' @export
random_forest_model <- function(y, X) {

  # Fit Random Forest model
  model <- randomForest(X, y)

  # Return the fitted model
  return(model)
}

