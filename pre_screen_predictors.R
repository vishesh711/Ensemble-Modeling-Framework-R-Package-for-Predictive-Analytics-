#' Pre-screen Predictors Based on Correlation
#'
#' This function screens predictors based on the absolute value of their correlation with the response variable.
#' It is useful for preliminary feature selection where the goal is to identify predictors that have the strongest
#' linear relationships with the response. The function calculates the Pearson correlation coefficient for each predictor
#' with the response and returns the names of the top_k predictors with the highest absolute correlations.
#'
#' @param data A data frame containing both the predictors and the response variable.
#' @param response_column A string specifying the name of the response variable column in the data frame.
#' @param top_k An integer specifying the number of top predictors to return based on highest correlation.
#'              Default is 10.
#'
#' @return A character vector of the names of the top_k predictors with the highest absolute correlations to the response variable.
#' @examples
#' # Assume 'df' is a data frame with several predictors and a response variable named 'response'
#' top_predictors <- pre_screen_predictors_corr(df, "response", top_k = 5)
#'
#' @export
pre_screen_predictors_corr <- function(X,y,top_k = 10) {
  data <- pre_process(X,y)

  print(data)

  # Print the 'y' variable
  print(y)

  # Calculate correlation
  correlations <- sapply(data[, -which(names(data) == "y")], function(x) {
    abs(cor(x, y, use = "complete.obs"))  # Using absolute correlation
  })

  # Print the correlations
  print(correlations)


  # Sort and select top K features
  top_predictors <- names(sort(correlations, decreasing = TRUE))[1:top_k]

  return(top_predictors)
}
