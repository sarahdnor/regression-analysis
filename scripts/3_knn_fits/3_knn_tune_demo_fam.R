# Final Project ----
# step 3: fitting k-nearest neighbors - demographic and family and house predictors
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
load(here("recipes/rf_demo_fam_rec.rda"))

# load resamples, controls, & metrics
load(here("data/malawi_folds.rda"))
load(here("data/my_metrics.rda"))
load(here("data/keep_wflow.rda"))

# load training data
load(here("data/malawi_train.rda"))

# model specifications ----
knn_spec <- nearest_neighbor(
  neighbors = tune()
) |> 
  set_engine("kknn") |> 
  set_mode("regression")

# define workflows ----
knn_wflow <- 
  workflow() |>
  add_model(knn_spec) |>
  add_recipe(rf_demo_fam_rec)

# hyperparameter tuning values ----

# # check ranges for hyperparameters
hardhat::extract_parameter_set_dials(knn_spec)

# change hyperparameter ranges
knn_params <- parameters(knn_spec) |>
  update(
    neighbors = neighbors()
  )

# build tuning grid
knn_grid <- grid_regular(knn_params, levels = 5)

# fit workflows/models (tuned) ----
knn_tuned_demo_fam <-
  knn_wflow |>
  tune_grid(
    resamples = malawi_folds,
    grid = knn_grid,
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(knn_tuned_demo_fam, file = here("results/knn_tuned_demo_fam.rda"))
