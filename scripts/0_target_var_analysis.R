###  Final Project 2 Memo 1----
## Initial set up

## Packages and data ----

# Loading packages
library(tidymodels)
library(tidyverse)
library(DT)
library(patchwork)
library(here)

# handling common conflicts
tidymodels_prefer()

# Reading in data
malawi_data_w2 <- read_delim(here("data/malawi_data_wave_2.tsv"), delim = "\t", na = c("", " ")) 
malawi_data_w1 <- read_delim(here("data/malawi_data_wave_1.tsv"), delim = "\t", na = c("", " "))

# Combining data
malawi_data <- malawi_data_w2 |> 
  select(
    CASEID, m2we5b
  ) |>
  left_join(malawi_data_w1, join_by(CASEID)) 

# Recoding missing values and fixing data typing
malawi_data <- malawi_data |> mutate(
  m2we5b = if_else(m2we5b == 88 |  m2we5b == 5 , NA,  m2we5b),
  wb5b = if_else(wb5b == 88, NA, wb5b),
  wb7  = if_else(wb7 == 88, NA, wb7),
  wb1  = if_else(wb1 == 88, NA, wb1),
  wb2a = if_else(wb2a == 88, NA, wb2a),
  wc5  = if_else(wc5 == 88, NA, wc5),
  wb5a = as.factor(wb5a),
  wb5b = as.factor(wb5b),
  wb5c = as.factor(wb5c),
  wb6 = as.factor(wb6),
  wb7 = as.factor(wb7),
  wb2 = as.factor(wb2),
  wb2a = as.factor(wb2a)
) |>
  filter(!is.na(m2we5b)) |>
  janitor::clean_names() |>
  rename(monthly_earnings = m2we5b) |>
  mutate(monthly_earnings_log = log10(monthly_earnings + 1)) 

# Write out/save outputs ----
save(malawi_data, file = here("data/malawi_data.rda"))

# # viewing data
# glimpse(malawi_data)
# View(malawi_data)

# ## data quality check ----
# 
# # summary of data
# skimr::skim_without_charts(malawi_data) 
# 
# ## missingness check ----
# 
# # number of variables with greater than 20% missingness
# naniar::miss_var_summary(malawi_data) |>
#   arrange(pct_miss) |>
#   filter(pct_miss > 20) |>
#   summarise(count = n())
# 
# ## target variable analysis ----
# 
# # summary
# malawi_data |>
#   skimr::skim_without_charts(monthly_earnings)
# 
# malawi_data |>
#   summarise(
#     mean = mean(monthly_earnings),
#     min = min(monthly_earnings),
#     max = max(monthly_earnings)
            # )

# histogram of distribution
earnings <- malawi_data |>
  ggplot(aes(x = monthly_earnings)) +
  geom_histogram(col= "white") +
  theme_minimal() +
  theme(
    axis.title.y = element_blank(),
    axis.text.y = element_blank()
  ) +
  labs (
    x = "Monthly Earnings (MWK)"
  )

earnings

# adding log transformation of earnings

# histogram of log distribution
earnings_log <- malawi_data |>
  ggplot(aes(x = monthly_earnings_log)) +
  geom_histogram(col= "white") +
  theme_minimal() +
  theme(
       axis.title.y = element_blank(),
       axis.text.y = element_blank()
     ) +
  labs (
    x = "Monthly Earnings (Log MWK)"
  )

earnings_log

# combined histograms
earnings_comp <- earnings/earnings_log + 
  plot_annotation(title = "Distribution of Monthly Earnings")

earnings_comp

ggsave(
    filename = here::here("figures/earnings_comp.png"),
    plot = earnings_comp,
    height = 6
    )

# creating data summary tibble
basic_summary <- tibble(
  variable_type = c("character", "logical", "numeric"),
  n = c(68, 24, 590)
)




