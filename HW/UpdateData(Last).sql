USE Order_Entry
GO
--SELECT ItemNumber, PurchasePrice, SupplierID FROM Restock_Item
--GROUP BY ItemNumber, PurchasePrice, SupplierID 
--HAVING PurchasePrice <= ALL (SELECT PurchasePrice FROM Restock_Item ri WHERE ri.ItemNumber = Restock_Item.ItemNumber)
--ORDER BY ItemNumber

-- *****Update LowestPrice & SupplierID***** --
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
GO
-- *****Update CreditCard & CustomerID***** --
BEGIN
	CREATE TABLE ##tempCC (CCNum varchar(20), CustomerID nvarchar(20), NumUsed int)
	INSERT INTO ##tempCC (CCNum, CustomerID, NumUsed)
	SELECT CustomerCreditCardNumber, CustomerIdentifier, COUNT(*) as NumberUse FROM Orders
	GROUP BY CustomerCreditCardNumber, CustomerIdentifier
	--SELECT * FROM ##tempCC
	UPDATE Credit_Card
	SET CustomerIdentifier = ##tempCC.CustomerID,
		NumberUsed = ##tempCC.NumUsed
	FROM ##tempCC INNER JOIN Credit_Card ON ##tempCC.CCNum = Credit_Card.CustomerCreditCardNumber 

	DROP TABLE ##tempCC
END
--SELECT * FROM Credit_Card ORDER BY NumberUsed DESC
--SELECT * FROM Orders WHERE CustomerCreditCardNumber = '30000348399100'

-- *****Update TotalItem from Supplier***** --
BEGIN
	CREATE TABLE ##tempTI (SupID varchar(6), Total int)
	INSERT INTO ##tempTI (SupID, Total)
	SELECT SupplierID, COUNT(ItemNumber) as TotalItem FROM Restock_Item
	--WHERE SupplierID = '000491'
	GROUP BY SupplierID
	UPDATE Supplier
	SET Total_Item = ##tempTI.Total
	FROM Supplier INNER JOIN ##tempTI ON Supplier.SupplierID=##tempTI.SupID

	DROP TABLE ##tempTI
END
INSERT INTO Restock_Item (ItemNumber, SupplierID, PurchasePrice) VALUES (2, '000000', 1200)
SELECT * FROM Restock_Item
WHERE SupplierID = '000000' ORDER BY ItemNumber

