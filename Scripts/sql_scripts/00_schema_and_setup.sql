CREATE TABLE sales (
    InventoryId VARCHAR(50),
    Store INTEGER,
    Brand INTEGER,
    Description TEXT,
    Size VARCHAR(30),
    SalesQuantity INTEGER,
    SalesDollars NUMERIC(10,2),
    SalesPrice NUMERIC(10,2),
    SalesDate DATE,
    Volume INTEGER,
    Classification INTEGER,
    ExciseTax NUMERIC(10,2),
    VendorNo INTEGER,
    VendorName VARCHAR(200)
);
ALTER TABLE sales
ALTER COLUMN volume TYPE NUMERIC(10,2);


CREATE TABLE purchases (
    InventoryId VARCHAR(50),
    Store INTEGER,
    Brand INTEGER,
    Description TEXT,
    Size VARCHAR(30),
    VendorNumber INTEGER,
    VendorName VARCHAR(200),
    PONumber INTEGER,
    PODate DATE,
    ReceivingDate DATE,
    InvoiceDate DATE,
    PayDate DATE,
    PurchasePrice NUMERIC(10,2),
    Quantity INTEGER,
    Dollars NUMERIC(12,2),
    Classification INTEGER
);

DROP TABLE IF EXISTS purchase_prices;
CREATE TABLE purchase_prices (
    Brand INTEGER,
    Description TEXT,
    Price NUMERIC(10,2),
    Size VARCHAR(30),
    Volume NUMERIC(10,2),
    Classification INTEGER,
    PurchasePrice NUMERIC(10,2),
    VendorNumber INTEGER,
    VendorName VARCHAR(200)
);


CREATE TABLE end_inventory (
    InventoryId VARCHAR(50),
    Store INTEGER,
    City VARCHAR(100),
    Brand INTEGER,
    Description TEXT,
    Size VARCHAR(50),
    onHand INTEGER,
    Price NUMERIC(10,2),
    endDate DATE
);


CREATE TABLE begin_inventory (
    InventoryId VARCHAR(50),
    Store INTEGER,
    City VARCHAR(100),
    Brand INTEGER,
    Description TEXT,
    Size VARCHAR(50),
    onHand INTEGER,
    Price NUMERIC(10,2),
    startDate DATE
);


CREATE TABLE vendor_invoice (
    VendorNumber INTEGER,
    VendorName VARCHAR(200),
    InvoiceDate DATE,
    PONumber VARCHAR(50),
    PODate DATE,
    PayDate DATE,
    Quantity INTEGER,
    Dollars NUMERIC(12,2),
    Freight NUMERIC(10,2),
    Approval VARCHAR(100) NULL
);

