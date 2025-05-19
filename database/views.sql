--VW_BEST_SELLING_PROD
CREATE VIEW VW_BEST_SELLING_PROD AS
SELECT 
    PR.ProductName AS Products, 
    SUM(OI.Quantity) AS TotalSold
FROM PRODUCTS PR
JOIN OrderItems OI ON PR.ProductID = OI.ProductID
GROUP BY PR.ProductName;

--VW_CUSTOMER_ORDERS_SUMMARY
CREATE VIEW VW_CUSTOMER_ORDERS_SUMMARY AS
SELECT 
    C.CustomerID,
    C.CustomerName,
    COUNT(O.OrderID) AS TotalOrders,
    SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName;

--VW_DW_CUSTOMER_LTV
CREATE VIEW VW_DW_CUSTOMER_LTV AS
SELECT 
    Cust.CustomerID,
    Cust.CustomerName,
    SUM(Orders.TotalAmount) AS LifetimeValue
FROM Customers Cust
JOIN Orders ON Cust.CustomerID = Orders.CustomerID
GROUP BY Cust.CustomerID, Cust.CustomerName;

--VW_DW_REVENUE_BY_DATE
CREATE VIEW VW_DW_REVENUE_BY_DATE AS
SELECT 
    CAST(O.OrderDate AS DATE) AS OrderDate,
    SUM(O.TotalAmount) AS Revenue
FROM Orders O
GROUP BY CAST(O.OrderDate AS DATE);

--VW_DW_TOP_PRODUCTS
CREATE VIEW VW_DW_TOP_PRODUCTS AS
SELECT 
    PR.ProductName,
    SUM(OI.Quantity) AS TotalUnitsSold,
    SUM(OI.Quantity * OI.UnitPrice) AS Revenue
FROM Products PR
JOIN OrderItems OI ON PR.ProductID = OI.ProductID
GROUP BY PR.ProductName
ORDER BY Revenue DESC;

--VW_MONTHLY_REVENUE
CREATE VIEW VW_MONTHLY_REVENUE AS
SELECT 
    FORMAT(O.OrderDate, 'yyyy-MM') AS Month,
    SUM(O.TotalAmount) AS Revenue
FROM Orders O
GROUP BY FORMAT(O.OrderDate, 'yyyy-MM');

--VW_SALES_BY_CATEGORY
CREATE VIEW VW_SALES_BY_CATEGORY AS
SELECT
    PR.CATEGORY AS Category,
    SUM(OI.Quantity * OI.UnitPrice) AS TotalSales
FROM PRODUCTS PR
JOIN OrderItems OI ON PR.ProductID = OI.ProductID
GROUP BY PR.Category;

--VW_SALES_BY_CUSTOMER
CREATE VIEW VW_SALES_BY_CUSTOMER AS
SELECT
    C.FullName AS Customers,
    C.Email AS CustomerEmail,
    COUNT(DISTINCT O.OrderID) AS OrdersQuantity,
    SUM(OI.Quantity * OI.UnitPrice) AS TotalSale
FROM Customers C
JOIN Orders O ON C.CustomerID = O.Customer_ID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY C.FullName, C.Email, C.CustomerID;