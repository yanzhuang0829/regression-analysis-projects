# Predicting Student Dropout Risk
# ST 635 Final Project - Logistic Regression, Classification Tree, PCA, K-Means Clustering

# Load libraries
library(readxl)
library(ggplot2)
library(caret)
library(pROC)
library(car)
library(rpart)
library(rpart.plot)
library(rattle)

# Section 1: Data Loading and Preprocessing

# Load data
data <- read.csv("final_data.csv")

# Create binary target variable
data$y <- factor(ifelse(data$Target == "Dropout", "yes", "no"), levels = c("no", "yes"))

# Convert character columns to factors
char_vars <- sapply(data, is.character)
data[, char_vars] <- lapply(data[, char_vars], factor)

# Train/test split
set.seed(1)
train.idx <- createDataPartition(data$y, p = 0.7, list = FALSE)
train.data <- data[train.idx, ]
test.data <- data[-train.idx, ]


# Section 2: Logistic Regression

# Logistic regression model
log_model <- glm(y ~ Admission_grade + Curricular_units_1st_sem_.grade. + 
                                    Curricular_units_2nd_sem_.grade. + Unemployment_rate + Inflation_rate + 
                                    GDP + Gender + Scholarship_holder + Tuition_fees_up_to_date + Daytime_evening_attendance.,
                                  data = train.data, family = binomial)

summary(log_model)
AIC(log_model)

# Predict probabilities on test set
log_test_pred <- predict(log_model, newdata = test.data, type = "response")

# ROC curve and AUC
roc(test.data$y, log_test_pred, plot = TRUE, print.auc = TRUE)

# Predict classes
pred_class <- factor(ifelse(log_test_pred > 0.5, "yes", "no"), levels = c("no", "yes"))

# Confusion matrix
conf_matrix <- confusionMatrix(pred_class, test.data$y, positive = "yes")
print(conf_matrix)
print(conf_matrix$byClass["Sensitivity"])

# VIF (multicollinearity check)
vif(log_model)

# Odds ratios
exp(coef(log_model))

# Section 3: Classification Tree

# Build classification tree
tree_model <- rpart(y ~ Admission_grade + Curricular_units_1st_sem_.grade.+ 
                                          Curricular_units_2nd_sem_.grade. + Unemployment_rate + Inflation_rate + 
                                          GDP + Gender + Scholarship_holder + Tuition_fees_up_to_date + Daytime_evening_attendance.,
                                        data = train.data, method = "class", cp = 0.01)

# Prune the tree
cp.opt <- tree_model$cptable[which.min(tree_model$cptable[, "xerror"]), "CP"]
pruned_tree <- prune(tree_model, cp = cp.opt)

# Visualize tree
fancyRpartPlot(pruned_tree)

# Predict on test set
tree_pred_class <- predict(pruned_tree, newdata = test.data, type = "class")
tree_pred_prob <- predict(pruned_tree, newdata = test.data, type = "prob")

# Confusion matrix
conf_matrix_tree <- confusionMatrix(tree_pred_class, test.data$y, positive = "yes")
print(conf_matrix_tree)
roc(test.data$y, tree_pred_prob[, "yes"], plot = TRUE, print.auc = TRUE)


# Section 4: PCA Analysis

# PCA on numeric predictors
numeric_vars <- sapply(train.data, is.numeric)
train_numeric <- train.data[, numeric_vars]

# Standardize and run PCA
pca_result <- prcomp(train_numeric, center = TRUE, scale. = TRUE)

# Scree plot
screeplot(pca_result)
plot(pca_result, type = "l", main = "Scree Plot")

# PCA Visualization
pca_df <- data.frame(pca_result$x[, 1:2])
pca_df$y <- train.data$y

ggplot(pca_df, aes(x = PC1, y = PC2, color = y)) +
  geom_point(alpha = 0.7) +
  theme_minimal() +
  labs(title = "PCA: PC1 vs PC2", color = "Dropout")

# Section 5: K-Means Clustering

# Standardize numeric data
train_scaled <- scale(train_numeric)

# Elbow method
wss <- numeric(10)
for (k in 1:10) {
    kmeans_model <- kmeans(train_scaled, centers = k, nstart = 20)
    wss[k] <- kmeans_model$tot.withinss
  }

# Plot elbow curve
plot(1:10, wss, type = "b", pch = 19, frame = FALSE,
          xlab = "Number of clusters (k)",
          ylab = "Total within-cluster sum of squares",
          main = "Elbow Method for Choosing k")

# Choose number of clusters
set.seed(1)
kmeans_result <- kmeans(train_scaled, centers = 3, nstart = 20)

# Add cluster label
train.data$cluster <- factor(kmeans_result$cluster)
pca_df$cluster <- train.data$cluster

# Visualize clusters on PCA
ggplot(pca_df, aes(x = PC1, y = PC2, color = cluster)) +
  geom_point(alpha = 0.7) +
  theme_minimal() +
  labs(title = "K-means Clustering on PCA: PC1 vs PC2", color = "Cluster")
