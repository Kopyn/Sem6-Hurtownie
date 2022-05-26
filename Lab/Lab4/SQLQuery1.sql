--1--
CREATE SCHEMA Kopinski;

--2--
CREATE TABLE Kopinski.DIM_CUSTOMER (
	CustomerID INT NOT NULL,
	FirstName NVARCHAR(50) NOT NULL, 
	LastName NVARCHAR(50) NOT NULL, 
	Title NVARCHAR(8), 
	City NVARCHAR(50), 
	TerritoryName NVARCHAR(50), 
	CountryRegionCode NVARCHAR(2), 
	[Group] NVARCHAR(50)
); 
DROP TABLE Kopinski.DIM_CUSTOMER;

CREATE TABLE Kopinski.DIM_PRODUCT (
	ProductID INT NOT NULL, 
	[Name] NVARCHAR(50) NOT NULL, 
	ListPrice MONEY NOT NULL, 
	Color NVARCHAR(50), 
	SubCategoryName NVARCHAR(50), 
	CategoryName NVARCHAR(50), 
	[Weight] DECIMAL(8,2), 
	Size NVARCHAR(5), 
	IsPurchased BIT NOT NULL
);
DROP TABLE Kopinski.DIM_PRODUCT;

CREATE TABLE Kopinski.DIM_SALESPERSON (
	SalesPersonID INT NOT NULL, 
	FirstName NVARCHAR(50) NOT NULL, 
	LastName NVARCHAR(50) NOT NULL, 
	Title NVARCHAR(8), 
	Gender NVARCHAR(1) CHECK (Gender in ('F', 'M')), 
	CountryRegionCode NVARCHAR(2), 
	[Group] NVARCHAR(50)
);
DROP TABLE Kopinski.DIM_SALESPERSON;

CREATE TABLE Kopinski.FACT_SALES (
	ProductID INT NOT NULL, 
	CustomerID INT NOT NULL,
	SalesPersonID INT, 
	OrderDate INT NOT NULL, 
	ShipDate INT NOT NULL, 
	OrderQty INT NOT NULL, 
	UnitPrice MONEY NOT NULL, 
	UnitPriceDiscount MONEY NOT NULL, 
	LineTotal DECIMAL(38,6) NOT NULL
);

SELECT * FROM Kopinski.FACT_SALES;
SELECT * FROM Kopinski.DIM_CUSTOMER;

DROP TABLE Kopinski.FACT_SALES;

--3--
WITH Customer (CustomerID, FirstName, LastName, Title, City, TerritoryName, CountryRegionCode, [Group]) 
AS (
	SELECT DISTINCT C.CustomerID, P.FirstName, P.LastName, P.Title, A.City, T.[Name], T.CountryRegionCode, T.[Group] 
	FROM Sales.Customer C
	LEFT JOIN Person.Person P ON C.PersonID = P.BusinessEntityID
	JOIN Sales.SalesOrderHeader SOH ON C.CustomerID = SOH.CustomerID
	LEFT JOIN Person.[Address] A ON SOH.BillToAddressID = A.AddressID
	LEFT JOIN Sales.SalesTerritory T ON C.TerritoryID = T.TerritoryID
) INSERT INTO Kopinski.DIM_CUSTOMER (CustomerID, FirstName, LastName, Title, City, TerritoryName, CountryRegionCode, [Group])
SELECT * FROM Customer;

SELECT COUNT(*) FROM Sales.Customer;
SELECT COUNT(*) FROM Kopinski.DIM_CUSTOMER;

WITH Product (ProductID, [Name], ListPrice, Color, SubCategoryName, CategoryName, [Weight], Size, IsPurchased) 
AS (
	SELECT DISTINCT P.ProductID, P.[Name], P.ListPrice, P.Color, S.[Name], C.[Name], P.Weight, P.Size, 
	CASE (P.MakeFlag) WHEN 0 THEN 1 ELSE 0 END AS IsPurchased
	FROM Production.Product P 
	JOIN Sales.SalesOrderDetail SOD ON SOD.ProductID = P.ProductID
	LEFT JOIN Production.ProductSubcategory S ON P.ProductSubcategoryID = S.ProductSubcategoryID
	LEFT JOIN Production.ProductCategory C ON S.ProductCategoryID = C.ProductCategoryID
) INSERT INTO Kopinski.DIM_PRODUCT (ProductID, [Name], ListPrice, Color, SubCategoryName, CategoryName, [Weight], Size, IsPurchased)
SELECT * FROM Product;



