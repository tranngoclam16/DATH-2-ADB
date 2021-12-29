use Order_Entry
GO

create trigger PreferredCard_insert on Credit_Card
for insert,update
as
begin
	update Customer 
	set PreferredCreditCard= i.CustomerCreditCardNumber
	from INSERTED i
	where i.PreferredOption='Yes'
	and i.CustomerIdentifier= Customer.CustomerIdentifier

	update Customer 
	set PreferredCreditCard= NULL
	from INSERTED i
	where i.PreferredOption='No'
	and i.CustomerIdentifier= Customer.CustomerIdentifier
end
go

create trigger NumberUsed_Card on Orders
for insert
as
begin
	update Credit_Card
	set NumberUsed= NumberUsed+1
	from INSERTED i
	where i.CustomerCreditCardNumber=Credit_Card.CustomerCreditCardNumber
end
go

CREATE TRIGGER lowest_price_supplier_id
ON Restock_Item
FOR INSERT, UPDATE, DELETE
AS
DECLARE @Operation VARCHAR(15),
  @pp int, @lp int, @i int, @d int
IF EXISTS (SELECT 0 FROM inserted)
BEGIN
   IF EXISTS (SELECT 0 FROM deleted)
   BEGIN 
      SELECT @Operation = 'UPDATE'
	  DECLARE @lp2 int 
      SET @i = (SELECT PurchasePrice FROM inserted)
      SET @d = (SELECT PurchasePrice FROM deleted)
	  SET @lp2 = (SELECT ai.LowestPrice FROM Advertised_Item ai JOIN INSERTED i ON ai.ItemNumber=i.ItemNumber WHERE ai.SupplierID = i.SupplierID)
	  SET @lp = (SELECT ai.LowestPrice FROM Advertised_Item ai JOIN INSERTED i ON ai.ItemNumber=i.ItemNumber)
      IF (@i > @lp2)

        BEGIN
			DROP TABLE IF EXISTS [dbo].##tempAI;
			CREATE TABLE ##tempAI (ItemNumber BIGINT, LowestPrice int, SupID varchar(6))

			INSERT INTO ##tempAI (ItemNumber, LowestPrice, SupID)
			SELECT ItemNumber, PurchasePrice, SupplierID FROM Restock_Item
			GROUP BY ItemNumber, PurchasePrice, SupplierID 
			HAVING PurchasePrice <= ALL (SELECT PurchasePrice FROM Restock_Item ri WHERE ri.ItemNumber = Restock_Item.ItemNumber);

			UPDATE Advertised_Item 
			SET Advertised_Item.LowestPrice = ##tempAI.LowestPrice, Advertised_Item.SupplierID = ##tempAI.SupID 
			FROM Advertised_Item INNER JOIN ##tempAI ON Advertised_Item.ItemNumber=##tempAI.ItemNumber

			DROP TABLE ##tempAI
		END
      ELSE IF (@i < @lp)
		BEGIN
		UPDATE Advertised_Item
        SET LowestPrice = @i,
          SupplierID = inserted.SupplierID
		FROM inserted INNER JOIN Advertised_Item ON Advertised_Item.ItemNumber=inserted.ItemNumber
		END
   END 
   ELSE
   BEGIN
      SELECT @Operation = 'INSERT'
	  SET @pp = (SELECT PurchasePrice FROM inserted)
      SET @lp = (SELECT ai.LowestPrice FROM Advertised_Item ai JOIN INSERTED i ON ai.ItemNumber=i.ItemNumber)
      IF (@pp < @lp)
        UPDATE Advertised_Item
        SET LowestPrice = @pp,
          SupplierID = inserted.SupplierID
		FROM inserted INNER JOIN Advertised_Item ON Advertised_Item.ItemNumber=inserted.ItemNumber
   END
END ELSE 
BEGIN
	SELECT @Operation = 'DELETE'
		BEGIN
			DROP TABLE IF EXISTS [dbo].##tempAIforDELETE;
			CREATE TABLE ##tempAIforDELETE (ItemNumber BIGINT, LowestPrice int, SupID varchar(6))

			INSERT INTO ##tempAIforDELETE (ItemNumber, LowestPrice, SupID)
			SELECT ItemNumber, PurchasePrice, SupplierID FROM Restock_Item
			GROUP BY ItemNumber, PurchasePrice, SupplierID 
			HAVING PurchasePrice <= ALL (SELECT PurchasePrice FROM Restock_Item ri WHERE ri.ItemNumber = Restock_Item.ItemNumber);

			UPDATE Advertised_Item 
			SET Advertised_Item.LowestPrice = ##tempAIforDELETE.LowestPrice, Advertised_Item.SupplierID = ##tempAIforDELETE.SupID 
			FROM Advertised_Item INNER JOIN ##tempAIforDELETE ON Advertised_Item.ItemNumber=##tempAIforDELETE.ItemNumber

			DROP TABLE ##tempAIforDELETE
		END
END 

