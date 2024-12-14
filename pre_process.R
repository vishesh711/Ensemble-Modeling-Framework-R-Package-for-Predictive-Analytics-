#' Pre-process Data
#'
#' This function preprocesses the data by handling missing values, converting binary variables to 0 and 1,
#' converting categorical variables to factors, and performing one-hot encoding.
#'
#' @param X The matrix of predictors.
#' @param y The vector of the response variable.
#' @return A pre-processed dataframe ready for modeling.
#'
#' @details
#' 1. Combine predictors (X) and the response variable (y) into a single dataframe.
#' 2. Remove rows with missing values (NA) to ensure complete data for analysis.
#' 3. Identify the types of columns in the dataframe:
#'    - Numerical columns contain numeric values.
#'    - Binary columns have only two unique values.
#'    - Categorical columns contain character values with more than two unique values.
#' 4. Convert binary columns to 0 and 1:
#'    - Iterate through each binary column.
#'    - Assign 0 to the smaller unique value and 1 to the larger unique value.
#' 5. Convert categorical columns to factors:
#'    - Iterate through each categorical column and convert its values to factors.
#' 6. Convert all remaining character columns to factors to ensure consistency.
#' 7. Perform one-hot encoding:
#'    - Use dummyVars function to create dummy variables for each categorical variable.
#'    - Transform categorical variables into a set of binary columns.
#' 8. Return the pre-processed dataframe ready for modeling.
#'
#' @export
pre_process <- function(X,y){
  df <- cbind(X,y)
  df <- na.omit(df)

  print(str(df))

  # Identify numeric, binary, and discrete columns
  numerical_cols <- names(df)[sapply(df, is.numeric)]
  binary_cols <- names(df)[(sapply(df, function(x) length(unique(x)) == 2))]
  categorical_cols <- names(df)[(sapply(df, is.character) & sapply(df, function(x) length(unique(x)) > 2))]


  # Print outputs to verify
  print("Numerical Columns:")
  print(numerical_cols)
  print("Binary Columns:")
  print(binary_cols)
  print("Categorical Columns:")
  print(categorical_cols)

  # Function to convert binary columns to 0 and 1
  for (col in binary_cols) {
    # Ensure the column exists
    if (!col %in% names(df)) {
      warning(paste("Column", col, "does not exist in the dataframe. Skipping..."))
      next
    }

    # Check if the column has exactly two unique values
    unique_vals <- unique(df[[col]])
    if (length(unique_vals) != 2) {
      warning(paste("Column", col, "does not have exactly two unique values. Skipping..."))
      next
    }

    # Convert the column to 0 and 1
    # Assume that we map the smaller of the two unique values to 0, and the larger to 1
    df[[col]] <- as.numeric(df[[col]] == max(unique_vals))
  }

  df <- data.frame(df)

  print(str(df))

  # to handle categorical values
  for (col in categorical_cols) {
    df[[col]] <- as.factor(df[[col]])
  }

  # You can programmatically convert all character columns to factors if there are many
  df[sapply(df, is.character)] <- lapply(df[sapply(df, is.character)], as.factor)

  # Initialize dummyVars: here '~ .' means use all columns. You can also specify columns
  dv <- dummyVars(~ ., data = df, fullRank = FALSE)

  # Create the one-hot encoded data
  df <- predict(dv, newdata = df)

  print(str(df))

  # Convert the result into a dataframe
  df_encoded <- as.data.frame(df)

  return (df_encoded)
}

