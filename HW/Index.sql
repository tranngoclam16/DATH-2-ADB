--INDEX
--TRUY VẤN 3
--SELECT Customer.*,Credit_Card.CustomerCreditCardNumber,Credit_Card.CustomerCreditCardName ,Credit_Card.NumberUsed							
--from Customer join Credit_Card on Customer.CustomerIdentifier = Credit_Card.CustomerIdentifier							
--where Customer.CustomerIdentifier = '35874'
CREATE NONCLUSTERED INDEX idx_credit_card_customer_id
ON [dbo].[Credit_Card] ([CustomerIdentifier])
GO

--TRUY VẤN 7
--SELECT TOP 20 * FROM Advertised_Item ai							
--JOIN (SELECT ItemNumber, SUM(QuantityOrdered) as NumbersOfItem							
--FROM Ordered_Item							
--GROUP BY ItemNumber) t2 ON ai.ItemNumber=t2.ItemNumber							
--ORDER BY NumbersOfItem DESC							
CREATE NONCLUSTERED INDEX IX_OrderedItem_QuantityOrdered
on [dbo].[Ordered_Item] ([QuantityOrdered])
GO

--TRUY VẤN 8
--Select * from Supplier where Supplier.Total_Item= ( Select MAX (Total_Item) from Supplier)
CREATE NONCLUSTERED INDEX idx_total_item_supplier
ON [dbo].[Supplier] ([Total_Item])
GO
