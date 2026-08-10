--Personal Expense Tracker

create table transactions(
customerName Nvarchar (50),
vendorName Nvarchar(50),
transactionSum INT,
transactionDate date,
categorie Nvarchar (100))

select customerName, sum(transactionSum) as 'this month' from transactions
where month(transactiondate) = month(GETDATE()) and year(transactionDate) = YEAR(getdate())
group by customerName

select  top 1 sum(transactionSum), categorie from transactions
group by categorie, customerName

select sum(transactionSum) from transactions
group by  format (transactionDate, 'yyyy-MM'), customerName

select customerName, transactionSum , vendorName ,count(*)
from transactions
group by customerName, transactionSum, vendorName
having count(*) >1

insert into transactions 
values
('James', 'Cola', 10,'2026-06-12','drinks'),
('James', 'Cola', 10,'2026-06-10','drinks'),
('James', 'cola', 10,'2026-06-08','drinks'),
('Carl','mcdonalds',15,'2026-06-07','fast food'),
('carl', 'mcdonalds',15,'2026-06-04','fast food'),
('carl','decathlon',10,'2026-06-01', 'sports');




