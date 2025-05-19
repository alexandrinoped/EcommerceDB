--Total de pedidos por cliente
SELECT
    C.FullName AS Customers,
    COUNT(O.OrderID) AS TotalOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.Customer_ID
GROUP BY C.FullName
ORDER BY TotalOrders DESC
GO

--Produto mais vendido (por quantidade)
SELECT TOP 1
		P.ProductName,
    SUM(OI.Quantity) AS TotalSold
FROM PRODUCTS PR
JOIN OrdersItem OI ON PR.ProductID = OI.ProductID
GROUP BY P.ProductName
ORDER BY TotalSold DESC


--Produto mais vendido (por quantidade)
SELECT
    P.ProductName,
    SUM(OI.Quantity) AS TotalSold
FROM OrderItems OI
JOIN Products P ON OI.ProductID = P.ProductID
GROUP BY P.ProductName
HAVING SUM(OI.Quantity) = (
    SELECT MAX(Total)
    FROM (
        SELECT SUM(Quantity) AS Total
        FROM OrderItems
        GROUP BY ProductID
    ) AS Sub
)
GO

--Clientes que compraram o produto "Notebook Gamer"
SELECT DISTINCT
    C.FullName AS CustomerName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.Customer_ID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
JOIN Products P ON OI.ProductID = P.ProductID
WHERE P.ProductName = 'Notebook Gamer'
GO

--Top 5 clientes que mais gastaram no e-commerce
SELECT
    C.FullName AS Customers,
    SUM(OI.Quantity * OI.UnitPrice) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.Customer_ID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
WHERE O.Status = 'Paid'
GROUP BY C.FullName
ORDER BY TotalSpent DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY

--Total de vendas por mês
SELECT
    FORMAT(O.OrderDate, 'yyyy-MM') AS SaleMonth,
    SUM(OI.Quantity * OI.UnitPrice) AS TotalRevenue
FROM Orders O
JOIN OrderItems OI ON O.OrderID = OI.OrderID
WHERE O.Status = 'Paid'
GROUP BY FORMAT(O.OrderDate, 'yyyy-MM')
ORDER BY SaleMonth
GO

--Categorias mais vendidas por volume e faturamento
SELECT
    PR.Category AS Category,
    SUM(OI.Quantity) AS QuantitySold,
    SUM(OI.Quantity * OI.UnitPrice) AS TotalRevenue
FROM Products PR
JOIN OrderItems OI ON PR.ProductID = OI.ProductID
JOIN Orders O ON OI.OrderID = O.OrderID
WHERE O.Status = 'Paid'
GROUP BY PR.Category
ORDER BY TotalRevenue DESC
GO

--Clientes sem pedidos pagos
SELECT
    C.FullName AS Customers,
    O.OrderID AS Orders,
    O.OrderDate,
    SUM(OI.Quantity * OI.UnitPrice) AS OrderTotal,
    O.Status AS OrderStatus
FROM Customers C
JOIN Orders O ON C.CustomerID = O.Customer_ID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
WHERE O.Status = 'Pending'
GROUP BY C.FullName, O.OrderID, O.OrderDate, O.Status
ORDER BY OrderTotal DESC

-- Produtos que nunca foram vendidos
SELECT
    ProductName AS Products
FROM Products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID
    FROM OrderItems
)
GO

--Valor médio por pedido por cliente
SELECT
    C.FullName AS Customers,
    O.OrderID AS OrderCustomer,
    AVG(OI.Quantity * OI.UnitPrice) AS OrderAverage
FROM Customers C
JOIN Orders O ON C.CustomerID = O.Customer_ID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY C.FullName, O.OrderID
ORDER BY OrderAverage DESC
GO

--Ticket médio por mês
SELECT
    MONTH(O.OrderDate) AS SaleMonth,
    AVG(OI.Quantity * OI.UnitPrice) AS AverageTicket
FROM Orders O
JOIN OrderItems OI ON O.OrderID = OI.OrderID
WHERE O.Status = 'Paid'
GROUP BY MONTH(O.OrderDate)
ORDER BY AverageTicket DESC
GO

--Clientes que fizeram apenas um pedido
SELECT
    C.FullName AS UniqueBuyers
FROM Customers C
JOIN Orders O ON C.CustomerID = O.Customer_ID
WHERE C.CustomerID IN (
    SELECT Customer_ID
    FROM Orders
    GROUP BY Customer_ID
    HAVING COUNT(*) = 1
)

--Produtos mais vendidos (em quantidade)
SELECT
	PR.ProductName AS Products,
	SUM(OI.Quantity) AS 'Total_Sold'
FROM PRODUCTS PR
JOIN OrderItems OI ON PR.ProductID = OI.ProductID
GROUP BY PR.ProductName
ORDER BY Total_Sold DESC
GO

--Produto mais vendido (usando subquery)
SELECT 
	PR.ProductName AS Products,
	SUM(OI.Quantity) AS 'Total_Sold'
FROM PRODUCTS PR
JOIN OrderItems OI ON PR.ProductID = OI.ProductID
GROUP BY PR.ProductName
HAVING SUM(OI.Quantity) = (
	SELECT MAX(Total)
	FROM(
		SELECT SUM(Quantity) AS Total
		FROM OrderItems
		GROUP BY ProductID
	) AS Sub
)
GO