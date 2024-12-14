## -----------------------------------------------------------------------------
# Install glmnet if not already installed
if (!require(glmnet)) install.packages("glmnet", dependencies = TRUE)

# Load necessary libraries
library(simpleEnsembleGroup6)
library(glmnet)

## -----------------------------------------------------------------------------
# Load and prepare the mtcars dataset
data(mtcars)
head(mtcars)

## -----------------------------------------------------------------------------
# Handling missing values if any
mtcars <- na.omit(mtcars)

# Standardizing predictors might be beneficial for lasso to scale them equally
mtcars$disp <- scale(mtcars$disp)
mtcars$hp <- scale(mtcars$hp)
mtcars$wt <- scale(mtcars$wt)

# Defining the response variable and predictors
y <- mtcars$mpg
X <- as.matrix(mtcars[, c("disp", "hp", "wt")])  # glmnet needs matrix format

## -----------------------------------------------------------------------------
# Fitting the lasso model
model <- lasso_regression(y, X)

## -----------------------------------------------------------------------------
# Display model coefficients
print(coef(model))

## -----------------------------------------------------------------------------
# Finding optimal lambda through cross-validation
cv_model <- cv.glmnet(X, y)
plot(cv_model)
best_lambda <- cv_model$lambda.min
cat("Best lambda:", best_lambda)

# Refitting the model with the best lambda
best_model <- lasso_regression(y, X, lambda = best_lambda)

## -----------------------------------------------------------------------------
?glmnet
?lasso_regression