SELECT COUNT(*) FROM Production.Product;
SELECT COUNT(*) FROM Kopinski.DIM_PRODUCT;

WITH SalesPerson (SalesPersonID, FirstName, LastName, Title, Gender, CountryRegionCode, [Group]) 
AS (
	SELECT SP.BusinessEntityID, P.FirstName, P.LastName, P.Title, E.GENDER, T.CountryRegionCode, T.[Group] 
	FROM Sales.SalesPerson SP
	JOIN HumanResources.Employee E ON SP.BusinessEntityID = E.BusinessEntityID
	JOIN Person.Person P ON SP.BusinessEntityID = P.BusinessEntityID	
	LEFT JOIN Sales.SalesTerritory T ON SP.TerritoryID = T.TerritoryID
) INSERT INTO Kopinski.DIM_SALESPERSON (SalesPersonID, FirstName, LastName, Title, Gender, CountryRegionCode, [Group])
SELECT * FROM SalesPerson;

SELECT * FROM Kopinski.DIM_SALESPERSON;
SELECT * FROM Sales.SalesPerson SP
JOIN HumanResources.Employee E ON SP.BusinessEntityID = E.BusinessEntityID
JOIN Person.Person P ON SP.BusinessEntityID = P.BusinessEntityID;
SELECT COUNT(*) FROM Kopinski.DIM_SALESPERSON;

WITH FactSales (ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal) AS (
	SELECT SOD.ProductID, SOH.CustomerID, SOH.SalesPersonID, 
	DATEPART(YYYY, SOH.OrderDate) * 10000 + DATEPART(MM, SOH.OrderDate) * 100 + DATEPART(DD, SOH.OrderDate),
	DATEPART(YYYY, SOH.ShipDate) * 10000 + DATEPART(MM, SOH.ShipDate) * 100 + DATEPART(DD, SOH.ShipDate),
	SOD.OrderQty, SOD.UnitPrice, SOD.UnitPriceDiscount, SOD.LineTotal
	FROM Sales.SalesOrderHeader SOH
	JOIN Sales.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	JOIN Sales.Customer C ON SOH.CustomerID = C.CustomerID
	LEFT JOIN Sales.SalesPerson P ON SOH.SalesPersonID = P.BusinessEntityID
) INSERT INTO Kopinski.FACT_SALES (ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal)
SELECT * FROM FactSales;

SELECT COUNT(*) FROM Sales.SalesOrderDetail;
SELECT COUNT(*) FROM Kopinski.FACT_SALES;

SELECT * FROM Kopinski.FACT_SALES ORDER BY 8 DESC;

--4--
ALTER TABLE Kopinski.DIM_CUSTOMER
ADD CONSTRAINT CUSTOMER_PRIMARY_KEY UNIQUE(CustomerID), PRIMARY KEY(CustomerID);

ALTER TABLE Kopinski.DIM_PRODUCT
ADD CONSTRAINT PRODUCT_PRIMARY_KEY UNIQUE(ProductID), PRIMARY KEY(ProductID);

ALTER TABLE Kopinski.DIM_SALESPERSON
ADD CONSTRAINT SALESPERSON_PRIMARY_KEY UNIQUE(SalesPersonID), PRIMARY KEY(SalesPersonID);

ALTER TABLE Kopinski.FACT_SALES
ADD CONSTRAINT CUSTOMER_FOREIGN_KEY FOREIGN KEY(CustomerID) REFERENCES Kopinski.DIM_CUSTOMER(CustomerID), 
	CONSTRAINT PRODUCT_FOREIGN_KEY FOREIGN KEY(ProductID) REFERENCES Kopinski.DIM_PRODUCT(ProductID), 
	CONSTRAINT SALESPERSON_FOREIGN_KEY FOREIGN KEY(SalesPersonID) REFERENCES Kopinski.DIM_SALESPERSON(SalesPersonID); 