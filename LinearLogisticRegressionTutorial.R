## -----------------------------------------------------------------------------
# Install the package if it's not already installed (uncomment the next line)
# install.packages("simpleEnsembleGroup6")

# Load the package
library(simpleEnsembleGroup6)

## -----------------------------------------------------------------------------
# Load and examine the mtcars dataset
data(mtcars)
head(mtcars)

## -----------------------------------------------------------------------------
# Check for and handle missing values
if (anyNA(mtcars)) {
  mtcars <- na.omit(mtcars)
}

# Standardize predictors to have mean zero and unit variance
mtcars$disp <- scale(mtcars$disp)
mtcars$hp <- scale(mtcars$hp)
mtcars$wt <- scale(mtcars$wt)

# Select the response variable and predictors
y <- mtcars$mpg
X <- mtcars[, c("disp", "hp", "wt")]

## -----------------------------------------------------------------------------
# Fitting the model
model <- linear_logistic_regression(y, X)

## -----------------------------------------------------------------------------
# Display the summary of the model
summary(model)

## -----------------------------------------------------------------------------
?linear_logistic_regression

