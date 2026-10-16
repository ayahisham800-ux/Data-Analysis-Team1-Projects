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

- **Sales & Profitability:** Total Sales, Total Profit, Profit Margin %, Average Profit, Average Order Value.
- **Volume Metrics:** Total Orders, Total Quantity, Total Customers.
- **Operational Metrics:** Return Rate %, Returned Orders, Average Customer Satisfaction.
- **Time Intelligence & Advanced DAX:** Sales YTD, YoY Growth, Running Total, Top N Products Rank.

### 4. Dashboard UI/UX Design & Data Visualization (Shorouk)

- **UI/UX & Interface Design:** Designed a modern, interactive Power BI interface utilizing "Glassmorphism" design principles and custom cover pages to enhance user experience.
- **Color Theme Standardization:** Implemented a unified, accessible monochromatic color palette (Pastel/Purple tones) to ensure visual consistency and reduce cognitive load.
- **Dynamic Visualizations:** Built multi-page analytical reports (Sales, Operations, Customers) integrating advanced visuals such as Decomposition Trees, Ribbon Charts, and Waterfall charts.
- **Report Navigation:** Created seamless page navigation using buttons and bookmarks for intuitive data exploration across different business levels.
  
### 5. Project Management & Data Governance (Aya Hisham)

* Managed project timelines and delegated technical tasks.
* Coordinated cross-functional work between ETL, Data Modeling, and DAX phases.
* Compiled the final Handover Documentation and presentation materials.
* **Data Security:** Implemented Row-Level Security (RLS) within the data model to restrict access based on geographical regions (Central, East, North, South, West).
* **App Deployment:** Published the interactive report to Power BI Service and distributed it via a Power BI App. "https://app.powerbi.com/Redirect?action=OpenApp&appId=664b4c86-afd5-40c2-ab13-04f4ff71f9bd&ctid=291a3013-319f-4cf9-9e78-071b3f2d4944&experience=power-bi"
  > *Note: App access is currently set to 'Entire Organization' for evaluation purposes. In a real-world scenario, it would be restricted to specific stakeholders.*
* **Gateway & Refresh:** Configured the On-premises Data Gateway. 
