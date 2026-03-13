
-- This query shows how much quantity and cost was purchased
-- for each brand at different purchase prices
SELECT brand, purchaseprice,
SUM(quantity) AS total_quantity,
SUM(dollars) AS total_dollars
FROM purchases
GROUP BY brand, purchaseprice;



-- Count distinct PO numbers
SELECT COUNT(DISTINCT ponumber) FROM vendor_invoice;



-- This query calculates total sales revenue, average selling price,
-- and total quantity sold for each brand.
SELECT
brand,
SUM(salesdollars) AS total_sales_revenue,
AVG(salesprice) AS avg_sales_price,
SUM(salesquantity) AS total_quantity_sold
FROM sales
GROUP BY brand
ORDER BY total_sales_revenue DESC;



-- This query compares total purchase cost and total sales revenue
-- for each brand to calculate profit.
SELECT
s.brand,
SUM(s.salesdollars) AS total_sales,
SUM(p.dollars) AS total_purchase_cost,
SUM(s.salesdollars) - SUM(p.dollars) AS profit
FROM sales s
JOIN purchases p
ON s.brand = p.brand
GROUP BY s.brand
ORDER BY profit DESC
LIMIT 10;


-- This query calculates total freight (delivery) cost
-- paid to each vendor.
SELECT
vendornumber,
vendorname,
SUM(freight) AS total_freight_cost
FROM vendor_invoice
GROUP BY vendornumber, vendorname
ORDER BY total_freight_cost DESC;


-- This query calculates total purchased quantity and cost for each brand
-- while excluding records where purchase price is zero.
SELECT
brand,
SUM(quantity) AS total_purchase_quantity,
SUM(dollars) AS total_purchase_dollars
FROM purchases
WHERE purchaseprice > 0
GROUP BY brand
ORDER BY total_purchase_dollars DESC;