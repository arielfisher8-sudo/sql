--Library Management System

create table Books(
bookName nvarchar(100),
ISBN bigint,
author nvarchar(100),
timesBorrowed int
)
create table members (memberID int,
memberName nvarchar(100),
)

create table loans (memberID nvarchar(100),
ISBN bigint,
bookName varchar (100),
loandate date)

select bookname from loans

select memberid from loans
where dateadd(day,30,loandate)< GETDATE() 

select  top 1 timesborrowed, bookname from books

select DATEDIFF(day,dateadd(day,30,loandate),GETDATE())*2 from loans

