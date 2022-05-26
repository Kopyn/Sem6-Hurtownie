--Zad1
SELECT COUNT(*) FROM Production.Product;
SELECT COUNT(*) FROM Production.ProductCategory;
SELECT COUNT(*) FROM Production.ProductSubcategory;


--Zad2
SELECT * FROM Production.Product WHERE Product.Color IS NULL;


--Zad3
SELECT YEAR(Sales.SalesOrderHeader.OrderDate), SUM(Sales.SalesOrderHeader.TotalDue) FROM Sales.SalesOrderHeader GROUP BY YEAR(Sales.SalesOrderHeader.OrderDate);


--Zad4
SELECT COUNT(*) FROM Sales.SalesPerson;
SELECT COUNT(*) FROM Sales.Customer;
SELECT Sales.SalesTerritory.Name, COUNT(*) 
FROM Sales.SalesPerson 
FULL OUTER JOIN Sales.SalesTerritory ON Sales.SalesPerson.TerritoryID = Sales.SalesTerritory.TerritoryID 
GROUP BY Sales.SalesTerritory.Name;
SELECT Sales.SalesTerritory.Name, COUNT(*) 
FROM Sales.Customer 
FULL OUTER JOIN Sales.SalesTerritory ON Sales.Customer.TerritoryID = Sales.SalesTerritory.TerritoryID 
GROUP BY Sales.SalesTerritory.Name;


--Zad5
SELECT YEAR(Sales.SalesOrderHeader.OrderDate), COUNT(*) FROM Sales.SalesOrderHeader GROUP BY YEAR(Sales.SalesOrderHeader.OrderDate);


--Zad6
SELECT Production.ProductCategory.Name, Production.ProductSubcategory.Name, Production.Product.*
FROM Production.Product
LEFT JOIN Sales.SalesOrderDetail ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID
WHERE Sales.SalesOrderDetail.SalesOrderID IS NULL
ORDER BY Production.ProductCategory.Name, Production.ProductSubcategory.Name;


--Zad7
SELECT Production.ProductSubcategory.Name, MIN(Sales.SalesOrderDetail.UnitPriceDiscount), MAX(Sales.SalesOrderDetail.UnitPriceDiscount)
FROM Production.Product
JOIN Sales.SalesOrderDetail ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
GROUP BY Production.ProductSubcategory.Name;


--Zad8
SELECT Production.Product.*
FROM Production.Product
WHERE Production.Product.ListPrice > (SELECT AVG(Production.Product.ListPrice) FROM Production.Product);



--Zad9
SELECT MONTH(Sales.SalesOrderHeader.OrderDate), SUM(Sales.SalesOrderDetail.OrderQty)/(SELECT COUNT(DISTINCT YEAR(Sales.SalesOrderHeader.OrderDate)) FROM Sales.SalesOrderHeader)
FROM Sales.SalesOrderDetail
JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
GROUP BY MONTH(Sales.SalesOrderHeader.OrderDate)
ORDER BY 1;



--Zad10
SELECT Sales.SalesTerritory.Name, AVG(CAST(DATEDIFF(day, Sales.SalesOrderHeader.OrderDate, Sales.SalesOrderHeader.ShipDate) AS float))
FROM Sales.SalesOrderHeader
JOIN Sales.SalesTerritory ON Sales.SalesTerritory.TerritoryID = Sales.SalesOrderHeader.TerritoryID
GROUP BY Sales.SalesTerritory.Name;