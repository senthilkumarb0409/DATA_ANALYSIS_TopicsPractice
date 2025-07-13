# Heart Disease Exploratory Data Analysis

## Description
This project performs exploratory data analysis (EDA) on a heart disease dataset (`heart.csv`). The aim is to analyze key health-related features and understand their relationships with heart disease diagnosis. The analysis uses Python libraries such as Pandas, Matplotlib, and Seaborn to visualize and summarize the data.

## Dataset Features
The dataset contains the following columns:
- Age  
- Sex  
- Chest Pain  
- Blood Pressure  
- Cholesterol  
- Diabetes  
- ECG Result  
- Max Heart Rate  
- Angina  
- ST Depression  
- ST Slope  
- Number of Major Vessels Colored  
- Thalassemia Status  
- Diagnosis (0 = Normal, 1 = Diseased)

## EDA File Features (`heart_eda.py`)
- Data loading and cleaning  
- Summary statistics of key variables  
- Histograms and boxplots for distribution analysis  
- Countplots for categorical variables  
- Comparative visualizations by diagnosis groups  
- Linear regression fits to explore relationships between features  
- Pairplots to visualize correlations among multiple features  

---

## Setup Instructions
Install required packages with:

```bash
pip install pandas numpy matplotlib seaborn
