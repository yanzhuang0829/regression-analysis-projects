regression_model <- lm(Target_Numeric ~ Marital_status, data = data)

summary(regression_model)

# Install lm.beta package
install.packages("lm.beta")

# Load the library
library(lm.beta)

model <- lm(Target_Numeric ~ Marital_status, data = data)
standardized_model <- lm.beta(model)
print(standardized_model)
