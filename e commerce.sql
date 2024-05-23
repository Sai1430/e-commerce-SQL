-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(200),
    City VARCHAR(50),
    Country VARCHAR(50)
);

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create the OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the Inventory table
CREATE TABLE Inventory (
    ProductID INT,
    Stock INT,
    LastUpdated DATE,
    PRIMARY KEY (ProductID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERTING SAMPLE DATA

-- Insert data into Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address, City, Country)
VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm St', 'New York', 'USA'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Oak St', 'Los Angeles', 'USA');

-- Insert data into Products table
INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES 
(1, 'Laptop', 'Electronics', 999.99, 50),
(2, 'Smartphone', 'Electronics', 499.99, 100),
(3, 'Tablet', 'Electronics', 299.99, 75);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES 
(1, 1, '2024-05-01', 1499.98),
(2, 2, '2024-05-02', 299.99);

-- Insert data into OrderDetails table
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice)
VALUES 
(1, 1, 1, 1, 999.99),
(2, 1, 2, 1, 499.99),
(3, 2, 3, 1, 299.99);

-- Insert data into Inventory table
INSERT INTO Inventory (ProductID, Stock, LastUpdated)
VALUES 
(1, 50, '2024-05-01'),
(2, 100, '2024-05-01'),
(3, 75, '2024-05-01');

SAMPLE QUERIES 

-- Query to get total sales by product
SELECT 
    p.ProductName,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM 
    OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
GROUP BY 
    p.ProductName
ORDER BY 
    TotalSales DESC;

-- Query to get the top-selling products
SELECT 
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantitySold
FROM 
    OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
GROUP BY 
    p.ProductName
ORDER BY 
    TotalQuantitySold DESC
LIMIT 5;

-- Query to get monthly sales
SELECT 
    DATE_TRUNC('month', o.OrderDate) AS Month,
    SUM(o.TotalAmount) AS TotalSales
FROM 
    Orders o
GROUP BY 
    DATE_TRUNC('month', o.OrderDate)
ORDER BY 
    Month;

-- Query to get customer purchase history
SELECT 
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM 
    Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE 
    c.CustomerID = 1
ORDER BY 
    o.OrderDate;

ADDING INDEXES

-- Add index on CustomerID in Orders table
CREATE INDEX idx_orders_customer_id ON Orders(CustomerID);

-- Add index on ProductID in OrderDetails table
CREATE INDEX idx_orderdetails_product_id ON OrderDetails(ProductID);

-- Add index on OrderDate in Orders table for faster date range queries
CREATE INDEX idx_orders_order_date ON Orders(OrderDate);

