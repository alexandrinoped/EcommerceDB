--SP_GENERATE_DAILY_REVENUE
CREATE PROC SP_GENERATE_DAILY_REVENUE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM DailyRevenue
    WHERE RevenueDate = CAST(GETDATE() AS DATE);

    INSERT INTO DailyRevenue (
        RevenueDate,
        TotalRevenue
    )
    SELECT 
        CAST(GETDATE() AS DATE),
        SUM(OI.Quantity * OI.UnitPrice)
    FROM Orders O
    JOIN OrderItems OI ON O.OrderID = OI.OrderID
    WHERE CAST(O.OrderDate AS DATE) = CAST(GETDATE() AS DATE);
END;
GO

--SP_POPULATE_DW_CUSTOMER_LTV
CREATE PROC SP_POPULATE_DW_CUSTOMER_LTV
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM DwCustomerLtv;

    INSERT INTO DwCustomerLtv (
        CustomerID,
        CustomerName,
        TotalSpent,
        TotalOrders,
        LastPurchaseDate
    )
    SELECT
        C.CustomerID,
        C.FullName,
        SUM(OI.Quantity * OI.UnitPrice) AS TotalSpent,
        COUNT(DISTINCT O.OrderID) AS TotalOrders,
        MAX(O.OrderDate) AS LastPurchaseDate
    FROM Customers C
    JOIN Orders O ON C.CustomerID = O.Customer_ID
    JOIN OrderItems OI ON O.OrderID = OI.OrderID
    GROUP BY C.CustomerID, C.FullName;
END;
GO

--SP_POPULATE_DW_REVENUE_BY_DATE
CREATE PROC SP_POPULATE_DW_REVENUE_BY_DATE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dw_revenue_by_date;

    INSERT INTO dw_revenue_by_date (
        revenue_date,
        total_orders,
        total_items_sold,
        total_revenue
    )
    SELECT
        O.OrderDate,
        COUNT(DISTINCT O.OrderID) AS TotalOrders,
        SUM(OI.Quantity) AS TotalItemsSold,
        SUM(OI.Quantity * OI.UnitPrice) AS TotalRevenue
    FROM Orders O
    JOIN OrderItems OI ON O.OrderID = OI.OrderID
    GROUP BY O.OrderDate;
END;
GO

--SP_POPULATE_DW_TOP_PRODUCTS
CREATE PROC SP_POPULATE_DW_TOP_PRODUCTS
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dw_top_products;

    INSERT INTO dw_top_products (
        ProductID,
        ProductName,
        CategoryName,
        TotalQuantitySold,
        TotalRevenue
    )
    SELECT
        PR.ProductID,
        PR.ProductName,
        PR.Category,
        SUM(OI.Quantity) AS TotalQuantitySold,
        SUM(OI.Quantity * OI.UnitPrice) AS TotalRevenue
    FROM PRODUCTS PR
    JOIN OrderItems OI ON PR.ProductID = OI.ProductID
    GROUP BY PR.ProductID, PR.ProductName, PR.Category;
END;
GO