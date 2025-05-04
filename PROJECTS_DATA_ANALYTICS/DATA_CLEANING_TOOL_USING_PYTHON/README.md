# 🧹 Data Cleaning Tool (CSV Cleaner)

A comprehensive Python-based tool for **automated data cleaning**, preprocessing, validation, and reporting — designed to streamline the process of cleaning raw CSV files for further data analysis.

---

## 📌 Features

- ✅ Load and explore any CSV dataset  
- 🧼 Clean column names and standardize string formatting  
- 🗑️ Remove duplicates  
- ❓ Detect and handle missing values  
- 🔁 Impute missing values in `PRICE`, `QUANTITY`, and `TOTAL SPENT`  
- 🧠 Validate data (e.g., duplicate IDs, negative ages)  
- 📊 Suggest optimal data types (e.g., `category`, `int`)  
- 📈 Detect highly correlated numeric features  
- 🧮 Detect outliers using IQR method  
- 🔍 Check for duplicate columns  
- 📝 Auto-generate a data cleaning report  
- 💾 Save cleaned dataset to a new CSV file  

---

## 🗂️ Project Structure

```
data_cleaning_tool/
│
├── data_cleaning_tool.py         # Main cleaning script
├── handle_specific_values.py     # Helper script for PRICE, QUANTITY, TOTAL SPENT logic
├── cleaning_report.txt           # Auto-generated report
└── README.md                     # This file
```

---

## 🛠️ Requirements

- Python 3.7+
- pandas
- numpy

Install the dependencies:

```bash
pip install pandas numpy
```

---

## 🚀 How to Use

1. Run the script:

```bash
python data_cleaning_tool.py
```

2. Enter the path to your input CSV file when prompted:

```
Enter the path to your CSV file: dataset.csv
```

3. The tool will:
   - Load and explore the data
   - Clean it automatically
   - Ask for a name to save the cleaned dataset
   - Generate a cleaning report

---

## 📄 Output

- `cleaned_data.csv` (or custom name): Cleaned CSV file
- `cleaning_report.txt`: Detailed summary of the cleaning steps taken

---

## ⚙️ Customization

The script currently includes custom handling logic for the following columns:
- `PRICE`, `QUANTITY`, `TOTAL SPENT`
- `AGE`, `ID`, `ITEM`, `PAYMENT METHOD`, `LOCATION`

If your dataset uses different column names, you may update the logic or generalize it for automatic detection.

---

## 📌 Next Steps (Planned Improvements)

- Generalize to support any tabular dataset
- Visualize missing values and outliers

---

## 🧑‍💻 Author

Built with ❤️ by **Senthil Kumar.B**  
For educational and portfolio purposes
