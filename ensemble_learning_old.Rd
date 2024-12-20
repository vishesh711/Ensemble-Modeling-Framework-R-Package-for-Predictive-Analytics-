% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ensemble_old.R
\name{ensemble_learning_old}
\alias{ensemble_learning_old}
\title{Ensemble Learning Function}
\usage{
ensemble_learning_old(
  X,
  y,
  model_functions,
  method = "average",
  test_size = 0.2
)
}
\arguments{
\item{model_functions}{A list of model functions that take data and response_column and return a fitted model.}

\item{method}{The method to combine predictions: "average" for regression and "vote" for classification.}

\item{data}{The data frame containing the predictors and the response.}

\item{response_column}{The name of the response variable.}
}
\value{
Returns combined predictions based on the specified ensemble method.
}
\description{
This function combines predictions from multiple models to improve the overall prediction.
It supports averaging for regression and majority voting for classification.
}
\examples{
\dontrun{
  results <- ensemble_learning(mtcars, "mpg", list(lm_model, glm_model), method = "average")
  print(results)
}
}
