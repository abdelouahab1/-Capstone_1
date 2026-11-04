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

