if (!require("tidyverse")) install.packages("tidyverse", dependencies = TRUE)
library(tidyverse)
dropout_admission <- data$Admission_grade[data$Target == 'Dropout']
graduate_admission <- data$Admission_grade[data$Target == 'Graduate']

t_test_result <- t.test(dropout_admission, graduate_admission, alternative = "two.sided", na.rm = TRUE)

print(t_test_result)
