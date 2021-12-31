--INDEX
USE [Order_Entry]
GO

-----TRUY VẤN 3
--SELECT Customer.*,Credit_Card.CustomerCreditCardNumber,Credit_Card.CustomerCreditCardName ,Credit_Card.NumberUsed							
--from Customer join Credit_Card on Customer.CustomerIdentifier = Credit_Card.CustomerIdentifier							
--where Customer.CustomerIdentifier = '35874'
-----TRUY VẤN 5
--select [Customer].*, [Credit_Card].CustomerCreditCardNumber, [Credit_Card].NumberUsed							
--from [Customer] join [Credit_Card] on [Customer].CustomerIdentifer = [Credit_Card].CustomerIdentifer							
--where [Customer].CustomerIdentifier = @CustomerID							
CREATE NONCLUSTERED INDEX idx_credit_card_customer_id
ON [dbo].[Credit_Card] ([CustomerIdentifier])
GO

-----TRUY VẤN 1
--select * from [Order]				
--where [Order].CustomerIdentifer = @CustomerID				
-----TRUY VẤN 6
--SELECT C.*, NumberOfOrders					
--FROM Customer C					
--INNER JOIN					
--(SELECT COUNT(O.OrderNumber) as NumberOfOrders, CustomerIdentifier					
--FROM Orders O					
--GROUP BY O.CustomerIdentifier) t2					
--ON C.CustomerIdentifier = t2.CustomerIdentifier		
CREATE NONCLUSTERED INDEX IX_Order_CustomerIdentifier
on [dbo].[Orders] ([CustomerIdentifier])
GO

-----TRUY VẤN 7
--SELECT TOP 20 * FROM Advertised_Item ai							
--JOIN (SELECT ItemNumber, SUM(QuantityOrdered) as NumbersOfItem							
--FROM Ordered_Item							
--GROUP BY ItemNumber) t2 ON ai.ItemNumber=t2.ItemNumber							
--ORDER BY NumbersOfItem DESC							
CREATE NONCLUSTERED INDEX IX_OrderedItem_QuantityOrdered
on [dbo].[Ordered_Item] ([QuantityOrdered])
GO

-----TRUY VẤN 8
--Select * from Supplier where Supplier.Total_Item= ( Select MAX (Total_Item) from Supplier)
CREATE NONCLUSTERED INDEX idx_total_item_supplier
ON [dbo].[Supplier] ([Total_Item])
GO

CREATE NONCLUSTERED INDEX [Order_CustomerIdentifier_index] ON [dbo].[Orders]
(
	[CustomerIdentifier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX IX_Supplier_TotalItem
on [dbo].[Supplier] ([Total_Item])
GO

CREATE NONCLUSTERED INDEX IX_OrderedItem_QuantityOrdered
on [dbo].[Ordered_Item] ([QuantityOrdered])
GO

CREATE NONCLUSTERED INDEX IX_CreditCard_CustomerIdentifier
on [dbo].[Credit_Card] ([CustomerIdentifier])
GO