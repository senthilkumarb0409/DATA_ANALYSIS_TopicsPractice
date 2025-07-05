# 📊 AdventureWorksDataSetDashboard

This repository contains a **Power BI Dashboard** built using the **AdventureWorks Sales Dataset**, showcasing sales performance, customer insights, and return analysis across the years **2020, 2021, and 2022**. All data cleaning, transformation, and modeling have been performed within **Power BI** using **Power Query** and **DAX**.

---

## 📁 Contents

- `AdventureWorksDashboard.pbix`: Main Power BI report file
- Cleaned and modeled data inside Power BI
- Calculated columns and DAX measures
- Interactive dashboard with KPIs and trends
- Star schema data model
- (Optional) Dashboard preview images

---

## 📌 Key Features

- ✅ Sales analysis from 2020 to 2022
- ✅ KPIs: Total Sales, Returns, Profit Margin, YoY Growth
- ✅ Sales breakdown by Product, Category, Sub-Category, Territory
- ✅ Return rate analysis
- ✅ Dynamic slicers for time, products, geography
- ✅ All transformations handled inside Power BI

---

## 🧠 Data Model

Structured as a **star schema** for optimal performance and readability:

- **Sales**: Contains order details including dates, revenue, quantity, etc.
- **Customer**: Customer info including region
- **Product**: Product-level information
- **Category & Subcategory**: Product hierarchy
- **Calendar**: Custom date table for time-based analysis
- **Territory**: Sales regions
- **Returns**: Returned orders data

---

## 🔄 Data Cleaning & Transformation

All cleaning and modeling tasks were done **within Power BI** using Power Query and DAX:

- Removed nulls and duplicates
- Created calculated columns:
  - Full Name (Customer)
  - Year, Quarter, Month Name (Calendar)
- Built relationships between fact and dimension tables
- Used DAX for custom measures, including:
  - `Total Sales`
  - `Total Returns`
  - `Return Rate`
  - `Total Revenue`
  - `etc...`

---

## 📷 Dashboard Preview

1. SALES EXECUTIVE DASHBOARD

![SALES EXECUTIVE DASHBOARD](https://github.com/user-attachments/assets/7bf5ad50-6e2c-4567-86f8-19063cb72eff)

2. LOCATION WISE DASHBOARD
   
![LOCATION WISE DASHBOARD](https://github.com/user-attachments/assets/def080de-de7a-49bb-8c47-7c3f7974a328)

3. PRODUCT WISE DASHBOARD

![PRODUCT WISE DASHBOARD](https://github.com/user-attachments/assets/542cfe4c-db51-4aaa-8705-4b6028b74b58)
   
4. CUSTOMER WISE DASHBOARD

![CUSTOMER WISE DASHBOARD](https://github.com/user-attachments/assets/da850064-20aa-4bc2-9bce-37e1c1292266)

---

## 🚀 How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/AdventureWorksDataSetDashboard.git
2.Open AdventureWorksDashboard.pbix using Power BI Desktop.

3.Explore the report, visuals, data model, and DAX measures.

## 🎯 Objective

> This project was created to:

> Showcase practical data analysis and visualization skills

> Demonstrate ability to perform end-to-end BI reporting in Power BI

> Practice building interactive dashboards with business-relevant KPIs

Highlight knowledge of data modeling, DAX, and Power Query








