# Final Project ----
# step 4: comparing models
# Stat 301-2

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# set seed
set.seed(4576)

# null fit ----
load(file = here("results/null_fit.rda"))

## loading necessary objects

# lm fold fits ----
load(file = here("results/fit_folds_lm_edu.rda"))
load(file = here("results/fit_folds_lm_demo.rda"))
load(file = here("results/fit_folds_lm_fam.rda"))
load(file = here("results/fit_folds_lm_edu_demo.rda"))
load(file = here("results/fit_folds_lm_edu_fam.rda"))
load(file = here("results/fit_folds_lm_demo_fam.rda"))
load(file = here("results/fit_folds_lm_combined.rda"))

# en tune
load(file = here("results/en_tuned_demo.rda"))
load(file = here("results/en_tuned_edu.rda"))
load(file = here("results/en_tuned_fam.rda"))
load(file = here("results/en_tuned_edu_demo.rda"))
load(file = here("results/en_tuned_edu_fam.rda"))
load(file = here("results/en_tuned_demo_fam.rda"))
load(file = here("results/en_tuned_combined.rda"))

# rf tune
load(file = here("results/rf_tuned_demo.rda"))
load(file = here("results/rf_tuned_edu.rda"))
load(file = here("results/rf_tuned_fam.rda"))
load(file = here("results/rf_tuned_edu_demo.rda"))
load(file = here("results/rf_tuned_edu_fam.rda"))
load(file = here("results/rf_tuned_demo_fam.rda"))
load(file = here("results/rf_tuned_combined.rda"))

# bt tune
load(file = here("results/bt_tuned_demo.rda"))
load(file = here("results/bt_tuned_edu.rda"))
load(file = here("results/bt_tuned_fam.rda"))
load(file = here("results/bt_tuned_edu_demo.rda"))
load(file = here("results/bt_tuned_edu_fam.rda"))
load(file = here("results/bt_tuned_demo_fam.rda"))
load(file = here("results/bt_tuned_combined.rda"))

# knn tune
load(file = here("results/knn_tuned_demo.rda"))
load(file = here("results/knn_tuned_edu.rda"))
load(file = here("results/knn_tuned_fam.rda"))
load(file = here("results/knn_tuned_edu_demo.rda"))
load(file = here("results/knn_tuned_edu_fam.rda"))
load(file = here("results/knn_tuned_demo_fam.rda"))
load(file = here("results/knn_tuned_combined.rda"))

## gathering model metrics

# lm model training results ----
lm_results <- 
  as_workflow_set(
    null = null_fit,
    lm_edu = fit_folds_lm_edu,
    lm_demo = fit_folds_lm_demo,
    lm_fam = fit_folds_lm_fam,
    lm_edu_demo = fit_folds_lm_edu_demo,
    lm_edu_fam = fit_folds_lm_edu_fam,
    lm_demo_fam = fit_folds_lm_demo_fam,
    lm_combined = fit_folds_lm_combined
  )

lm_model_results <- lm_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id) |>
  arrange(mean)

# write out results ----
save(lm_model_results, file = here("tables/lm_model_results.rda"))

# en model training results ----
en_tune_results <- as_workflow_set(
  null = null_fit,
  en_demo = en_tuned_demo,
  en_edu = en_tuned_edu,
  en_fam = en_tuned_fam,
  en_edu_demo = en_tuned_edu_demo,
  en_edu_fam = en_tuned_edu_fam,
  en_demo_fam = en_tuned_demo_fam,
  en_combined = en_tuned_combined
)

en_model_results <- en_tune_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id, with_ties = FALSE) |>
  arrange(mean)

# write out results ----
save(en_model_results, file = here("tables/en_model_results.rda"))

# rf model training results ----
rf_tune_results <- as_workflow_set(
  null = null_fit,
  rf_demo = rf_tuned_demo,
  rf_edu = rf_tuned_edu,
  rf_fam = rf_tuned_fam,
  rf_edu_demo = rf_tuned_edu_demo,
  rf_edu_fam = rf_tuned_edu_fam,
  rf_demo_fam = rf_tuned_demo_fam,
  rf_combined = rf_tuned_combined
)

rf_model_results <- rf_tune_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id, with_ties = FALSE) |>
  arrange(mean)

# write out results ----
save(rf_model_results, file = here("tables/rf_model_results.rda"))

# bt model training results ----
bt_tune_results <- as_workflow_set(
  null = null_fit,
  bt_demo = bt_tuned_demo,
  bt_edu = bt_tuned_edu,
  bt_fam = bt_tuned_fam,
  bt_edu_demo = bt_tuned_edu_demo,
  bt_edu_fam = bt_tuned_edu_fam,
  bt_demo_fam = bt_tuned_demo_fam,
  bt_combined = bt_tuned_combined
)

