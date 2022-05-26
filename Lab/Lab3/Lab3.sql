--Zad1
--1.1
--ROLLUP
SELECT p.FirstName + ' ' + p.LastName AS Klient, YEAR(soh.OrderDate) AS Rok, SUM(soh.TotalDue) AS Kwota
FROM Person.Person p
JOIN Sales.Customer c ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
GROUP BY ROLLUP(p.FirstName + ' ' + p.LastName, YEAR(soh.OrderDate))
ORDER BY 1;

--CUBE
SELECT p.FirstName + ' ' + p.LastName AS Klient, YEAR(soh.OrderDate) AS Rok, SUM(soh.TotalDue) AS Kwota
FROM Person.Person p
JOIN Sales.Customer c ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
GROUP BY CUBE(p.FirstName + ' ' + p.LastName, YEAR(soh.OrderDate))
ORDER BY 1, 2, 3;

--GROUPING SETS
SELECT p.FirstName + ' ' + p.LastName AS Klient, YEAR(soh.OrderDate) AS Rok, SUM(soh.TotalDue) AS Kwota
FROM Person.Person p
JOIN Sales.Customer c ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
GROUP BY GROUPING SETS(
	(),
	(YEAR(soh.OrderDate)),
	(p.FirstName + ' ' + p.LastName),
	(p.FirstName + ' ' + p.LastName, YEAR(soh.OrderDate))
)
ORDER BY 1, 2, 3;

--1.2
SELECT pc.Name, p.Name, YEAR(soh.OrderDate), SUM(sod.UnitPriceDiscount * sod.UnitPrice * sod.OrderQty)
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory ps ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Sales.SalesOrderDetail sod ON sod.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY GROUPING SETS(
	(pc.Name, p.Name, YEAR(soh.OrderDate)),
	(pc.Name, p.Name)
)
ORDER BY 1, 2, 3;



--Zad2
--2.1
SELECT sod.*, soh.*
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID;


Select Name FROM Production.ProductCategory;

SELECT DISTINCT pc.Name AS Nazwa, YEAR(soh.OrderDate) AS Rok, 100 * SUM(sod.LineTotal) OVER(PARTITION BY YEAR(soh.OrderDate))/SUM(sod.LineTotal) OVER() AS Procent
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory ps ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Sales.SalesOrderDetail sod ON sod.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
WHERE pc.Name='Bikes';

SELECT DISTINCT pc.Name AS Nazwa, YEAR(soh.OrderDate) AS Rok, SUM(sod.LineTotal) OVER(PARTITION BY YEAR(soh.OrderDate))/SUM(sod.LineTotal) OVER() AS Procent
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory ps ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Sales.SalesOrderDetail sod ON sod.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
WHERE pc.Name='Accessories'
ORDER BY 2;

SELECT DISTINCT pc.Name AS Nazwa, YEAR(soh.OrderDate) AS Rok, SUM(sod.LineTotal) OVER(PARTITION BY YEAR(soh.OrderDate))/SUM(sod.LineTotal) OVER() AS Procent
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory ps ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Sales.SalesOrderDetail sod ON sod.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
WHERE pc.Name='Clothing'
ORDER BY 2;

SELECT DISTINCT pc.Name AS Nazwa, YEAR(soh.OrderDate) AS Rok, SUM(sod.LineTotal) OVER(PARTITION BY YEAR(soh.OrderDate))/SUM(sod.LineTotal) OVER() AS Procent
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory ps ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Sales.SalesOrderDetail sod ON sod.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
WHERE pc.Name='Components'
ORDER BY 2;


--2.2
SELECT DISTINCT c.CustomerID AS id, YEAR(soh.OrderDate) AS Rok, COUNT(soh.SalesOrderID) OVER(PARTITION BY c.CustomerID ORDER BY YEAR(soh.OrderDate)) AS Liczba
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
WHERE c.CustomerID IN (
SELECT TOP 10 Sales.Customer.CustomerID AS cID
FROM Sales.Customer
JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
ORDER BY COUNT(Sales.SalesOrderHeader.SalesOrderID) OVER (PARTITION BY c.CustomerID) DESC
)
ORDER BY 1, 2;



