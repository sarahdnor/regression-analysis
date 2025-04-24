# Final Project ----
# step 3: fitting boosted trees - education and family and house predictors
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
load(here("recipes/rf_edu_fam_rec.rda"))

# load resamples, controls, & metrics
load(here("data/malawi_folds.rda"))
load(here("data/my_metrics.rda"))
load(here("data/keep_wflow.rda"))

# load training data
load(here("data/malawi_train.rda"))

# model specifications ----
bt_spec <- 
  boost_tree( 
    min_n = tune(),
    mtry = tune(),
    learn_rate = tune(),
    trees = tune()
  ) |> 
  set_engine("xgboost") |> 
  set_mode("regression")

# define workflows ----
bt_wflow <- 
  workflow() |>
  add_model(bt_spec) |>
  add_recipe(rf_edu_fam_rec)

# hyperparameter tuning values ----

# # check ranges for hyperparameters
hardhat::extract_parameter_set_dials(bt_spec)

# change hyperparameter ranges
bt_params <- parameters(bt_spec) |>
  update(
    mtry = mtry(c(1, 3)),
    min_n = min_n(),
    trees = trees(c(500, 1000)),
    learn_rate = learn_rate()
  )

# build tuning grid
bt_grid <- grid_regular(bt_params, levels = c(3, 5, 5, 3))

# fit workflows/models (tuned) ----
bt_tuned_edu_fam <-
  bt_wflow |>
  tune_grid(
    resamples = malawi_folds,
    grid = bt_grid,
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(bt_tuned_edu_fam, file = here("results/bt_tuned_edu_fam.rda"))
