# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# loading objects ----
load(here("data/malawi_test.rda"))
load(here("results/final_fit.rda"))

# creating metric set ----
final_metric_set <- metric_set(rmse, mae, rsq) 

# predictions ----
final_pred <- malawi_test |> 
  bind_cols(predict(final_fit, malawi_test)) |>
  select(monthly_earnings, .pred) |>
  mutate(
    .pred = 10^(.pred) - 1
  )

final_pred_log <- malawi_test |>
  bind_cols(predict(final_fit, malawi_test)) |>
  select(monthly_earnings_log, .pred)

# # save results
save(final_pred, file = here("tables/final_pred.rda"))
# save(final_pred_log, file = here("tables/final_pred_log.rda"))

final_model_metrics <- final_pred_log |>
  final_metric_set(monthly_earnings_log, .pred) 

# # save model metrics
save(final_model_metrics, file = here("tables/final_model_metrics.rda"))

## building graph ----
final_pred_graph <- final_pred_log |>
  ggplot(aes(x = monthly_earnings_log, y = .pred)) +
  geom_point(alpha = 0.3, size = 2) +
  theme_minimal(base_size = 14) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  labs(
    y = "Predicted Monthly Earnings (on log scale)",
    x = "Actual Monthly Earnings (on log scale)"
  )

# saving plot
ggsave(
  filename = here("figures/final_pred_graph.png"),
  plot = final_pred_graph,
  height = 6
)

