# Health Insurance Charges Analysis

## Project Overview
This project analyzes an open-source health insurance dataset to understand the factors influencing medical insurance charges (premiums). The goal is to provide insights that could help a bank diversify into the health insurance market by identifying key drivers of insurance costs.

---

## Dataset Description
The dataset (`insurance.csv`) contains 1338 observations and 7 attributes describing individuals and their medical costs.

| Attribute | Description                                                                                 |
|-----------|---------------------------------------------------------------------------------------------|
| age       | Age of the primary beneficiary                                                             |
| sex       | Gender of the insurance contract holder (male/female)                                       |
| bmi       | Body Mass Index (kg/m²), indicating body weight relative to height                          |
| children  | Number of children/dependents covered by the insurance                                      |
| smoker    | Smoking status (yes/no)                                                                     |
| region    | Residential area in the US (northeast, southeast, southwest, northwest)                     |
| charges   | Individual medical costs billed by health insurance (the target variable)                   |

---

## Key Steps and Methods

1. **Data Loading and Cleaning**  
   - Loaded dataset using pandas.  
   - Converted categorical variables (`sex`, `smoker`, `region`) into numerical codes for analysis.

2. **Exploratory Data Analysis (EDA)**  
   - Visualized distributions of continuous variables (`age`, `bmi`, `charges`) with histograms and boxplots.  
   - Examined skewness and kurtosis to understand data distribution.  
   - Used correlation heatmaps to identify relationships between variables.

3. **Insights on Key Factors Affecting Charges**  
   - Smoking status strongly correlates with higher insurance charges.  
   - Age and BMI also show influence on medical costs.  
   - Regional differences impact charges; Southeast shows higher costs linked to smoking.  
   - Gender and number of children have additional effects.

4. **Visualizations**  
   - Barplots comparing charges by region, smoking status, gender, and children.  
   - Scatterplots and swarm plots illustrating detailed relationships, e.g., BMI vs charges by sex, charges by smoker status.

5. **Statistical Summaries**  
   - Calculated skewness and kurtosis for numerical features.  
   - Identified outliers and skewed distributions, notably in charges.

---

## Tools and Libraries Used
- Python 3  
- Pandas  
- NumPy  
- Matplotlib  
- Seaborn  
- Scikit-learn (LabelEncoder)  
- Statsmodels & Scipy (for statistical analysis)

---

## How to Run
1. Install required libraries:
   ```bash
   pip install pandas numpy matplotlib seaborn scikit-learn statsmodels scipy
---
2. Place the `insurance.csv` file in your working directory.

3. Run the provided Python scripts or Jupyter notebooks sequentially to reproduce the analysis and visualizations.

---

## Conclusion
This analysis highlights that smoking status is the dominant factor influencing medical insurance charges, followed by age and BMI. Regional and demographic factors also contribute to the variability in costs. These insights can help the bank strategize effectively when entering the health insurance market.

