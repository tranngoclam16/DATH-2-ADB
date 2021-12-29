USE [Order_Entry]
GO

/****** Object:  Index [Order_CustomerIdentifier_index]    Script Date: 12/29/2021 3:15:04 PM ******/
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