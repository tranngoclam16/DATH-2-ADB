CREATE DATABASE Order_Entry
GO
USE Order_Entry
GO
CREATE TABLE Customer(
  CustomerIdentifier BIGINT identity(1,1),
  CustomerTelephoneNumber varchar(10),
  CustomerName NVARCHAR(100),
  CustomerStreetAddress nvarchar(100),
  CustomerCity NVARCHAR(100),
  CustomerState NVARCHAR(100),
  CustomerZipCode VARCHAR(50),
  CustomerCreditRating NVARCHAR(100),
  PreferredCreditCard varchar(20),
  PRIMARY KEY (CustomerIdentifier)
)

CREATE TABLE Credit_Card(
  CustomerCreditCardNumber VARCHAR(20),
  CustomerCreditCardName NVARCHAR(100) NOT NULL,
  CustomerIdentifier BIGINT FOREIGN KEY REFERENCES Customer(CustomerIdentifier),
  NumberUsed INT CHECK (NumberUsed>=0),
  PreferredOption VARCHAR(5) CHECK (PreferredOption IN ('Yes','No'))
  PRIMARY KEY(CustomerCreditCardNumber) 
)

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Preferred
FOREIGN KEY (PreferredCreditCard) REFERENCES Credit_Card(CustomerCreditCardNumber);

CREATE TABLE Orders(
  OrderNumber BIGINT identity(1,1),
  CustomerTelephoneNumber VARCHAR(10) NOT NULL,
  CustomerIdentifier BIGINT NOT NULL FOREIGN KEY REFERENCES Customer(CustomerIdentifier),
  OrderDate DATE,
  ShippingStreetAddress NVARCHAR(100) NOT NULL,
  ShippingCity NVARCHAR(100) NOT NULL,
  ShippingState NVARCHAR(100) NOT NULL,
  ShippingZipCode VARCHAR(50) NOT NULL,
  CustomerCreditCardNumber VARCHAR(20) NOT NULL FOREIGN KEY REFERENCES Credit_Card(CustomerCreditCardNumber),
  ShippingDate DATE,
  Total INT
  PRIMARY KEY(OrderNumber)
)

CREATE TABLE Supplier(
  SupplierID VARCHAR(6),
  SupplierName NVARCHAR(100) NOT NULL,
  SupplierStreetAddress NVARCHAR(100) NOT NULL,
  SupplierCity NVARCHAR(100) NOT NULL,
  SupplierState NVARCHAR(100) NOT NULL,
  SupplierZipCode VARCHAR(50) NOT NULL,
  PRIMARY KEY(SupplierID)
)

Alter table Supplier
add Total_Item int

CREATE TABLE Advertised_Item (
  ItemNumber BIGINT identity(1,1),
  ItemDescription NVARCHAR(255) UNIQUE,
  ItemDepartment VARCHAR(10),
  ItemWeight FLOAT CHECK(ItemWeight>0.0),
  ItemColor NVARCHAR(50),
  ItemPrice int CHECK (ItemPrice>0),
  LowestPrice int CHECK (LowestPrice>0),
  SupplierID varchar(6) FOREIGN KEY REFERENCES Supplier(SupplierID),
  PRIMARY KEY(ItemNumber)
)

CREATE TABLE Ordered_Item(
  ItemNumber BIGINT FOREIGN KEY REFERENCES Advertised_Item(ItemNumber),
  OrderNumber BIGINT FOREIGN KEY REFERENCES Orders(OrderNumber),
  QuantityOrdered INT NOT NULL CHECK (QuantityOrdered>0),
  SellingPrice int,
  ShippingDate DATE,
  PRIMARY KEY(ItemNumber, OrderNumber)
)

CREATE TABLE Restock_Item(
  ItemNumber  BIGINT FOREIGN KEY REFERENCES Advertised_Item(ItemNumber),
  SupplierID varchar(6) FOREIGN KEY REFERENCES Supplier(SupplierID),
  SellingPrice INT CHECK (SellingPrice>0) 
  PRIMARY KEY(ItemNumber, SupplierID)
)





/*
USE [master]
GO

IF DB_ID('Order_Entry') IS NOT NULL BEGIN
	--ALTER DATABASE [database_name] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [Order_Entry]
END
GO
*/

             