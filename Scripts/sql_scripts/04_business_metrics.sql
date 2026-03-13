-- This query calculates business metrics from the summary view

SELECT
    vendornumber,
    vendorname,
    brand,

    total_sales_dollars,
    total_purchase_dollars,

    -- Gross Profit (Note: Gross profit does not include freight cost)
    (total_sales_dollars - total_purchase_dollars) AS gross_profit,

    -- Profit Margin (%)
    ((total_sales_dollars - total_purchase_dollars)
        / NULLIF(total_sales_dollars, 0)) * 100 AS profit_margin,

    -- Stock Turnover
    (total_sales_quantity
        / NULLIF(total_purchase_quantity, 0)) AS stock_turnover,

    -- Sales to Purchase Ratio
    (total_sales_dollars
        / NULLIF(total_purchase_dollars, 0)) AS sales_purchase_ratio

FROM suppliers_sales_summary;