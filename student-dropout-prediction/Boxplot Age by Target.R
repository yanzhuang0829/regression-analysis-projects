if (!require(ggplot2)) {
  install.packages("ggplot2")
}
library(ggplot2)

ggplot(data, aes(x = as.factor(Target), y = Age_at_enrollment)) +
  geom_boxplot(fill = "lightblue", color = "navy") +      # Boxplot with colors
  geom_jitter(color = "navy", width = 0.2, alpha = 0.6) + # Scatter points with slight jitter
  labs(title = "Boxplot of Age by Target",
       x = "Target",
       y = "Age") +
  theme_minimal()
