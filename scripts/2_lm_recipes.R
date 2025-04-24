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

## null recipe ----
null_rec <- recipe(
  monthly_earnings_log ~ 1, 
  data = malawi_train)

# # check recipe
# null_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(null_rec, file = here("recipes/null_rec.rda"))

## education related recipe ----
lm_education_rec <- recipe(
  monthly_earnings_log ~ wb5a + wb5b + wb5c,
  data = malawi_train) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_zv(all_predictors()) 

# # check recipe
# lm_education_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(lm_education_rec, file = here("recipes/lm_education_rec.rda"))

## demographics recipe ----
lm_demographics_rec <- recipe(
  monthly_earnings_log ~ wb6 + wb7 + wb1,
  data = malawi_train
)  |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_normalize(all_numeric_predictors()) |>
  step_zv(all_predictors())

# # check recipe
# lm_demographics_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(lm_demographics_rec, file = here("recipes/lm_demographics_rec.rda"))

## family & household recipe ----
lm_fam_house_rec <- recipe(
  monthly_earnings_log ~ wb2 + wb2a + wc5,
  data = malawi_train
) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_zv(all_predictors())

# # check recipe
# lm_fam_house_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(lm_fam_house_rec, file = here("recipes/lm_fam_house_rec.rda"))

## combined recipe ----
combined_rec <- recipe(
  monthly_earnings_log ~ wb5a + wb5b + wb5c + wb6 + wb7 + wb1 + wb2 + wb2a + wc5,
  data = malawi_train) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors()) 

# # check recipe
# combined_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(combined_rec, file = here("recipes/combined_rec.rda"))

## education and demographics recipe ----
edu_demo_rec <- recipe(
  monthly_earnings_log ~ wb5a + wb5b + wb5c + wb6 + wb7 + wb1,
  data = malawi_train) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors()) 


# # check recipe
# edu_demo_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(edu_demo_rec, file = here("recipes/edu_demo_rec.rda"))

## education and house and family ----
edu_fam_rec <- recipe(
  monthly_earnings_log ~ wb5a + wb5b + wb5c + wb2 + wb2a + wc5,
  data = malawi_train) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors()) 

# # check recipe
# edu_fam_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(edu_fam_rec, file = here("recipes/edu_fam_rec.rda"))

## demographics and house and family ----
demo_fam_rec <- recipe(
  monthly_earnings_log ~ wb6 + wb7 + wb1 + wb2 + wb2a + wc5,
  data = malawi_train) |>
  step_impute_mode(all_nominal_predictors()) |>
  step_impute_mean(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors()) |>
  step_zv(all_predictors()) |>
  step_normalize(all_numeric_predictors()) 

# # check recipe
# demo_fam_rec |>
#   prep() |>
#   bake(new_data = NULL)

# save/write out recipe ----
save(demo_fam_rec, file = here("recipes/demo_fam_rec.rda"))


