# Final Project ----
# step 3: fitting elastic net model - all predictors
# Stat 301-2

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(foreach)
library(doMC)

# handle common conflicts
tidymodels_prefer()

# set seed
set.seed(4576)

# parallel processing
num_cores <- parallel::detectCores(logical = FALSE)
registerDoMC(cores = num_cores)

# load pre-processing/feature engineering/recipe
load(here("recipes/combined_rec.rda"))

# load resamples, controls, & metrics
load(here("data/malawi_folds.rda"))
load(here("data/my_metrics.rda"))
load(here("data/keep_wflow.rda"))

# load training data
load(here("data/malawi_train.rda"))

# model specifications ----
combined_spec <- linear_reg(
  penalty = tune(), 
  mixture = tune()) |> 
  set_engine("glmnet")

# define workflows ----
combined_wflow <- 
  workflow() |>
  add_model(combined_spec) |>
  add_recipe(combined_rec)

# hyperparameter tuning values ----

# # check ranges for hyperparameters
hardhat::extract_parameter_set_dials(combined_spec)

# change hyperparameter ranges
combined_params <- parameters(combined_spec) |>
  update(
    penalty = penalty(c(-3, 0)),
    mixture = mixture()
  )

# build tuning grid
combined_grid <- grid_regular(combined_params, levels = 5)

# fit workflows/models (tuned) ----
en_tuned_combined <-
  combined_wflow |>
  tune_grid(
    resamples = malawi_folds,
    grid = combined_grid,
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(en_tuned_combined, file = here("results/en_tuned_combined.rda"))