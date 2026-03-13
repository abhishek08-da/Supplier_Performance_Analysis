SELECT * FROM sales
LIMIT 5;

SELECT * FROM purchases
LIMIT 5;

SELECT * FROM purchase_prices
LIMIT 5;

SELECT * FROM begin_inventory
LIMIT 5;

SELECT * FROM end_inventory 
LIMIT 5;

SELECT * FROM vendor_invoice
LIMIT 5;



-- Check for duplicate sales records
SELECT
inventoryid,
salesdate,
COUNT(*) AS record_count
FROM sales
GROUP BY inventoryid, salesdate
HAVING COUNT(*) > 1;



-- Check for invalid purchase records
SELECT *
FROM purchases
WHERE quantity <= 0 OR dollars <= 0;



-- This query checks how many records are present in each main table
-- So that we know how big the data is before analysis
SELECT 'sales' AS table_name, COUNT(*) AS total_rows FROM sales
UNION ALL
SELECT 'purchases', COUNT(*) FROM purchases
UNION ALL
SELECT 'vendor_invoice', COUNT(*) FROM vendor_invoice;



-- This query checks the starting and ending date of sales data
-- It helps to understand the time period covered in the dataset
SELECT 
MIN(salesdate) AS start_date,
MAX(salesdate) AS end_date
FROM sales;



-- This query checks how many unique vendors, brands, and stores are present
-- It helps to understand the structure of the data before joining tables
SELECT
COUNT(DISTINCT vendorno) AS total_vendors,
COUNT(DISTINCT brand) AS total_brands,
COUNT(DISTINCT store) AS total_stores
FROM sales
UNION ALL
SELECT
COUNT(DISTINCT vendornumber) AS total_vendors,
COUNT(DISTINCT brand) AS total_brands,
COUNT(DISTINCT store) AS total_stores
FROM purchases;



-- This query checks minimum, maximum and average sales price
-- It helps to find unusually high or low prices
SELECT
MIN(salesprice),
MAX(salesprice),
AVG(salesprice)
FROM sales;



-- This query checks which brands are present in sales data
-- but do not have matching records in the purchases table.
-- This helps to identify brands sold from opening inventory
-- or from purchases that are not available in the current dataset.
SELECT DISTINCT s.brand FROM sales s
LEFT JOIN purchases p 
ON s.brand = p.brand
WHERE p.brand IS NULL;