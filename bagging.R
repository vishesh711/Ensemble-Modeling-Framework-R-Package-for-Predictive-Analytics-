#' Run Bagging
#'
#' This function performs bagging (bootstrap aggregating) on the input data using the specified model function.
#'
#' @param X The matrix of predictors.
#' @param y The vector of the response variable.
#' @param n_bootstrap The number of bootstrap samples to generate (default is 100).
#' @param model_func The function to fit the model, which takes y and X as inputs and returns a fitted model object.
#' @param sample_size The size of each bootstrap sample (default is the number of rows in X).
#' @param n_features_subset The number of features to randomly select for each bootstrap sample (default is the square root of the number of predictors).
#' @return A list containing predictions and variable importance scores.
#'
#' @details
#' This function performs bagging by generating bootstrap samples and fitting models on each sample with randomly selected features.
#' It then makes predictions using the fitted models and averages them to obtain the final predictions.
#' Additionally, it calculates the variable importance scores based on the frequency of feature selection during bootstrapping.
#'
#' @export
bagging <- function(X, y, n_bootstrap = 100, model_func,
                        sample_size = nrow(X), n_features_subset = NULL) {
  # Default sample size is the number of rows in X

  # Default number of features is the square root of the number of predictors
  if (is.null(n_features_subset)) {
    n_features_subset <- ceiling(sqrt(ncol(X)))
  }

  bootstrap_samples <- list()
  # Initialize feature counter
  feature_counter <- vector("numeric", length = ncol(X))
  names(feature_counter) <- colnames(X)
  feature_counter <- as.list(feature_counter)

  feature_indices_list <- list()

  # Create bootstrap samples and select random features
  set.seed(42)

  print(n_bootstrap)
  for (i in 1:n_bootstrap) {
    # Bootstrap sample indices
    sample_indices <- sample(nrow(X), sample_size, replace = TRUE)
    # Randomly select feature indices
    feature_indices <- sample(ncol(X), n_features_subset, replace = FALSE)
    # Store feature indices for each model
    feature_indices_list[[i]] <- feature_indices
    # Update feature counter
    for (idx in feature_indices) {
      feature_counter[[colnames(X)[idx]]] <- feature_counter[[colnames(X)[idx]]] + 1
    }
    # Store the sampled data (X and y)
    bootstrap_samples[[i]] <- list(X = X[sample_indices, feature_indices, drop = FALSE], y = y[sample_indices])
  }

  print(bootstrap_samples[[i]]$y)
  print('\n\n')
  print(bootstrap_samples[[i]]$X)

  # Train models on each sample with selected features
  models <- lapply(seq_along(bootstrap_samples), function(i) {
    model_func(bootstrap_samples[[i]]$y, bootstrap_samples[[i]]$X)
  })

  # Assuming new_X is defined and prepared the same way as X
  new_X <- X  # Placeholder for actual new data; replace with real new_X when using the function

  # Make predictions and average them
  predictions <- matrix(NA, nrow = nrow(new_X), ncol = n_bootstrap)

  # Make predictions and average them
  for (i in seq_along(models)) {
    feature_indices <- feature_indices_list[[i]]


    if ("glmnet" %in% class(models[[i]])) {

      #print(predict(models[[i]], newx = as.matrix(new_X[, feature_indices, drop = FALSE])))
      predictions[, i] <- predict(models[[i]], newx = as.matrix(as.data.frame(new_X[, feature_indices, drop = FALSE])))
    }else{
      predictions[, i] <- predict(models[[i]], newdata = as.data.frame(new_X[, feature_indices, drop = FALSE]))
    }
  }

  # Average predictions
  final_predictions <- rowMeans(predictions, na.rm = TRUE)

  return(list(predictions = final_predictions, variable_importance = unlist(feature_counter)))
}
