INSERT INTO Customers (FullName, Email, RegistrationDate) VALUES
('Alice Johnson', 'alice.johnson@email.com', '2023-01-15'),
('Bruno Silva', 'bruno.silva@email.com', '2023-03-22'),
('Clara Mendes', 'clara.mendes@email.com', '2023-05-10'),
('Daniel Costa', 'daniel.costa@email.com', '2023-07-08'),
('Eva Lima', 'eva.lima@email.com', '2023-08-01')
GO

INSERT INTO Products (ProductName, Category, UnitPrice) VALUES
('Notebook Gamer', 'Electronics', 4500.00),
('Smartphone Galaxy A23', 'Electronics', 1500.00),
('Headset Bluetooth', 'Accessories', 200.00),
('Smartwatch Fit', 'Wearables', 800.00),
('Wireless Mouse', 'Accessories', 120.00)
GO

INSERT INTO Orders (Customer_ID, OrderDate, Status) VALUES
(1, '2023-03-01', 'Paid'),
(2, '2023-03-15', 'Paid'),
(3, '2023-03-20', 'Cancelled'),
(4, '2023-04-05', 'Paid'),
(5, '2023-04-10', 'Pending'),
(1, '2023-04-15', 'Paid'),
(2, '2023-04-18', 'Paid')
GO

INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 4500.00), 
(1, 5, 2, 120.00),  
(2, 2, 1, 1500.00),  
(2, 3, 1, 200.00),  
(3, 4, 1, 800.00),   
(4, 1, 1, 4500.00), 
(5, 2, 2, 1500.00), 
(6, 3, 1, 200.00),  
(6, 4, 1, 800.00),  
(7, 2, 1, 1500.00)
GO
