# 📊 ETL Ecommerce Sales Analysis — Python + SQL + Power BI

An end-to-end data analysis project: raw, messy ecommerce order data is cleaned and enriched in **Python (Pandas)**, loaded into a **SQL** database for querying, and visualized in an interactive **Power BI** dashboard.

```
Excel (Dirty Data) → Python (Pandas) → SQL Database → Power BI Dashboard
```


---

## 🛠️ Tech Stack

- **Python** — Pandas, NumPy (data cleaning, feature engineering)
- **SQLAlchemy + PyMySQL** — loading clean data into MySQL
- **SQL** — joins, aggregations, business-question queries
- **Power BI** — DAX measures, interactive dashboard, slicers

---

## 📁 Files in this repo

| File | Description |
|---|---|
| `ecommerce_unclean_data.xlsx` | Original raw dataset |
| `data_cleaning_and_eda.ipynb` | Pandas cleaning, EDA & feature engineering |
| `ecommerce_cleaned_data.csv` | Final cleaned dataset (exported from Python) |
| `sql_queries.sql` | Analysis queries |
| `ecommerce_sales_dashboard.pbix` | Power BI dashboard file |
| `dashboard_screenshot.png` | Preview image of the dashboard |
| `project_workflow.md` | Full step-by-step breakdown of the pipeline |

---

## 🧹 Data Cleaning Highlights

- Removed duplicate records and invalid rows (negative quantities, malformed emails)
- Standardized text fields (`Customer_Name`, `City`, `State`) to proper case
- Converted date and numeric columns with error handling
- Filled missing values with sensible defaults (`Discount → 0`, `Phone → "Unknown"`)
- Engineered new columns: `Sales`, `Net_Amount`, `Profit`, `Month`, `Year`, `Weekday`

Full details in [`project_workflow.md`](project_workflow.md).

---

## 🗄️ SQL Analysis

Business questions answered via SQL, including:
- Total orders & total sales
- Top-performing products and cities
- Monthly sales trend
- Highest-profit products
- Payment mode distribution
- Cancelled order lookup

See [`sql_queries.sql`](sql_queries.sql) for all queries.

---

## 📈 Power BI Dashboard

Built on top of the SQL `orders` table, with DAX measures for Total Sales, Total Profit, Total Orders, and Average Order Value.

**Visuals included:**
- KPI cards
- Monthly sales trend (line)
- Sales by category / product / city
- Payment mode distribution (donut)
- Order status (pie)
- Profit by category (stacked column)
- Slicers: Year, Month, Category, City, Payment Mode

---
