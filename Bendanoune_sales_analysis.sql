USE sample_sales;

-- 1) What is total revenue overall for sales in the assigned territory, plus the start date and end date that tell you what period the data covers?


SELECT ROUND(SUM(s.Sale_Amount), 2) AS total_revenue, MIN(s.Transaction_Date)      AS start_date, MAX(s.Transaction_Date)      AS end_date
FROM Store_Sales s
JOIN Store_Locations l
ON s.Store_ID = l.StoreId
WHERE l.State = 'New York';

-- 2) What is the revenue breakdown by year and month for the sales territory?


SELECT YEAR(s.Transaction_Date)  AS sale_year, MONTH(s.Transaction_Date) AS sale_month, ROUND(SUM(s.Sale_Amount), 2) AS total_revenue
FROM Store_Sales s
JOIN Store_Locations l
ON s.Store_ID = l.StoreId
WHERE l.State = 'New York'
GROUP BY YEAR(s.Transaction_Date), MONTH(s.Transaction_Date)
ORDER BY sale_year, sale_month;



-- 3) Provide a comparison of total revenue for the specific sales territory and the region it belongs to.

-- We have New york and Connecticut at the same region East
-- Sale amount for the whole region = 6723039.53, and for New your by itself 4330817.09 
-- almost 64.5% of the sales in the east region is from new york


SELECT COALESCE(l.State, 'East Total') AS state, ROUND(SUM(s.Sale_Amount), 2) AS revenue
FROM Store_Sales s
JOIN Store_Locations l ON s.Store_ID = l.StoreId
JOIN Management m ON l.State = m.State
WHERE m.Region = 'East'
GROUP BY l.State WITH ROLLUP;

-- 4) What is the number of transactions per month and average transaction amount by product category for the sales territory?


SELECT YEAR(s.Transaction_Date)  AS `Year`, MONTH(s.Transaction_Date) AS `Month`, COUNT(s.id) AS Number_Of_Transactions, ROUND(AVG(s.Sale_Amount),2) as Avg_Transaction_Amount, i.Category
FROM Store_Sales s
JOIN Products p ON p.ProdNum = s.Prod_Num
JOIN Inventory_Categories i ON p.Categoryid = i.Categoryid
JOIN Store_Locations l ON l.StoreId = s.Store_ID
WHERE l.State = 'New York'
GROUP BY YEAR(s.Transaction_Date), MONTH(s.Transaction_Date), i.Category
ORDER BY YEAR(s.Transaction_Date), MONTH(s.Transaction_Date), i.Category;

-- This query to make sure the our count is correct 

SELECT COUNT(*), COUNT(s.id)
FROM Store_Sales s
JOIN Store_Locations l ON s.Store_ID = l.StoreId
WHERE l.State = 'New York';

-- 5) Can you provide a ranking of in-store sales performance by each store in the sales territory, or a ranking of online sales performance by state within an online sales territory?

SELECT l.StoreLocation, ROUND(SUM(Sale_Amount), 2) AS Total_sales, State
FROM Store_Sales s
JOIN Store_Locations l
ON s.Store_ID = l.Storeid
WHERE l.State = 'New York'
GROUP BY l.StoreLocation
ORDER BY Total_sales DESC;

-- This query to make sure we don't have two stores at the same city
SELECT StoreId, StoreLocation 
FROM Store_Locations 
WHERE State = 'New York';

-- This query to make sure the total sales match the result from Q1
SELECT ROUND(SUM(Total_sales), 2) AS all_stores_total
FROM (
SELECT l.StoreLocation, SUM(s.Sale_Amount) AS Total_sales
FROM Store_Sales s
JOIN Store_Locations l
ON s.Store_ID = l.StoreId
WHERE l.State = 'New York'
GROUP BY l.StoreLocation) AS store_totals;

-- 6) What is your recommendation for where to focus sales attention in the next quarter?

-- This query shows revenue per quarter
SELECT YEAR(s.Transaction_Date) AS sale_year, QUARTER(s.Transaction_Date) AS sale_quarter, ROUND(SUM(s.Sale_Amount), 2) AS revenue
FROM Store_Sales s
JOIN Store_Locations l 
ON s.Store_ID = l.StoreId
WHERE l.State = 'New York'
GROUP BY YEAR(s.Transaction_Date), QUARTER(s.Transaction_Date)
ORDER BY sale_year, sale_quarter;


/* RECOMMENDATION: where to focus sales attention next quarter

Focus on: protecting and growing Technology & Accessories, led by the two
flagship stores (New York and Rochester), while lifting the weakest stores
(Elmira and Queens).

Why:
- Revenue is growing. The NYC territory earned 4,330,817.09 overall (about 64%
  of the East region, 6,723,039.53). Annual revenue rose from 687K (2022) to
  1.04M (2023), stayed flat in 2024, then reached 1.55M in 2025 (+48%).
- Q4 2025 was the best quarter (440,455.29), up 83% from Q4 2024. Technology &
  Accessories drove about 83% of that increase and made up about 75% of all
  Q4 2025 revenue (329,555 of 440,455), so it is the engine of growth.
- Sales are concentrated in two stores. New York (621,565) and Rochester
  (607,148) earn about twice what any other store earns, and together make up
  about 28% of territory revenue.
- Elmira only grew 4% in Q4 2025 while the other stores grew 38% to 186%, and
  it is now the lowest store that quarter (24,312). Queens is the lowest store
  overall (288,553) and had the second-smallest growth (+38%).

Risk: one category makes up about 75% of the quarter, so a dip in Technology &
Accessories would hurt the whole territory. Textbooks is the next-largest
category (59,156, about 13%) and grew only 16%.

Actions for next quarter:
1. Make sure the flagship stores have enough Technology & Accessories stock
   and promotions to keep the momentum going.
2. Review Elmira and Queens (staffing, local promotions, product mix) to
   bring them closer to the other stores.
3. Push Textbooks to reduce the dependence on one category.
*/
