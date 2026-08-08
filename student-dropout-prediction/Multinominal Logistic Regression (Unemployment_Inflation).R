library(nnet)  
data$Unemployment_Inflation_Interaction <- data$Unemployment_rate * data$Inflation_rate
model <- multinom(Target ~ Daytime_evening_attendance + Age_at_enrollment + 
                    Unemployment_rate * Inflation_rate, data = data)
summary(model)
exp(coef(model))
predictions <- predict(model, newdata = data, type = "class")
accuracy <- mean(predictions == data$Target)
print(paste("Model Accuracy:", accuracy))