bt_model_results <- bt_tune_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id, with_ties = FALSE) |>
  arrange(mean)

# write out results ----
save(bt_model_results, file = here("tables/bt_model_results.rda"))

# knn model training results ----
knn_tune_results <- as_workflow_set(
  null = null_fit,
  knn_demo = knn_tuned_demo,
  knn_edu = knn_tuned_edu,
  knn_fam = knn_tuned_fam,
  knn_edu_demo = knn_tuned_edu_demo,
  knn_edu_fam = knn_tuned_edu_fam,
  knn_demo_fam = knn_tuned_demo_fam,
  knn_combined = knn_tuned_combined
)

knn_model_results <- knn_tune_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id, with_ties = FALSE) |>
  arrange(mean)

# write out results ----
save(knn_model_results, file = here("tables/knn_model_results.rda"))

# Best model across model types ----
best_results <- as_workflow_set(
  null = null_fit,
  lm_edu = fit_folds_lm_edu,
  en_edu_demo = en_tuned_edu_demo,
  en_demo_fam = en_tuned_demo_fam,
  rf_combined = rf_tuned_combined,
  bt_demo_fam = bt_tuned_demo_fam,
  knn_combined = knn_tuned_combined,
)

best_results_table <- best_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id, with_ties = FALSE) |>
  arrange(mean) 

# write out results ----
save(best_results_table, file = here("tables/best_results_table.rda"))

## Graphing ----

# Visual of best models across model types ----
best_results_graph <- best_results |>
  autoplot(metric = "rmse", select_best = TRUE) 

# saving graph ----
ggsave(
  filename = here("figures/best_results_graph.png"),
  plot = best_results_graph,
  height = 6
)

## Best model with best hyperparemeters ----

best_hyperparameters <- 
  bind_rows(
  select_best(rf_tuned_combined, metric = "rmse") |> mutate(model = "random forest"),
  select_best(bt_tuned_demo_fam, metric = "rmse") |> mutate(model = "boosted trees"),
  select_best(en_tuned_demo_fam, metric = "rmse") |> mutate(model = "elastic net"),
  select_best(knn_tuned_combined, metric = "rmse") |> mutate(model = "k-nearest neighbors"),
  select_best(fit_folds_lm_edu, metric = "rmse") |> mutate(model = "ordinary linear regression")
  ) |> 
  relocate(model) |>
  select(-.config)

# write out results ----
save(best_hyperparameters, file = here("tables/best_hyperparameters.rda"))

## hyperparameter graphs ----

# rf
rf_tuned_combined_graph <- rf_tuned_combined |>
  autoplot(metric = "rmse") +
  theme(
    axis.text.x = element_blank(),
  strip.text = element_blank()
  )

# write out results ----
ggsave(
  filename = here("figures/rf_tuned_combined_graph.png"),
  plot = rf_tuned_combined_graph,
  height = 6
)

# bt
bt_tuned_demo_fam_graph <- bt_tuned_demo_fam |>
  autoplot(metric = "rmse") +
  theme(strip.text = element_text(face = "bold", size = 5))

# write out results ----
ggsave(
  filename = here("figures/bt_tuned_demo_fam_graph.png"),
  plot = bt_tuned_demo_fam_graph,
  height = 6
)

# en
en_tuned_edu_demo_graph <- en_tuned_edu_demo |>
  autoplot(metric = "rmse")

# write out results ----
ggsave(
  filename = here("figures/en_tuned_edu_demo_graph.png"),
  plot = en_tuned_edu_demo_graph,
  height = 6
)

# knn
knn_tuned_demo_fam_graph <- knn_tuned_demo_fam |>
  autoplot(metric = "rmse")

# write out results ----
ggsave(
  filename = here("figures/knn_tuned_demo_fam_graph.png"),
  plot = knn_tuned_demo_fam_graph,
  height = 6
)

# combined results table ----

all_results <- bind_rows(
  
lm_model_results <- lm_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id) |>
  arrange(mean),

en_model_results <- en_tune_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id, with_ties = FALSE) |>
  arrange(mean),

rf_model_results <- rf_tune_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id, with_ties = FALSE) |>
  arrange(mean),

bt_model_results <- bt_tune_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id, with_ties = FALSE) |>
  arrange(mean),

knn_model_results <- knn_tune_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  slice_min(mean, by = wflow_id, with_ties = FALSE) |>
  arrange(mean)

) |>
  filter(wflow_id != "null") 
  
# write out results ----
save(all_results, file = here("tables/all_results.rda"))
