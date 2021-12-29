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

create trigger TotalItem on Restock_Item
for insert
as
begin
	update Supplier
	set Total_Item = Total_Item+1
	from inserted i 
	where i.SupplierID = Supplier.SupplierID
end
go