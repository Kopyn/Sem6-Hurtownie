--LISTA 5

--ZAPYTANIA Z LISTY 4:

--TWORZENIE SCHEMATU (4.1):
CREATE SCHEMA Kopinski;

--4.2
CREATE TABLE Kopinski.DIM_CUSTOMER (
	CustomerID INT NOT NULL,
	FirstName NVARCHAR(50) NOT NULL, 
	LastName NVARCHAR(50) NOT NULL, 
	Title NVARCHAR(8), 
	City NVARCHAR(50), 
	TerritoryName NVARCHAR(50), 
	CountryRegionCode NVARCHAR(3), 
	[Group] NVARCHAR(50)
); 

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

CREATE TABLE Kopinski.DIM_SALESPERSON (
	SalesPersonID INT NOT NULL, 
	FirstName NVARCHAR(50) NOT NULL, 
	LastName NVARCHAR(50) NOT NULL, 
	Title NVARCHAR(8), 
	Gender NVARCHAR(1) CHECK (Gender in ('F', 'M')), 
	CountryRegionCode NVARCHAR(3), 
	[Group] NVARCHAR(50)
);

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

--4.3
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

SELECT * FROM Kopinski.DIM_CUSTOMER
SELECT * FROM Production.Product

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



WITH SalesPerson (SalesPersonID, FirstName, LastName, Title, Gender, CountryRegionCode, [Group]) 
AS (
	SELECT SP.BusinessEntityID, P.FirstName, P.LastName, P.Title, E.GENDER, T.CountryRegionCode, T.[Group] 
	FROM Sales.SalesPerson SP
	JOIN HumanResources.Employee E ON SP.BusinessEntityID = E.BusinessEntityID
	JOIN Person.Person P ON SP.BusinessEntityID = P.BusinessEntityID	
	LEFT JOIN Sales.SalesTerritory T ON SP.TerritoryID = T.TerritoryID
) INSERT INTO Kopinski.DIM_SALESPERSON (SalesPersonID, FirstName, LastName, Title, Gender, CountryRegionCode, [Group])
SELECT * FROM SalesPerson;

SELECT * FROM Kopinski.DIM_SALESPERSON

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

SELECT Max(f.OrderQty) FROM Kopinski.FACT_SALES f

SELECT * FROM Kopinski.DIM_TIME

--4.4
ALTER TABLE Kopinski.DIM_CUSTOMER
ADD CONSTRAINT CUSTOMER_PRIMARY_KEY UNIQUE(CustomerID), PRIMARY KEY(CustomerID);

ALTER TABLE Kopinski.DIM_PRODUCT
ADD CONSTRAINT PRODUCT_PRIMARY_KEY UNIQUE(ProductID), PRIMARY KEY(ProductID);

ALTER TABLE Kopinski.DIM_SALESPERSON
ADD CONSTRAINT SALESPERSON_PRIMARY_KEY UNIQUE(SalesPersonID), PRIMARY KEY(SalesPersonID);

ALTER TABLE Kopinski.DIM_TIME
ADD CONSTRAINT DIM_TIME_PRIMARY_KEY UNIQUE(PK_TIME), PRIMARY KEY(PK_TIME);

ALTER TABLE Kopinski.FACT_SALES
ADD CONSTRAINT CUSTOMER_FOREIGN_KEY FOREIGN KEY(CustomerID) REFERENCES Kopinski.DIM_CUSTOMER(CustomerID), 
    CONSTRAINT PRODUCT_FOREIGN_KEY FOREIGN KEY(ProductID) REFERENCES Kopinski.DIM_PRODUCT(ProductID), 
    CONSTRAINT SALESPERSON_FOREIGN_KEY FOREIGN KEY(SalesPersonID) REFERENCES Kopinski.DIM_SALESPERSON(SalesPersonID),
    CONSTRAINT DIM_TIME_ORDERDATE_FOREIGN_KEY FOREIGN KEY(OrderDate) REFERENCES Kopinski.DIM_TIME(PK_TIME),
    CONSTRAINT DIM_TIME_SHIPDATE_FOREIGN_KEY FOREIGN KEY(ShipDate) REFERENCES Kopinski.DIM_TIME(PK_TIME);  

--5.1
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_CUSTOMER' AND TABLE_SCHEMA = 'Kopinski')
   DROP TABLE Kopinski.DIM_CUSTOMER;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_PRODUCT' AND TABLE_SCHEMA = 'Kopinski')
   DROP TABLE Kopinski.DIM_PRODUCT;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_SALESPERSON' AND TABLE_SCHEMA = 'Kopinski')
   DROP TABLE Kopinski.DIM_SALESPERSON;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'FACT_SALES' AND TABLE_SCHEMA = 'Kopinski')
   DROP TABLE Kopinski.FACT_SALES;

--5.2
SELECT * FROM Kopinski.FACT_SALES
ORDER BY 4
SELECT DISTINCT fs.OrderDate, fs.OrderDate/10000, fs.OrderDate/100 - fs.OrderDate/10000 * 100, 
CASE 
	WHEN RIGHT(fs.OrderDate, 2) > 9 THEN RIGHT(fs.OrderDate, 2)
	ELSE RIGHT(fs.OrderDate, 1) 
