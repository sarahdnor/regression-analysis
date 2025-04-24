# Final Project ----
# step 3: fitting ordinary linear regression - education predictors
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
load(here("recipes/lm_education_rec.rda"))

# load resamples, controls, & metrics
load(here("data/malawi_folds.rda"))
load(here("data/my_metrics.rda"))
load(here("data/keep_wflow.rda"))

# load training data
load(here("data/malawi_train.rda"))

# model specifications ----
lm_mod <- linear_reg() |> 
  set_engine("lm")

# define workflows ----
lm_wflow <- 
  workflow() |>
  add_model(lm_mod) |>
  add_recipe(lm_education_rec)

# fit workflows/models ----
fit_folds_lm_edu <- fit_resamples(
  lm_wflow, 
  resamples = malawi_folds,
  metrics = my_metrics,
  control = keep_wflow
)

# write out results (fitted/trained workflows) ----
save(fit_folds_lm_edu, file = here("results/fit_folds_lm_edu.rda"))
