SELECT * FROM Kopinski.FACT_SALES;

CREATE TABLE Kopinski.FACT_SALES_2011 (
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

DROP TABLE Kopinski.FACT_SALES_2011;

WITH FactSales2011 (ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal) AS (
	SELECT ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal
	FROM Kopinski.FACT_SALES
	WHERE OrderDate/10000 = 2011
) INSERT INTO Kopinski.FACT_SALES_2011 (ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal)
SELECT * FROM FactSales2011;

ALTER TABLE Kopinski.FACT_SALES_2011
ADD CONSTRAINT CUSTOMER_FOREIGN_KEY_2011 FOREIGN KEY(CustomerID) REFERENCES Kopinski.DIM_CUSTOMER(CustomerID), 
    CONSTRAINT PRODUCT_FOREIGN_KEY_2011 FOREIGN KEY(ProductID) REFERENCES Kopinski.DIM_PRODUCT(ProductID), 
    CONSTRAINT SALESPERSON_FOREIGN_KEY_2011 FOREIGN KEY(SalesPersonID) REFERENCES Kopinski.DIM_SALESPERSON(SalesPersonID),
    CONSTRAINT DIM_TIME_ORDERDATE_FOREIGN_KEY_2011 FOREIGN KEY(OrderDate) REFERENCES Kopinski.DIM_TIME(PK_TIME),
    CONSTRAINT DIM_TIME_SHIPDATE_FOREIGN_KEY_2011 FOREIGN KEY(ShipDate) REFERENCES Kopinski.DIM_TIME(PK_TIME);  

SELECT * FROM Kopinski.FACT_SALES_2011;

--2012
CREATE TABLE Kopinski.FACT_SALES_2012 (
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

DROP TABLE Kopinski.FACT_SALES_2012;

WITH FactSales2012 (ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal) AS (
	SELECT ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal
	FROM Kopinski.FACT_SALES
	WHERE OrderDate/10000 = 2012
) INSERT INTO Kopinski.FACT_SALES_2012 (ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal)
SELECT * FROM FactSales2012;

ALTER TABLE Kopinski.FACT_SALES_2012
ADD CONSTRAINT CUSTOMER_FOREIGN_KEY_2012 FOREIGN KEY(CustomerID) REFERENCES Kopinski.DIM_CUSTOMER(CustomerID), 
    CONSTRAINT PRODUCT_FOREIGN_KEY_2012 FOREIGN KEY(ProductID) REFERENCES Kopinski.DIM_PRODUCT(ProductID), 
    CONSTRAINT SALESPERSON_FOREIGN_KEY_2012 FOREIGN KEY(SalesPersonID) REFERENCES Kopinski.DIM_SALESPERSON(SalesPersonID),
    CONSTRAINT DIM_TIME_ORDERDATE_FOREIGN_KEY_2012 FOREIGN KEY(OrderDate) REFERENCES Kopinski.DIM_TIME(PK_TIME),
    CONSTRAINT DIM_TIME_SHIPDATE_FOREIGN_KEY_2012 FOREIGN KEY(ShipDate) REFERENCES Kopinski.DIM_TIME(PK_TIME);  

SELECT * FROM Kopinski.FACT_SALES_2012;


--2013
CREATE TABLE Kopinski.FACT_SALES_2013 (
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

DROP TABLE Kopinski.FACT_SALES_2013;

WITH FactSales2013 (ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal) AS (
	SELECT ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal
	FROM Kopinski.FACT_SALES
	WHERE OrderDate/10000 = 2013
) INSERT INTO Kopinski.FACT_SALES_2013 (ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal)
SELECT * FROM FactSales2013;

ALTER TABLE Kopinski.FACT_SALES_2013
ADD CONSTRAINT CUSTOMER_FOREIGN_KEY_2013 FOREIGN KEY(CustomerID) REFERENCES Kopinski.DIM_CUSTOMER(CustomerID), 
    CONSTRAINT PRODUCT_FOREIGN_KEY_2013 FOREIGN KEY(ProductID) REFERENCES Kopinski.DIM_PRODUCT(ProductID), 
    CONSTRAINT SALESPERSON_FOREIGN_KEY_2013 FOREIGN KEY(SalesPersonID) REFERENCES Kopinski.DIM_SALESPERSON(SalesPersonID),
    CONSTRAINT DIM_TIME_ORDERDATE_FOREIGN_KEY_2013 FOREIGN KEY(OrderDate) REFERENCES Kopinski.DIM_TIME(PK_TIME),
    CONSTRAINT DIM_TIME_SHIPDATE_FOREIGN_KEY_2013 FOREIGN KEY(ShipDate) REFERENCES Kopinski.DIM_TIME(PK_TIME);  

SELECT * FROM Kopinski.FACT_SALES_2013;


--2014

CREATE TABLE Kopinski.FACT_SALES_2014 (
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

DROP TABLE Kopinski.FACT_SALES_2014;

WITH FactSales2014 (ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal) AS (
	SELECT ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal
	FROM Kopinski.FACT_SALES
	WHERE OrderDate/10000 = 2014
) INSERT INTO Kopinski.FACT_SALES_2014 (ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderQty, UnitPrice, UnitPriceDiscount, LineTotal)
SELECT * FROM FactSales2014;

ALTER TABLE Kopinski.FACT_SALES_2014
ADD CONSTRAINT CUSTOMER_FOREIGN_KEY_2014 FOREIGN KEY(CustomerID) REFERENCES Kopinski.DIM_CUSTOMER(CustomerID), 
    CONSTRAINT PRODUCT_FOREIGN_KEY_2014 FOREIGN KEY(ProductID) REFERENCES Kopinski.DIM_PRODUCT(ProductID), 
    CONSTRAINT SALESPERSON_FOREIGN_KEY_2014 FOREIGN KEY(SalesPersonID) REFERENCES Kopinski.DIM_SALESPERSON(SalesPersonID),
    CONSTRAINT DIM_TIME_ORDERDATE_FOREIGN_KEY_2014 FOREIGN KEY(OrderDate) REFERENCES Kopinski.DIM_TIME(PK_TIME),
    CONSTRAINT DIM_TIME_SHIPDATE_FOREIGN_KEY_2014 FOREIGN KEY(ShipDate) REFERENCES Kopinski.DIM_TIME(PK_TIME);  

SELECT * FROM Kopinski.FACT_SALES_2014;