CREATE DATABASE EcommerceDB
GO

USE EcommerceDB
GO

CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	FullName VARCHAR(100) NOT NULL,
	Email VARCHAR(100) NOT NULL,
	RegistrationDate  DATE
)
GO

CREATE TABLE PRODUCTS(
	ProductID INT PRIMARY KEY IDENTITY(1,1),
	ProductName VARCHAR(100) NOT NULL,
	Category VARCHAR(50) NOT NULL,
	UnitPrice DECIMAL(10,2)
)
GO

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY IDENTITY(1,1),
	Customer_ID INT,
	OrderDate DATE NOT NULL,
	Status  VARCHAR(30)
)
GO

CREATE TABLE OrderItems(
	OrderItemID INT PRIMARY KEY IDENTITY(1,1),
	OrderID INT,
	ProductID INT,
	Quantity INT,
	UnitPrice DECIMAL(10,2)
)
GO

/*
Tabela agregada
dw_customer_ltv (Customer Lifetime Value)
Objetivo: Armazenar o valor total que cada cliente já gastou no e-commerce.
*/
CREATE TABLE dw_customer_ltv (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    total_spent DECIMAL(18, 2),
    total_orders INT,
    last_purchase_date DATE
);

/*
dw_top_products (Top Produtos Vendidos)
Objetivo: Manter uma lista dos produtos mais vendidos com dados de quantidade e receita.
*/
CREATE TABLE dw_top_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category_name VARCHAR(255),
    total_quantity_sold INT,
    total_revenue DECIMAL(18, 2)
);

/*
dw_revenue_by_date (Receita por Dia)
*/
CREATE TABLE dw_revenue_by_date (
    revenue_date DATE PRIMARY KEY,
    total_orders INT,
    total_items_sold INT,
    total_revenue DECIMAL(18, 2)
);

ALTER TABLE Orders
ADD CONSTRAINT CK_Status CHECK(Status IN ('Pending', 'Paid', 'Cancelled'))
GO

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (Customer_ID) REFERENCES Customers(CustomerID)
GO

ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderItems_Orders

FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
GO

ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderItems_Products
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
GO