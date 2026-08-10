CREATE TABLE DimCustomer
(
    CustomerKey INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(100),
    Country VARCHAR(100)
);
INSERT INTO DimCustomer
(CustomerKey, CustomerName, City, Country)
VALUES
(1,'Alice Smith','New York','USA'),
(2,'Bob Jones','Chicago','USA'),
(3,'Charlie Brown','London','UK'),
(4,'David Green','Tel Aviv','Israel');

CREATE TABLE DimProduct
(
    ProductKey INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(100)
);

CREATE TABLE DimDate
(
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName VARCHAR(20)
);

INSERT INTO DimDate
(DateKey, FullDate, Year, Quarter, Month, MonthName)
VALUES
(20250101,'2025-01-01',2025,1,1,'January'),
(20250102,'2025-01-02',2025,1,1,'January'),
(20250103,'2025-01-03',2025,1,1,'January'),
(20250201,'2025-02-01',2025,1,2,'February'),
(20250202,'2025-02-02',2025,1,2,'February');

CREATE TABLE FactSales
(
    SalesKey INT PRIMARY KEY,
    DateKey INT,
    CustomerKey INT,
    ProductKey INT,
    Quantity INT,
    Revenue DECIMAL(12,2)
);

drop table FactSales

INSERT INTO FactSales
(
    SalesKey,
    DateKey,
    CustomerKey,
    ProductKey,
    Quantity,
    Revenue
)
VALUES
(1,20250101,1,101,1,1200.00), -- Laptop
(2,20250101,1,102,2,50.00),   -- Mouse
(3,20250102,2,103,1,300.00),  -- Chair
(4,20250102,3,104,2,500.00),  -- Monitor
(5,20250103,4,105,1,450.00),  -- Desk
(6,20250201,2,101,1,1200.00),
(7,20250201,3,102,3,75.00),
(8,20250202,1,104,1,250.00),
(9,20250202,4,103,2,600.00),
(10,20250202,2,105,1,450.00);

INSERT INTO FactSales
(
    SalesKey,
    DateKey,
    CustomerKey,
    ProductKey,
    Quantity,
    Revenue
)
VALUES
(11,20250101,1,201,1,1200.00)

INSERT INTO DimProduct
(ProductKey, ProductName, Category)
VALUES

-- Electronics
(101, 'Laptop Pro 15', 'Electronics'),
(102, 'Laptop Air 13', 'Electronics'),
(103, 'Gaming Laptop X', 'Electronics'),
(104, '27 Inch Monitor', 'Electronics'),
(105, '32 Inch Monitor', 'Electronics'),
(106, 'Wireless Mouse', 'Electronics'),
(107, 'Mechanical Keyboard', 'Electronics'),
(108, 'USB-C Dock', 'Electronics'),
(109, 'Webcam HD', 'Electronics'),
(110, 'Bluetooth Headphones', 'Electronics'),

-- Furniture
(201, 'Office Desk', 'Furniture'),
(202, 'Standing Desk', 'Furniture'),
(203, 'Executive Chair', 'Furniture'),
(204, 'Ergonomic Chair', 'Furniture'),
(205, 'Bookshelf', 'Furniture'),
(206, 'Filing Cabinet', 'Furniture'),
(207, 'Conference Table', 'Furniture'),
(208, 'Desk Lamp', 'Furniture'),

-- Mobile Devices
(301, 'Smartphone X', 'Mobile'),
(302, 'Smartphone Plus', 'Mobile'),
(303, 'Tablet 10', 'Mobile'),
(304, 'Tablet Pro', 'Mobile'),
(305, 'Smart Watch', 'Mobile'),
(306, 'Wireless Earbuds', 'Mobile'),

-- Accessories
(401, 'Laptop Bag', 'Accessories'),
(402, 'Mouse Pad', 'Accessories'),
(403, 'USB Flash Drive', 'Accessories'),
(404, 'External SSD', 'Accessories'),
(405, 'HDMI Cable', 'Accessories'),
(406, 'Power Bank', 'Accessories'),

-- Software
(501, 'Office Suite License', 'Software'),
(502, 'Antivirus License', 'Software'),
(503, 'Project Management Tool', 'Software'),
(504, 'Database License', 'Software'),
(505, 'Cloud Storage Subscription', 'Software'),

-- Networking
(601, 'WiFi Router', 'Networking'),
(602, 'Network Switch', 'Networking'),
(603, 'Access Point', 'Networking'),
(604, 'Firewall Appliance', 'Networking'),
(605, 'Ethernet Cable', 'Networking');


SELECT 
    DateKey / 10000 AS Yearno,
    (DateKey / 100) % 100 AS Monthno,
    SUM(revenue) AS total_sales
FROM FactSales

GROUP BY datekey/10000, (DateKey / 100) % 100 
ORDER BY yearno, monthno;

select top 10 customerkey, sum(revenue) from FactSales 
group by CustomerKey order by sum(revenue) desc

select dimproduct.category ,sum(revenue) from FactSales
join DimProduct on DimProduct.ProductKey = FactSales.ProductKey
group by DimProduct.Category
;
WITH Numbers AS
(
    SELECT TOP (100000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
    FROM sys.objects a
    CROSS JOIN sys.objects b
)
INSERT INTO FactSales
(
    SalesKey,
    DateKey,
    CustomerKey,
    ProductKey,
    Quantity,
    Revenue
)
SELECT
    N AS SalesKey,

    -- Random DateKey
    (
        SELECT TOP 1 DateKey
        FROM DimDate
        ORDER BY NEWID()
    ),

    -- Random Customer
    (
        SELECT TOP 1 CustomerKey
        FROM DimCustomer
        ORDER BY NEWID()
    ),

    -- Random Product
    (
        SELECT TOP 1 ProductKey
        FROM DimProduct
        ORDER BY NEWID()
    ),

    -- Random Quantity 1-10
    ABS(CHECKSUM(NEWID())) % 10 + 1,

    -- Random Revenue 10-5000
    CAST(
        (ABS(CHECKSUM(NEWID())) % 4990) + 10
        AS DECIMAL(12,2)
    )
FROM Numbers;

select * from factsales