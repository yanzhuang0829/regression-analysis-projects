

# Subset the data: Compare "Dropout" vs "Graduate" (Remove "Enrolled")
binary_data <- subset(data, Target %in% c("Dropout", "Graduate"))

# Set "Graduate" as the reference category
binary_data$Target <- relevel(factor(binary_data$Target), ref = "Graduate")

# Fit Binary Logistic Regression model
binary_model <- glm(Target ~ Daytime_evening_attendance + Age_at_enrollment + 
                      Debtor * Tuition_fees_up_to_date, 
                    data = binary_data, family = binomial)

# Display model summary
summary(binary_model)

# Odds ratios for easier interpretation
exp(coef(binary_model))

# Predict probabilities
binary_predictions <- predict(binary_model, type = "response")

# View predictions
head(binary_predictions)
