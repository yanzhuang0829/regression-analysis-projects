if (!require("nnet")) {
  install.packages("nnet")
}
library(nnet)

data$Debtor_Tuition_Interaction <- data$Debtor * data$Tuition_fees_up_to_date
  model <- multinom(Target ~ Daytime_evening_attendance + Age_at_enrollment + Debtor * Tuition_fees_up_to_date, data = data)
    summary(model)

  coef(model)
    predictions <- predict(model, type = "probs")
      head(predictions)