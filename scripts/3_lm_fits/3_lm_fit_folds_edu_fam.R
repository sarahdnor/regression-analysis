# Final Project ----
# step 3: fitting ordinary linear regression - education and family and house predictors
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
load(here("recipes/edu_fam_rec.rda"))

# load resamples, controls, & metrics
load(here("data/malawi_folds.rda"))
load(here("data/my_metrics.rda"))
load(here("data/keep_wflow.rda"))

# load training data
load(here("data/malawi_train.rda"))

# model specifications ----
edu_fam_spec <- linear_reg() |> 
  set_engine("lm")

# define workflows ----
lm_wflow <- 
  workflow() |>
  add_model(edu_fam_spec) |>
  add_recipe(edu_fam_rec)

# fit workflows/models ----
fit_folds_lm_edu_fam <- fit_resamples(
  lm_wflow, 
  resamples = malawi_folds,
  control = keep_wflow
)

# write out results (fitted/trained workflows) ----
save(fit_folds_lm_edu_fam, file = here("results/fit_folds_lm_edu_fam.rda"))

