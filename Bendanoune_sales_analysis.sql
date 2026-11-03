USE sample_sales;


SELECT ROUND((SUM(Sale_Amount) + SUM(SalesTotal)), 2) AS Total, MIN(Transaction_Date) as `Start Date` , MAX(Transaction_Date) AS `End Date`
FROM Store_Sales s
JOIN Store_Locations l
JOIN Online_Sales o
ON s.Store_ID = l.StoreId = o.id
WHERE State = 'New York';