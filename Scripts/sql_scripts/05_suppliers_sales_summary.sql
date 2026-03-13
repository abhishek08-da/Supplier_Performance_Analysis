-- This query creates a consolidated summary by combining
-- purchase data, sales data, pricing information, and freight cost
-- at vendor and brand level for performance analysis.


CREATE OR REPLACE VIEW suppliers_sales_summary AS
WITH FreightSummary AS (
    SELECT
    vendornumber,
    SUM(freight) AS freight_cost
    FROM vendor_invoice
    GROUP BY vendornumber
),

PurchaseSummary AS (
    SELECT
        p.vendornumber,
        p.vendorname,
        p.brand,
        p.description,
        p.purchaseprice,
        pp.price AS actual_price,
        pp.volume,
        SUM(p.quantity) AS total_purchase_quantity,
        SUM(p.dollars) AS total_purchase_dollars
    FROM purchases p
    JOIN purchase_prices pp
    ON p.brand = pp.brand
    WHERE p.purchaseprice > 0
    GROUP BY
        p.vendornumber,
        p.vendorname,
        p.brand,
        p.description,
        p.purchaseprice,
        pp.price,
        pp.volume
),

SalesSummary AS (
    SELECT
        vendorno,
        brand,
        SUM(salesquantity) AS total_sales_quantity,
        SUM(salesdollars) AS total_sales_dollars,
        AVG(salesprice) AS total_sales_price,
        SUM(excisetax) AS total_excise_tax
    FROM sales
    GROUP BY vendorno, brand
)

SELECT
    -- Basic identifiers
    ps.vendornumber AS VendorNumber,
    ps.brand AS brand,
	ps.vendorname AS VendorName,
	ps.description AS Description,

    -- Pricing info
    ps.purchaseprice AS PurchasePrice,
    ps.actual_price AS ActualPrice,
    ps.volume AS Volume,

    -- Purchase metrics
    ps.total_purchase_quantity AS TotalPurchaseQuantity,
    ps.total_purchase_dollars AS TotalPurchaseDollars,

    -- Sales metrics
    ss.total_sales_quantity AS TotalSalesQuantity,
    ss.total_sales_dollars AS TotalSalesDollars,
    ss.total_sales_price AS TotalSalesPrice,
    ss.total_excise_tax AS TotalExciseTax,

    -- Freight
    COALESCE(fs.freight_cost, 0) AS FreightCost,

    -- -------------------------
    -- Calculated Metrics
    -- -------------------------

    -- Gross Profit
    (COALESCE(ss.total_sales_dollars,0)
     - ps.total_purchase_dollars) AS GrossProfit,

    -- Profit Margin (%)
    ((COALESCE(ss.total_sales_dollars,0)
      - ps.total_purchase_dollars)
     / NULLIF(COALESCE(ss.total_sales_dollars,0),0)) * 100 AS ProfitMargin,

    -- Stock Turnover
    (COALESCE(ss.total_sales_quantity,0)
     / NULLIF(ps.total_purchase_quantity,0)) AS StockTurnover,

    -- Sales to Purchase Ratio
    (COALESCE(ss.total_sales_dollars,0)
     / NULLIF(ps.total_purchase_dollars,0)) AS SalesToPurchaseRatio

FROM PurchaseSummary ps

LEFT JOIN SalesSummary ss
ON ps.vendornumber = ss.vendorno
AND ps.brand = ss.brand

LEFT JOIN FreightSummary fs
ON ps.vendornumber = fs.vendornumber;



select * from suppliers_sales_summary; 




