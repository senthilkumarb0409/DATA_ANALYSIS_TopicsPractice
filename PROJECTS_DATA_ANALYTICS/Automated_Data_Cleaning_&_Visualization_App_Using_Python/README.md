# 🧹 Automated Data Cleaning & Visualization App

An intelligent Streamlit-based Python application to clean, process, and visualize messy CSV datasets — automatically!

Whether you're a data analyst, student, or business professional, this tool helps you handle missing values, detect outliers, convert data types, suggest visualizations, and download clean data and reports — all without writing a single line of code.

---

## 🚀 Key Features

- 📊 **Smart Data Summary** – Preview dataset with clear column-level insights and missing value indicators.
- 🧠 **AI-Powered Suggestions** – Get intelligent recommendations (using tools like ChatGPT, Claude AI) for:
  - Filling missing values (Mean / Median / Mode)
  - Outlier removal
  - Data type conversions
  - Inconsistent values
- 🧼 **One-Click Cleaning** – Choose suggestions and clean your data with one click.
- 📈 **Dynamic Visualizations** – Interactive chart builder with dropdowns that auto-filter valid columns based on chart type.
- 📥 **Download Clean Data** – Export cleaned CSV instantly.
- 🧾 **Download Summary Report** – Automatically generated TXT report summarizing changes made (e.g., imputations, outliers removed, type fixes).
- ⚡ **Optimized for Performance** – Handles large CSVs and complex processing quickly.

---

## 🛠️ Tech Stack

| Tool/Library     | Purpose                              |
|------------------|--------------------------------------|
| **Python**       | Core backend logic                   |
| **Streamlit**    | Interactive web app interface        |
| **Pandas**       | Data handling and transformation     |
| **NumPy**        | Numerical processing                 |
| **Matplotlib / Plotly** | Data visualizations        |
| **Regex (re)**   | Intelligent pattern-based cleaning   |
| **ChatGPT + Claude AI** | Used during development for logic & optimization

---

```markdown
## 📚 Usage Instructions

1. **Upload a CSV File**
   - You can upload any structured or semi-structured `.csv` dataset.

2. **Data Summary**
   - View shape, column info, missing counts, and data types.

3. **Handle Missing Values**
   - AI-powered suggestions (mean/median/mode) per column.
   - Apply selected strategy and preview changes.

4. **Outlier Detection**
   - Intelligent detection using IQR or Z-score methods.
   - Choose to remove or retain outliers.

5. **Fix Data Types**
   - Get suggestions for columns with incorrect types (e.g., dates, numbers as text).
   - Apply with one click.

6. **Resolve Inconsistencies**
   - Detect empty strings, “unknown”, typos, etc.
   - Suggest fixes based on patterns.

7. **Dynamic Visualizations**
   - Select chart type: bar, line, scatter, histogram, pie, etc.
   - App dynamically enables valid X/Y axis options.
   - Charts rendered instantly.

8. **Download**
   - ✅ Cleaned CSV File
   - 🧾 Text Summary Report of all changes

---



Made with ❤️ by SENTHIL KUMAR .B



