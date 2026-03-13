-- SALES table (sabse heavy)
CREATE INDEX idx_sales_brand ON sales(brand);
CREATE INDEX idx_sales_vendor ON sales(vendorno);
CREATE INDEX idx_sales_date ON sales(salesdate);

-- PURCHASES table
CREATE INDEX idx_purchases_brand ON purchases(brand);
CREATE INDEX idx_purchases_vendor ON purchases(vendornumber);

-- INVOICE table
CREATE INDEX idx_invoice_vendor ON vendor_invoice(vendornumber);