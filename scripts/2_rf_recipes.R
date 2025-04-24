# Final Project ----
# step 2: recipes
# Stat 301-2

## load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle conflicts
tidymodels_prefer()

## load training ----
load(here("data/malawi_train.rda"))

# Setting seed
set.seed (4576)

## education related recipe ----
rf_education_rec <- recipe(
  monthly_earnings_log ~ wb5a + wb5b + wb5c,
  data = malawi_train) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_zv(all_predictors()) 

# # check recipe
# rf_education_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(rf_education_rec, file = here("recipes/rf_education_rec.rda"))

## demographics recipe ----
rf_demographics_rec <- recipe(
  monthly_earnings_log ~ wb6 + wb7 + wb1,
  data = malawi_train
)  |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

# # check recipe
# rf_demographics_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(rf_demographics_rec, file = here("recipes/rf_demographics_rec.rda"))

## family & household recipe ----
rf_fam_house_rec <- recipe(
  monthly_earnings_log ~ wb2 + wb2a + wc5,
  data = malawi_train
) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_zv(all_predictors())

# # check recipe
# rf_fam_house_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(rf_fam_house_rec, file = here("recipes/rf_fam_house_rec.rda"))

## combined recipe ----
combined_rec_rf <- recipe(
  monthly_earnings_log ~ wb5a + wb5b + wb5c + wb6 + wb7 + wb1 + wb2 + wb2a + wc5,
  data = malawi_train) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors()) 

# # check recipe
# combined_rec_rf |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(combined_rec_rf, file = here("recipes/combined_rec_rf.rda"))

## education and demographic recipe ----
rf_edu_demo_rec <- recipe(
  monthly_earnings_log ~ wb5a + wb5b + wb5c + wb6 + wb7 + wb1,
  data = malawi_train) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors()) 

# # check recipe
# rf_edu_demo_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(rf_edu_demo_rec, file = here("recipes/rf_edu_demo_rec.rda"))

## education and family and house recipe ----
rf_edu_fam_rec <- recipe(
  monthly_earnings_log ~ wb5a + wb5b + wb5c + wb2 + wb2a + wc5,
  data = malawi_train) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors())

# # check recipe
# rf_edu_fam_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(rf_edu_fam_rec, file = here("recipes/rf_edu_fam_rec.rda"))

## demographics and house and family recipe ----
rf_demo_fam_rec <- recipe(
  monthly_earnings_log ~ wb6 + wb7 + wb1 + wb2 + wb2a + wc5,
  data = malawi_train) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors()) 

# # check recipe
# rf_demo_fam_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(rf_demo_fam_rec, file = here("recipes/rf_demo_fam_rec.rda"))

