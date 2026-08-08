library(dplyr)

# Since correlation of these variables are minus, we proved with standard deviatio
# how data is spread out, which specifically drop out as we can see in the result
# however, standard deviation is not that high so we can continue to analyze. 
std_dev_by_group_age_target <- data %>%
  group_by(Target) %>%
  summarise(Std_Dev_Age = sd(Age_at_enrollment, na.rm = TRUE))

print(std_dev_by_group_age_target)



std_dev_by_group_gender_target <- data %>%
  group_by(Target) %>%
  summarise(Std_Dev_Gender = sd(Gender, na.rm = TRUE))

print(std_dev_by_group_gender_target)