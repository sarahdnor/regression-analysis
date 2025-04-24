## Scripts

# Scripts
- `0_target_var_analysis.r`: script including the analysis of the target variable `monthly_earnings`
- `1_initial_split.r`: Script including the initial data split and the creation of resamples.
- `2_lm_recipes.r`: Script containing recipes for linear regression models (alongside the recipe for the null model)
- `2_rf_recipes.r`: Script containing recipes for tree based and k-nearest neighbors models
- `3_null_fit.r`: Script containing fitted null model
- `4_model_comparison.r`: Script containing metrics and model comparisons to determine the best model and its optimal hyperparameters
- `5_fitting_final_model.r`: Script where the final (best) model is fitted to the entire training set
- `6_final_model_analysis.r`: Script where the final model metrics are calculated and assessment of model is conducted


# Folders

- [`3_bt_fits/`](3_bt_fits): Contains all the scripts used for tuning the boosted tree models to the different recipes
- [`3_en_fits/`](3_en_fits):  Contains all the scripts used for tuning the elastic net models to the different recipes
- [`3_knn_fits/`](3_knn_fits): Contains all the scripts used for tuning the k-nearest neighbors models to the different recipes
- [`3_lm_fits/`](3_lm_fits): Contains all the scripts used for fitting the ordinary linear model to the different recipes
- [`3_rf_fits/`](3_rf_fits): Contains all the scripts used for tuning the random forest models to the different recipes
