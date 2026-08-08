
library(dplyr)

summary_table <- list(
  `Marital Status` = table(data[["Marital status"]]),
  `Daytime/Evening Attendance` = table(data[["Daytime/evening attendance"]]),
  `Tuition Fees Up-to-Date` = table(data[["Tuition fees up to date"]]),
  `Scholarship Holder` = table(data[["Scholarship holder"]]),
  `International` = table(data[["International"]]),
  `Target` = table(data[["Target"]])
)

for (var in names(summary_table)) {
  cat("\n", var, "Counts:\n")
  print(summary_table[[var]])
}
