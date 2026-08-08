
nacionality_counts <- table(data$Nacionality)
sorted_counts <- sort(nacionality_counts, decreasing = TRUE)
top_10 <- head(sorted_counts, 10)
print(top_10)
