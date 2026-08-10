create table Customers ()

create table Products(productID  int primary key, price float, inventory int)

create table Orders(OrderID int, productID int, foreign key (productID) references Products(productID), price float, OrderDate date)

create table OrderItems()

drop table products

with sumByOrder as 
(select sum (price) as priceSum from orders
where month(orderdate) = month(getdate()) and year(orderDate) = year(getdate())
group by orderID 
)
select sum(priceSum) from sumByOrder

INSERT INTO products ( productID, price, inventory) VALUES
( 5, 5.99,10),
(12, 89.00,11),
(10, 29.99,23),
(42, 450.00,100),
(3, 12.75,12),
(25, 149.50,22),
(18, 99.95,32),
(7, 24.00,21)
;

INSERT INTO Orders (OrderID, productID, price, OrderDate) VALUES
(1001, 10, 29.99, '2026-06-01'),
(1002, 25, 149.50, '2026-06-01'),
(1003, 5, 5.99, '2026-06-02'),
(1004, 12, 89.00, '2026-06-03'),
(1005, 10, 29.99, '2026-06-03'),
(1006, 42, 450.00, '2026-06-04'),
(1007, 3, 12.75, '2026-06-05'),
(1008, 25, 149.50, '2026-06-05'),
(1009, 18, 99.95, '2026-06-06'),
(1010, 7, 24.00, '2026-06-06');

INSERT INTO Orders (OrderID, productID, price, OrderDate) VALUES
(1000, 10, 29.99, '2026-05-01')

with productCount as 
(select  productID, count(productID) as prodcount from orders
group by productID
)
select top 1 prodcount, productID from productCount order by prodcount desc

 