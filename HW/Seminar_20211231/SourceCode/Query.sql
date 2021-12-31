--Truy vấn 1: Đối với một đơn đặt hàng của khách hàng cụ thể, tổng chi phí đơn đặt hàng là bao nhiêu?													
						
select OrderNumber, CustomerTelephoneNumber, CustomerIdentifier, OrderDate, 
ShippingStreetAddress, ShippingCity, ShippingState, ShippingZipCode, CustomerCreditCardNumber, ShippingDate, Total 
from Order						
where Order.CustomerIdentifier = @CustomerID							
							
--Truy vấn 2: Đối với một sản phẩm quảng cáo (Advertised_Item) cụ thể, giá thấp nhất mà nhà cung cấp hiện đang cung cấp là bao nhiêu?																		
SELECT ItemNumber, SupplierID, LowestPrice From Advertised_Item							
WHERE Advertised_Item.ItemNumber = @ItemID							
							
--Truy vấn 3: Khi thông tin khách hàng được truy xuất, hãy bao gồm tất cả số thẻ tín dụng của họ.																	
SELECT Customer.CustomerIdentifier,CustomerTelephoneNumber,CustomerName,CustomerStreetAddress,CustomerCity,
CustomerState,CustomerZipCode,CustomerCreditRating,PreferredCreditCard,Credit_Card.CustomerCreditCardNumber,
Credit_Card.CustomerCreditCardName ,Credit_Card.NumberUsed						
from Customer join Credit_Card on Customer.CustomerIdentifier =Credit_Card.CustomerIdentifier							
where Customer.CustomerIdentifier = @CustomerID							
							
--Truy vấn 4: Giả định bổ sung thuộc tính PreferredOption vào bảng Credit_Card để quản lý thẻ tín dụng yêu thích của khách hàng. Khi thông tin khách hàng truy xuất, cho biết thông tin thẻ tín dụng sử dụng yêu thích của họ.													
select CustomerIdentifier,CustomerTelephoneNumber,CustomerName,CustomerStreetAddress,CustomerCity,
CustomerState,CustomerZipCode,CustomerCreditRating,PreferredCreditCard from Customer						
where Customer.CustomerIdentifer = @CustomerID							
							
--Truy vấn 5: Cho biết thông tin khách hàng và số lần sử dụng trên mỗi thẻ tín dụng của họ														
select Customer.CustomerIdentifier,CustomerTelephoneNumber,CustomerName,CustomerStreetAddress,CustomerCity,
CustomerState,CustomerZipCode,CustomerCreditRating,PreferredCreditCard,
 Credit_Card.CustomerCreditCardNumber, Credit_Card.NumberUsed							
from Customer join Credit_Card on Customer.CustomerIdentifier = Credit_Card.CustomerIdentifier							
where Customer.CustomerIdentifier = @CustomerID							
							
--Truy vấn 6: Cho biết thông tin khách hàng và số đơn hàng mà khách hàng đã mua.															
SELECT C.CustomerIdentifier,C.CustomerTelephoneNumber,C.CustomerName,C.CustomerStreetAddress,
c.CustomerCity,c.CustomerState,c.CustomerZipCode,c.CustomerCreditRating,c.PreferredCreditCard,NumberOfOrders							
FROM Customer C							
INNER JOIN							
(SELECT COUNT(O.OrderNumber) as NumberOfOrders, CustomerIdentifier							
FROM Orders O							
GROUP BY O.CustomerIdentifier) t2							
ON C.CustomerIdentifier = t2.CustomerIdentifier							
							
--Truy vấn 7: Cho biết 20 sản phẩm bán chạy nhất				
SELECT TOP 20 ai.ItemNumber, ai.ItemDescription, ai.ItemDepartment, ai.ItemWeight, ai.ItemColor, 
ai.ItemPrice, ai.LowestPrice, ai.SupplierID FROM Advertised_Item ai							
JOIN (SELECT ItemNumber, SUM(QuantityOrdered) as NumbersOfItem							
FROM Ordered_Item							
GROUP BY ItemNumber) t2 ON ai.ItemNumber=t2.ItemNumber							
ORDER BY NumbersOfItem DESC							
							
--Truy vấn 8: Cho biết thông tin nhà cung cấp cung cấp nhiều sản phẩm nhất				
Select SupplierID,SupplierName,SupplierStreetAddress,SupplierCity,SupplierState,SupplierZipCode from Supplier							
where Supplier.Total_Item= ( Select MAX (Total_Item) from Supplier)							
