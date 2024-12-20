% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bagging.R
\name{bagging}
\alias{bagging}
\title{Run Bagging}
\usage{
bagging(
  X,
  y,
  n_bootstrap = 100,
  model_func,
  sample_size = nrow(X),
  n_features_subset = NULL
)
}
\arguments{
\item{X}{The matrix of predictors.}

\item{y}{The vector of the response variable.}

\item{n_bootstrap}{The number of bootstrap samples to generate (default is 100).}

\item{model_func}{The function to fit the model, which takes y and X as inputs and returns a fitted model object.}

\item{sample_size}{The size of each bootstrap sample (default is the number of rows in X).}

\item{n_features_subset}{The number of features to randomly select for each bootstrap sample (default is the square root of the number of predictors).}
}
\value{
A list containing predictions and variable importance scores.
}
\description{
This function performs bagging (bootstrap aggregating) on the input data using the specified model function.
}
\details{
This function performs bagging by generating bootstrap samples and fitting models on each sample with randomly selected features.
It then makes predictions using the fitted models and averages them to obtain the final predictions.
Additionally, it calculates the variable importance scores based on the frequency of feature selection during bootstrapping.
}
