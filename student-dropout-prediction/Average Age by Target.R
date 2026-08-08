average_age_by_group <- aggregate(Age_at_enrollment ~ Target, data = data, FUN = function(x) mean(x, na.rm = TRUE))

print(average_age_by_group)
