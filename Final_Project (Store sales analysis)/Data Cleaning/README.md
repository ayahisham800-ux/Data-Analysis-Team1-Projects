# Rossmann Store Sales

## Data Preparation and Exploratory Data Analysis

### Project Overview

This project focuses on data preparation, cleaning,
feature engineering, and exploratory data analysis
of the Rossmann Store Sales dataset.

### Source Datasets

- Train: 1,017,209 rows and 9 columns.
- Test: 41,088 rows and 8 columns.
- Store: 1,115 rows and 10 columns.

### Data Preparation

- Standardized column names and data types.
- Converted date columns.
- Checked duplicate records.
- Added missing-value indicators.
- Preserved structurally missing Promo2 information.
- Preserved unknown competition information.
- Created competition and promotion features.
- Merged sales data with store information.
- Validated row counts and Store relationships.

### Exploratory Data Analysis

The analysis includes:

- Monthly sales trends.
- Average sales by day of week.
- Promotion analysis.
- Store type comparison.
- Customers vs. sales.
- Competition distance analysis.
- State holiday analysis.
- Assortment analysis.

### Important Data Notes

- Missing Open values in Test were preserved and flagged.
- Missing Promo2 values for stores not enrolled in Promo2
  were preserved.
- Missing competition information was not artificially imputed.
- Outliers were not automatically removed.
- Descriptive associations do not establish causation.

### Output Files

- train_cleaned.csv
- test_cleaned.csv
- store_cleaned.csv
- train_merged.csv
- test_merged.csv
- figures/
- reports/

### Tools

Python, Pandas, NumPy, Matplotlib, Seaborn, Google Colab.