END
FROM Kopinski.FACT_SALES fs

CREATE TABLE Kopinski.DIM_TIME (
	PK_TIME INT NOT NULL,
	"Year" INT NOT NULL, 
	"Quarter" INT NOT NULL, 
	"Month" INT NOT NULL, 
	"MonthInWords" NVARCHAR(50) NOT NULL, 
	"DayOfWeekInWords" NVARCHAR(50) NOT NULL, 
	"DayOfMonth" INT NOT NULL, 
); 

SELECT * FROM Kopinski.DIM_TIME

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DIM_TIME' AND TABLE_SCHEMA = 'Kopinski')
   DROP TABLE Kopinski.DIM_TIME;

SELECT * FROM #Dni

IF OBJECT_ID(N'tempdb..#Dni') IS NOT NULL
BEGIN
DROP TABLE #Dni
END

SET DATEFIRST 1;
SELECT DISTINCT DATEPART(dw, OrderDate) Numer,
	CASE 
		WHEN DATEPART(dw, OrderDate) = 1 THEN 'Poniedzia³ek'
		WHEN DATEPART(dw, OrderDate) = 2 THEN 'Wtorek'
		WHEN DATEPART(dw, OrderDate) = 3 THEN 'Œroda'
		WHEN DATEPART(dw, OrderDate) = 4 THEN 'Czwartek'
		WHEN DATEPART(dw, OrderDate) = 5 THEN 'Pi¹tek'
		WHEN DATEPART(dw, OrderDate) = 6 THEN 'Sobota'
		WHEN DATEPART(dw, OrderDate) = 7 THEN 'Niedziela'
	END Nazwa
INTO Kopinski.Dni
FROM Sales.SalesOrderHeader;

SELECT DISTINCT MONTH(OrderDate) Numer,
	CASE 
		WHEN MONTH(OrderDate) = 1 THEN 'Styczeñ'
		WHEN MONTH(OrderDate) = 2 THEN 'Luty'
		WHEN MONTH(OrderDate) = 3 THEN 'Marzec'
		WHEN MONTH(OrderDate) = 4 THEN 'Kwiecieñ'
		WHEN MONTH(OrderDate) = 5 THEN 'Maj'
		WHEN MONTH(OrderDate) = 6 THEN 'Czerwiec'
		WHEN MONTH(OrderDate) = 7 THEN 'Lipiec'
		WHEN MONTH(OrderDate) = 8 THEN 'Sierpieñ'
		WHEN MONTH(OrderDate) = 9 THEN 'Wrzesieñ'
		WHEN MONTH(OrderDate) = 10 THEN 'PaŸdziernik'
		WHEN MONTH(OrderDate) = 11 THEN 'Listopad'
		WHEN MONTH(OrderDate) = 12 THEN 'Grudzieñ'
	END Nazwa
INTO Kopinski.Miesiace
FROM Sales.SalesOrderHeader;


DECLARE @D INT;
SET @D = (SELECT TOP 1 OrderDate FROM Kopinski.FACT_SALES ORDER BY 1);
DECLARE @COUNTER DATE;
SET @COUNTER = CONVERT(date, CAST(@D AS nvarchar));
DECLARE @END INT;
SET @END = (SELECT TOP 1 ShipDate FROM Kopinski.FACT_SALES ORDER BY 1 DESC);
WHILE (@D <= @END)
BEGIN
	INSERT INTO Kopinski.DIM_TIME VALUES
(
	@D,
	YEAR(@COUNTER),
	DATEPART(QQ, @COUNTER),
	MONTH(@COUNTER),
	(SELECT Nazwa FROM #Miesiace WHERE Numer = MONTH(@COUNTER)),
	(SELECT Nazwa FROM #Dni WHERE Numer = DATEPART(DW, @COUNTER)),
	DAY(@COUNTER)
);
	SET @COUNTER = DATEADD(DAY, 1, @COUNTER);
	SET @D = CAST(CONVERT(varchar(8), @COUNTER, 112) AS INT);
END;

SELECT * FROM Kopinski.DIM_TIME ORDER BY 1

--5.3
SELECT * FROM Kopinski.DIM_PRODUCT
UPDATE Kopinski.DIM_PRODUCT
SET Color='Unknown'
WHERE Color IS NULL;

UPDATE Kopinski.DIM_PRODUCT
SET SubCategoryName='Unknown'
WHERE SubCategoryName IS NULL;

SELECT * FROM Kopinski.DIM_CUSTOMER
SELECT * FROM Kopinski.DIM_SALESPERSON

UPDATE Kopinski.DIM_CUSTOMER
SET CountryRegionCode='000'
WHERE CountryRegionCode IS NULL;

UPDATE Kopinski.DIM_CUSTOMER
SET [Group]='Unknown'
WHERE [Group] IS NULL;

UPDATE Kopinski.DIM_SALESPERSON
SET CountryRegionCode='000'
WHERE CountryRegionCode IS NULL;

UPDATE Kopinski.DIM_SALESPERSON
SET [Group]='Unknown'
WHERE [Group] IS NULL;