--2.3
SELECT "Imiê i nazwisko", Rok, Miesi¹c, "W miesi¹cu", "W roku", "W roku narastaj¹co", 
SUM("W miesi¹cu") OVER (PARTITION BY "Imiê i nazwisko", Rok ORDER BY Miesi¹c ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) 
AS "Obecny i poprzedni miesi¹c"
FROM(
SELECT DISTINCT p.FirstName + ' ' + p.LastName AS "Imiê i nazwisko", YEAR(soh.OrderDate) AS Rok, MONTH(soh.OrderDate) AS Miesi¹c,
COUNT(soh.SalesOrderID) OVER (PARTITION BY p.FirstName + ' ' + p.LastName, YEAR(soh.OrderDate), MONTH(soh.OrderDate)) AS "W miesi¹cu",
COUNT(soh.SalesOrderID) OVER (PARTITION BY p.FirstName + ' ' + p.LastName, YEAR(soh.OrderDate)) AS "W roku",
COUNT(soh.SalesOrderID) OVER (PARTITION BY p.FirstName + ' ' + p.LastName, YEAR(soh.OrderDate) ORDER BY MONTH(soh.OrderDate)) AS "W roku narastaj¹co"
FROM Person.Person p
JOIN HumanResources.Employee e ON e.BusinessEntityID = p.BusinessEntityID
JOIN Sales.SalesPerson sp ON sp.BusinessEntityID = e.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.SalesPersonID = sp.BusinessEntityID
) P;

--2.4
SELECT DISTINCT Kategoria, SUM("Cena max") OVER (PARTITION BY Kategoria)
FROM(
SELECT DISTINCT cat.Name AS Kategoria, subcat.Name AS Podkategoria, 
MAX(p.ListPrice) OVER (PARTITION BY cat.Name, subcat.Name) AS "Cena max"
FROM Production.ProductCategory cat
JOIN Production.ProductSubcategory subcat ON subcat.ProductCategoryID = cat.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = subcat.ProductSubcategoryID
) P;

--SELECT Kategoria, SUM("Cena max")
--FROM(
--SELECT DISTINCT cat.Name AS Kategoria, subcat.Name AS Podkategoria, MAX(p.ListPrice) "Cena max"
--FROM Production.ProductCategory cat
--JOIN Production.ProductSubcategory subcat ON subcat.ProductCategoryID = cat.ProductCategoryID
--JOIN Production.Product p ON p.ProductSubcategoryID = subcat.ProductSubcategoryID
--GROUP BY cat.Name, subcat.Name
--) P
--GROUP BY Kategoria;


--2.5
SELECT Klient, RANK() OVER(ORDER BY Liczba DESC) AS Pozycja
FROM (
SELECT DISTINCT p.FirstName + ' ' + p.LastName AS Klient, COUNT(soh.SalesOrderID) OVER (PARTITION BY p.FirstName + ' ' + p.LastName) Liczba
FROM Person.Person p
JOIN Sales.Customer c ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
) P
ORDER BY 2;

SELECT Klient, DENSE_RANK() OVER(ORDER BY Liczba DESC) AS Pozycja
FROM (
SELECT DISTINCT p.FirstName + ' ' + p.LastName AS Klient, COUNT(soh.SalesOrderID) OVER (PARTITION BY p.FirstName + ' ' + p.LastName) Liczba
FROM Person.Person p
JOIN Sales.Customer c ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
) P
ORDER BY 2;


--2.6
SELECT Produkt, Tile, RANK() OVER(PARTITION BY Tile ORDER BY Srednia DESC)
FROM (
SELECT Produkt, NTILE(3) OVER(ORDER BY Srednia DESC) AS Tile, Srednia
FROM(
SELECT DISTINCT p.Name Produkt, AVG(sod.OrderQty) OVER (PARTITION BY p.Name) AS Srednia
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON sod.ProductID = p.ProductID
) A)b;


