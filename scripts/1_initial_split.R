# Final Project ----
# step 1: initial split
# Stat 301-2

# Loading packages
library(tidymodels)
library(tidyverse)
library(patchwork)
library(here)
library(readr)

# Handling common conflicts
tidymodels_prefer()

# Setting seed
set.seed (4576)

# Loading data
load(file = here("data/malawi_data.rda"))

## Splitting the data ----
malawi_split <-
  initial_split(malawi_data, prop = 0.80, strata = monthly_earnings_log)

malawi_train <- training(malawi_split)
malawi_test  <- testing(malawi_split)

save(malawi_split, file = here("data/malawi_split.rda"))
save(malawi_train, file = here("data/malawi_train.rda"))
save(malawi_test, file = here("data/malawi_test.rda"))

## folding training data ----
malawi_folds <- malawi_train |> 
  vfold_cv(
    v = 5, 
    repeats = 3,
    strata = monthly_earnings_log
  )

# write out/save outputs ----
save(malawi_folds, file = here("data/malawi_folds.rda"))

# controls for fitting to resamples ----
keep_wflow <- control_resamples(save_workflow = TRUE)
my_metrics <- metric_set(mae, rmse, rsq)

# write out/save outputs ----
save(keep_wflow, file = here("data/keep_wflow.rda"))
save(my_metrics, file = here("data/my_metrics.rda"))


