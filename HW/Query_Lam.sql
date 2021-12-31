set statistics io off;
set statistics time on
-- 1) Đối với một đơn đặt hàng của khách hàng cụ thể, tổng chi phí đơn đặt hàng là bao nhiêu?									
CREATE NONCLUSTERED INDEX [Order_CustomerIdentifier_index] ON [dbo].[Orders]
(
	[CustomerIdentifier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

select * from [Orders]							
where [Orders].CustomerIdentifier = 100	


-- 5) Cho biết thông tin khách hàng và số lần sử dụng trên mỗi thẻ tín dụng của họ													
CREATE NONCLUSTERED INDEX idx_credit_card_customer_id
ON [dbo].[Credit_Card] ([CustomerIdentifier])
GO

select [Customer].*, [Credit_Card].CustomerCreditCardNumber, [Credit_Card].NumberUsed							
from [Customer] join [Credit_Card] on [Customer].CustomerIdentifier = [Credit_Card].CustomerIdentifier							
where [Customer].CustomerIdentifier = 500	


CREATE TABLE #counts
(
    table_name varchar(255),
    row_count int
)

EXEC sp_MSForEachTable @command1='INSERT #counts (table_name, row_count) SELECT ''?'', COUNT(*) FROM ?'
SELECT table_name, row_count FROM #counts ORDER BY table_name, row_count DESC
SELECT SUM(row_count) from #counts
										