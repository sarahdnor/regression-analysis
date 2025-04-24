# Final Project ----
# step 1: baseline model (null)
# Stat 301-2

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# load pre-processing/feature engineering/recipe
load(here("recipes/null_rec.rda"))

# load resamples, controls, & metrics
load(here("data/malawi_folds.rda"))
load(here("data/my_metrics.rda"))
load(here("data/keep_wflow.rda"))

# load training data
load(here("data/malawi_train.rda"))

null_spec <- null_model() |>
  set_engine("parsnip") |> 
  set_mode("regression") 

null_workflow <- workflow() |> 
  add_model(null_spec) |> 
  add_recipe(null_rec)

null_fit <- null_workflow |> 
  fit_resamples(
    resamples = malawi_folds, 
    metrics = my_metrics, 
    control = control_resamples(save_workflow = TRUE)
  )

# write out results ----
save(null_fit, file = here("results/null_fit.rda"))
 