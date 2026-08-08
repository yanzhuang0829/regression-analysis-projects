

# Perform ANOVA
anova_model <- aov(Target_Numeric ~ Marital_status, data = data)

summary(anova_model)

