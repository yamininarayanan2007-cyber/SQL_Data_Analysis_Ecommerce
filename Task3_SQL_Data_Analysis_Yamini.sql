-- TASK 3: SQL Data Analysis Internship
-- Dataset: Custom Ecommerce_SQL_Database
-- Created by: Yamini

CREATE DATABASE Ecommerce_SQL_Database;
USE Ecommerce_SQL_Database;

-- Tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Data
INSERT INTO Customers VALUES
(1,'Yamini','yami@gmail.com','Chennai'),
(2,'Lokesh','lokesh@gmail.com','Bangalore'),
(3,'Anu','anu@gmail.com','Hyderabad'),
(4,'Rahul','rahul@gmail.com','Mumbai');

INSERT INTO Products VALUES
(101,'Laptop','Electronics',50000),
(102,'Phone','Electronics',20000),
(103,'Shoes','Fashion',3000),
(104,'Watch','Fashion',5000),
(105,'Tablet','Electronics',25000);

INSERT INTO Orders VALUES
(1001,1,'2025-01-10'),
(1002,2,'2025-01-12'),
(1003,1,'2025-02-01'),
(1004,3,'2025-02-05');

INSERT INTO Order_Items VALUES
(1,1001,101,1),
(2,1001,103,2),
(3,1002,102,1),
(4,1003,104,1),
(5,1004,105,1);

-- Queries
SELECT * FROM Customers WHERE city='Chennai';

SELECT * FROM Products ORDER BY price DESC;

SELECT c.name, o.order_id, o.order_date
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

SELECT p.product_name,
       SUM(p.price * oi.quantity) AS total_revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name;

SELECT name
FROM Customers
WHERE customer_id IN (SELECT customer_id FROM Orders);

CREATE VIEW Customer_Total_Spending AS
SELECT c.name,
       SUM(p.price * oi.quantity) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.name;

CREATE INDEX idx_customer_id ON Orders(customer_id);
CREATE INDEX idx_product_id ON Order_Items(product_id);
