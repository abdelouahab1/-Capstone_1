# Capstone 1: Sales Territory Analysis (New York)

**Author:** Abdelouahab Bendanoune
**Program:** Year Up United, Data Analytics Training Academy (Week 4 Capstone: Data Storytelling, Excel & SQL)

## Project Overview

EmporiUm is a growing student bookstore chain that also sells tech products, art supplies, and other merchandise in stores and online. This project analyzes the sales of one territory for a sales manager, using SQL (MySQL) for the analysis and Excel for a PivotChart.

## Territory Analyzed

| | |
|---|---|
| **Territory** | New York (in-store) |
| **Region** | East (New York and Connecticut) |
| **Store manager** | See Ellefson |
| **Regional director** | Ana Jilani |

New York is an in-store territory: its state appears in `Store_Locations`, while the online-only states do not. The in-store and online sales tables were never combined, because they are separate channels.

## Questions Answered

The sales manager asked the following questions. Each is answered in the SQL script.

1. Total revenue for the territory, plus the start and end dates of the data
2. Revenue by year and month
3. Territory revenue compared with the East region
4. Number of transactions per month and average transaction amount by product category
5. Ranking of in-store sales performance by store
6. Recommendation for where to focus sales attention next quarter

## Key Findings

- **Total revenue:** 4,330,817.09 across 2022 to 2025.
- **Share of region:** New York is about 64% of East region revenue (6,723,039.53); Connecticut makes up the rest.
- **Growth:** annual revenue went from about 687K (2022) to about 1.04M (2023), stayed flat in 2024, and reached about 1.55M in 2025 (+48%).
- **Best quarter:** Q4 2025 (440,455.29), up 83% from Q4 2024.
- **Category driver:** Technology & Accessories made up about 75% of Q4 2025 revenue and about 83% of the Q4 year-over-year increase.
- **Stores:** the New York (621,565.02) and Rochester (607,148.21) stores each earn about twice as much as any other store. Queens has the lowest total revenue (288,553.14), and Elmira's growth in Q4 2025 (+4%) was far behind the other stores.

**Recommendation:** protect and grow Technology & Accessories, led by the two flagship stores, while lifting the weakest stores and reducing dependence on a single category. The full reasoning is in the comments of the SQL script.

## Repository Contents

| File | Description |
|---|---|
| `Bendanoune_sales_analysis.sql` | Queries for the six territory questions, with comments and the recommendation |
| `Bendanoune_territory_chart.xlsx` | Excel file with the PivotChart based on exported query results |
| `README.md` | This file |

## Tables Used

- `Store_Sales`: in-store transactions
- `Store_Locations`: store city and state
- `Products` and `Inventory_Categories`: product categories
- `Management`: region, regional director, and store manager by state

## PivotChart

*Working on it*

## Video Demo

*Working on it*

## How to Run

1. Run `sample_sales.sql` in MySQL Workbench to create the `sample_sales` database.
2. Open `Bendanoune_sales_analysis.sql` and run each query in order.
3. Open the `Bendanoune_territory_chart.xlsx` file to view the PivotChart.

## Tools

MySQL Workbench, Excel (PivotChart), Git and GitHub