
data$Target_Numeric <- as.numeric(data$Target_Numeric)


correlation <- cor(data$Target_Numeric, data$Admission_grade, use = "complete.obs", method = "pearson")
print(correlation)


correlation <- cor(data$Target_Numeric, data$Age_at_enrollment, use = "complete.obs", method = "pearson")
print(correlation)


correlation <- cor(data$Target_Numeric, data$Gender, use = "complete.obs", method = "pearson")
print(correlation)


