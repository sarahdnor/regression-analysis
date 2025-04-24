## initial set up ----

# Loading packages
library(tidymodels)
library(tidyverse)

# handling common conflicts
tidymodels_prefer()

# Reading in data
malawi_data <- read_delim("data/malawi_longitudinal_data.tsv", delim = "\t", na = c("", " "))

# viewing data
glimpse(malawi_data)
View(malawi_data)

# missingness check
malawi_data_small <- naniar::miss_var_summary(malawi_data) |>
  filter(pct_miss <= 20) |>
  select(variable)

malawi_data_small

malawi_data_small <- malawi_data |>
  select(all_of(malawi_data_small$variable))

malawi_data |>
  select(m2wb5a)

malawi_data |>
  select(m2wa3) |>
  print(n = 50)




#m2wm6c - respondents age at first marrige
#m2wb5a - if respondent went to school
#m2we3 - respondents earnings from work
#m2wa3 - respondents concern about getting aids

