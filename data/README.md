## Datasets


the data for this project was sourced from the Malawi Longitudinal Study of Families and Health (MLSFH) (ICPSR 20840) which was requested and downloaded from Data Sharing for Demographic Research (DSDR), a Population Health Data Archive ([see website here](https://www.icpsr.umich.edu/web/DSDR/studies/20840).

# Original data
- `malawi_data_wave_1.tsv` 
- `malawi_data_wave_2.tsv`

# Codebook

m2we5b - Monthly earnings
wb5a - Ever been to school
wb5b - Highest Level of School
wb5c - Years completed at educational institution
wb6 - Respondent's religion
wb7 - Respondent's ethnic group
wb1 - Year Respondent Born
wb2 - Marital Status
wb2a - Husb has more than one wife
wc5 - Desired # of children

# Processed datasets
 - **my_metrics.rda**: rda file containing metrics to be used to fit the resampled data
 - **malawi_train.rda**: rda file containing the malawi_train data set (the training set)
 - **malawi_test.rda**: rda file containing the malawi_test data set (the testing set)
 - **malawi_split.rda**: rda file containing malawi_split which contains the results of the split on the malawi_data set. (it holds both the training and testing set)
 - **malawi_folds.rda**: rda file containing split resamples of the malawi_data
 - **malawi_data.rda**: rda file containing the created dataset, with the monthly earnings column from Wave 2 data added to the Wave 1 dataset.
 - **keep_wflow.rda**: rda file containing controls to be used to fit the resampled data



