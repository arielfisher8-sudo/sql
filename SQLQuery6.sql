--bank account management system
create table accounts (accountHolderName varchar(100), accountNumber int, accountBalance float)
create table transactionhistory (senderID int, recieverID int, amount float)

go

CREATE PROCEDURE TransferFunds (
    @SenderId INT,
    @ReceiverId INT,
    @Amount float
)
AS
BEGIN
    
    SET XACT_ABORT ON; 

    BEGIN TRANSACTION;
    BEGIN TRY
       
        UPDATE Accounts SET accountBalance = accountBalance - @Amount WHERE accountNumber = @SenderId;
        
        
        UPDATE Accounts SET accountBalance = accountBalance + @Amount WHERE accountNumber = @ReceiverId;

        insert into transactionhistory 
        values (@SenderId,@ReceiverId,@Amount)

        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
go

create procedure seeTransactionHistory (@accountID int)
AS
begin
select senderid,recieverID,amount from transactionhistory
where senderID=@accountID or recieverID= @accountID
end;

