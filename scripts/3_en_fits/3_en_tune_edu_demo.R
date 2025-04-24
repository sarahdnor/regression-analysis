# Final Project ----
# step 3: fitting elastic net model - education and demographics predictors
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
load(here("recipes/edu_demo_rec.rda"))

# load resamples, controls, & metrics
load(here("data/malawi_folds.rda"))
load(here("data/my_metrics.rda"))
load(here("data/keep_wflow.rda"))

# load training data
load(here("data/malawi_train.rda"))

# model specifications ----
edu_demo_spec <- linear_reg(
  penalty = tune(), 
  mixture = tune()) |> 
  set_engine("glmnet")

# define workflows ----
edu_demo_wflow <- 
  workflow() |>
  add_model(edu_demo_spec) |>
  add_recipe(edu_demo_rec)

# hyperparameter tuning values ----

# # check ranges for hyperparameters
hardhat::extract_parameter_set_dials(edu_demo_spec)

# change hyperparameter ranges
edu_demo_params <- parameters(edu_demo_spec) |>
  update(
    penalty = penalty(c(-3, 0)),
    mixture = mixture()
  )

# build tuning grid
edu_demo_grid <- grid_regular(edu_demo_params, levels = 5)

# fit workflows/models (tuned) ----
en_tuned_edu_demo <-
  edu_demo_wflow |>
  tune_grid(
    resamples = malawi_folds,
    grid = edu_demo_grid,
    control = keep_wflow,
    metrics = my_metrics
  )

# write out results (fitted/trained workflows) ----
save(en_tuned_edu_demo, file = here("results/en_tuned_edu_demo.rda"))

