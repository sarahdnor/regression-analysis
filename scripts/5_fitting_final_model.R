# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(doMC)

# handle common conflicts
tidymodels_prefer()

# set seed
set.seed(4576)

# parallel processing
num_cores <- parallel::detectCores(logical = FALSE)
registerDoMC(cores = num_cores)

# loading objects
load(here("data/malawi_train.rda"))
load(here("recipes/combined_rec_rf.rda"))

# model specifications ----
final_spec <- rand_forest(
  trees = 1000, 
  min_n = 40,
  mtry = 3
) |>
  set_engine('ranger') |>
  set_mode('regression')

# define workflows ----
final_wflow <- 
  workflow() |>
  add_model(final_spec) |>
  add_recipe(combined_rec_rf)

# train final model ----
final_fit <- fit(final_wflow, malawi_train)

# write out model ----
save(final_fit, file = here("results/final_fit.rda"))


