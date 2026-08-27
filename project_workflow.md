# Project Workflow — Ecommerce Sales Analysis

This document walks through the full pipeline used in this project, from raw Excel data to the final Power BI dashboard.

```
Excel (Dirty Data)
        ↓
Python (Pandas) — Cleaning
        ↓
Feature Engineering
        ↓
Export Clean Data
        ↓
SQL Database
        ↓
SQL Analysis
        ↓
Power BI Dashboard
```

---

## 1. Import Libraries & Load Data

```python
import pandas as pd
import numpy as np

df = pd.read_excel("ecommerce_unclean_data.xlsx")
```

**First look at the data:**
```python
df.head()
df.info()
df.describe()
df.shape
```

---

## 2. Check Missing Values & Duplicates

```python
df.isnull().sum()
df.duplicated().sum()
df.drop_duplicates(inplace=True)
```

---

## 3. Replace N/A and NULL placeholders

```python
df.replace(["N/A", "NULL", " "], np.nan, inplace=True)
```

---

## 4. Remove Extra Spaces

```python
df = df.apply(lambda x: x.str.strip() if x.dtype == "object" else x)
```

---

## 5. Standardize Text Case

```python
df["Customer_Name"] = df["Customer_Name"].str.title()
df["City"] = df["City"].str.title()
df["State"] = df["State"].str.title()
```

---

## 6. Fix Invalid Emails

```python
df = df[df["Email"].str.contains("@", na=False)]
```

---

## 7. Convert Date Columns

```python
df["Order_Date"] = pd.to_datetime(df["Order_Date"], errors="coerce")
df["Delivery_Date"] = pd.to_datetime(df["Delivery_Date"], errors="coerce")
```

---

## 8. Convert Numeric Columns

```python
cols = ["Qty", "Unit_Price", "Discount"]
for c in cols:
    df[c] = pd.to_numeric(df[c], errors="coerce")
```

---

## 9. Remove Invalid Quantities

```python
df = df[df["Qty"] > 0]
```

---

## 10. Fill Missing Values

```python
df["Discount"].fillna(0, inplace=True)
df["Phone"].fillna("Unknown", inplace=True)
df["Delivery_Date"].fillna(df["Order_Date"], inplace=True)
```

---

## 11. Feature Engineering — New Columns

```python
df["Sales"] = df["Qty"] * df["Unit_Price"]
df["Net_Amount"] = df["Sales"] - (df["Sales"] * df["Discount"] / 100)
df["Profit"] = df["Net_Amount"] * 0.20          # example margin assumption
df["Month"] = df["Order_Date"].dt.month_name()
df["Year"] = df["Order_Date"].dt.year
df["Weekday"] = df["Order_Date"].dt.day_name()
```

---

## 12. Final Check

```python
df.info()
df.isnull().sum()
df.describe()
```

---

## 13. Export Clean Data

```python
df.to_excel("Clean_Ecommerce.xlsx", index=False)
# or
df.to_csv("Clean_Ecommerce.csv", index=False)
```

---

## 14. Load into SQL (MySQL)

```bash
pip install sqlalchemy
pip install pymysql
```

```python
from sqlalchemy import create_engine

engine = create_engine("mysql+pymysql://root:password@localhost/ecommerce")

df.to_sql(
    name="orders",
    con=engine,
    if_exists="replace",
    index=False
)
```

This pushes the entire cleaned DataFrame directly into a MySQL table called `orders`.

---

## 15. SQL Analysis

**Total Orders**
```sql
SELECT COUNT(*) FROM orders;
```

**Total Sales**
```sql
SELECT SUM(Net_Amount) FROM orders;
```

**Top Products**
```sql
SELECT Product, SUM(Net_Amount)
FROM orders
GROUP BY Product
ORDER BY 2 DESC;
```

**Top Cities**
```sql
SELECT City, SUM(Net_Amount)
FROM orders
GROUP BY City;
```

**Monthly Sales**
```sql
SELECT Month, SUM(Net_Amount)
FROM orders
GROUP BY Month;
```

**Highest Profit Product**
```sql
SELECT Product, SUM(Profit)
FROM orders
GROUP BY Product
ORDER BY 2 DESC;
```

**Payment Mode Breakdown**
```sql
SELECT Payment_Mode, COUNT(*)
FROM orders
GROUP BY Payment_Mode;
```

**Cancelled Orders**
```sql
SELECT * FROM orders
WHERE Order_Status = 'Cancelled';
```

---

## 16. Power BI Dashboard

**Data source:** SQL table `orders` (imported directly via Power BI's SQL Server/MySQL connector)

**Relationships:** none required for a single table; set up if more tables are added later.

**DAX Measures:**
```dax
Total Sales = SUM(orders[Net_Amount])
Total Profit = SUM(orders[Profit])
Total Orders = COUNT(orders[Order_ID])
Average Order Value = DIVIDE([Total Sales], [Total Orders])
```

**Dashboard visuals:**
- KPI Cards — Total Sales, Total Orders, Total Profit, Average Order Value
- Monthly Sales Trend (Line Chart)
- Sales by Category (Bar Chart)
- Sales by Product (Column Chart)
- Sales by City (Map / Bar)
- Payment Mode Distribution (Donut)
- Order Status (Pie Chart)
- Top 10 Products (Bar)
- Profit by Category (Stacked Column)

**Slicers:** Year, Month, Category, City, Payment Mode

See `dashboard_screenshot.png` for the final result.
