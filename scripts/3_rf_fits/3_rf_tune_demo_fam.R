# Final Project ----
# step 3: fitting random forest - demographics and family predictors
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
rf_spec <- rand_forest(
  trees = tune(), 
  min_n = tune(),
  mtry = tune()
) |>
  set_engine('ranger') |>
  set_mode('regression')

# define workflows ----
rf_wflow <- 
  workflow() |>
  add_model(rf_spec) |>
  add_recipe(rf_demo_fam_rec)

# hyperparameter tuning values ----

# # check ranges for hyperparameters
hardhat::extract_parameter_set_dials(rf_spec)

# change hyperparameter ranges
rf_params <- parameters(rf_spec) |>
  update(
    mtry = mtry(c(1, 3)),
    min_n = min_n(),
    trees = trees(c(500, 1000))
  )

# build tuning grid
rf_grid <- grid_regular(rf_params, levels = c(3, 5, 5))

# fit workflows/models (tuned) ----
rf_tuned_demo_fam <-
  rf_wflow |>
  tune_grid(
    resamples = malawi_folds,
    grid = rf_grid,
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(rf_tuned_demo_fam, file = here("results/rf_tuned_demo_fam.rda"))


