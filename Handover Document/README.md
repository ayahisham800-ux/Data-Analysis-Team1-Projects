# 📊 Retail Sales Performance & Executive Analytics

## 👥 Team Members & Roles
- **Aya Hisham:** Team Leader & Project Management
- **Rayan Mohamed:** Data Cleaning & ETL Engineer
- **Ahmed Maher:** Data Modeling Specialist
- **Aya Anwar:** DAX Analyst
- **Shorouk Soliman:** Dashboard UI Designer

## 🎯 Project Overview
This project provides an end-to-end business intelligence solution using Power BI to analyze retail sales performance. It processes over 4,000 sales transactions to deliver actionable insights into profitability, customer demographics, and operational efficiency.

## 🛠️ Project Phases & Execution

### 1. Data Preparation & ETL (Rayan)
- **Folder Connector:** Split historical data into 5 yearly files and loaded them automatically using the Folder Connector.
- **Combine & Transform:** Merged all files into a single master dataset, properly configuring delimiters.
- **Data Cleansing:** Standardized text data using `Trim`, `Clean`, and `Capitalize Each Letter` transformations.
- **Formatting:** Added custom columns, corrected data types, and resolved raw data inconsistencies.

### 2. Data Modeling (Ahmed)
- Designed an optimized **Star Schema** to ensure high performance and clear analytical paths.
- **Fact Table:** `Fact_Sales_Data`
- **Dimension Tables:** Connected via 1-to-many relationships:
  - `DimDate`
  - `DIM_Customer`, `DIM_Gender`, `DIM_City`, `DIM_Region`
  - `DIM_Product_Category`, `DIM_Payment_Method`
  - `DIM_Order_Status`, `DIM_Return_Flag`

### 3. DAX Measures (Aya Anwar)
Developed advanced analytical measures to calculate key business metrics:
- **Sales & Profitability:** `Total Sales`, `Total Profit`, `Profit Margin %`, `Average Profit`, `Average Order Value`.
- **Volume Metrics:** `Total Orders`, `Total Quantity`, `Total Customers`.
- **Operational Metrics:** `Return Rate %`, `Returned Orders`, `Average Customer Satisfaction`.
- **Time Intelligence:** `Sales YTD`.

### 4. Dashboard UI/UX Design (Shorouk)
- Designed the overall layout, theme, and user experience (UX) framework for the dashboard pages.
- Prepared the structural canvas to host the final data visualizations and executive summaries.

### 5. Project Management (Aya Hisham)
- Managed project timelines and delegated technical tasks.
- Coordinated cross-functional work between ETL, Data Modeling, and DAX phases.
- Compiled the final Handover Documentation and presentation materials.
