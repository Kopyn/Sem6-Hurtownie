USE AdventureWorks2019

--1.1
SELECT p.FirstName + ' ' + p.LastName AS Klient, YEAR(soh.OrderDate) AS Rok,
SUM(soh.TotalDue) AS Kwota
FROM Person.Person p
JOIN Sales.Customer c ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
GROUP BY ROLLUP(p.FirstName + ' ' + p.LastName, YEAR(soh.OrderDate))
ORDER BY 1;

SELECT p.FirstName + ' ' + p.LastName AS Klient, YEAR(soh.OrderDate) AS Rok,
SUM(soh.TotalDue) AS Kwota
FROM Person.Person p
JOIN Sales.Customer c ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
GROUP BY CUBE(p.FirstName + ' ' + p.LastName, YEAR(soh.OrderDate))
ORDER BY 1, 2, 3;


SELECT p.FirstName + ' ' + p.LastName AS Klient, YEAR(soh.OrderDate) AS Rok,
SUM(soh.TotalDue) AS Kwota
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
SELECT DISTINCT pc.Name AS Nazwa, YEAR(soh.OrderDate) AS Rok, 100 * SUM(sod.LineTotal)
OVER(PARTITION BY YEAR(soh.OrderDate))/SUM(sod.LineTotal) OVER() AS Procent
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory ps ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Sales.SalesOrderDetail sod ON sod.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
WHERE pc.Name='Bikes'
ORDER BY 2;
SELECT DISTINCT pc.Name AS Nazwa, YEAR(soh.OrderDate) AS Rok, 100 * SUM(sod.LineTotal)
OVER(PARTITION BY YEAR(soh.OrderDate))/SUM(sod.LineTotal) OVER() AS Procent
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory ps ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Sales.SalesOrderDetail sod ON sod.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
WHERE pc.Name='Accessories'
ORDER BY 2;
SELECT DISTINCT pc.Name AS Nazwa, YEAR(soh.OrderDate) AS Rok, 100* SUM(sod.LineTotal)
OVER(PARTITION BY YEAR(soh.OrderDate))/SUM(sod.LineTotal) OVER() AS Procent
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory ps ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Sales.SalesOrderDetail sod ON sod.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
WHERE pc.Name='Clothing'
ORDER BY 2;
SELECT DISTINCT pc.Name AS Nazwa, YEAR(soh.OrderDate) AS Rok, 100 * SUM(sod.LineTotal)
OVER(PARTITION BY YEAR(soh.OrderDate))/SUM(sod.LineTotal) OVER() AS Procent
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory ps ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Sales.SalesOrderDetail sod ON sod.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
WHERE pc.Name

--2.1
SELECT DISTINCT p.FirstName + ' ' + p.LastName AS Klient, YEAR(soh.OrderDate) AS Rok,
COUNT(soh.SalesOrderID) OVER(PARTITION BY c.CustomerID ORDER BY YEAR(soh.OrderDate))
AS Liczba
FROM Person.Person p
JOIN Sales.Customer c ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
WHERE c.CustomerID IN (
SELECT CustomerID FROM(
SELECT DISTINCT TOP 10 x.CustomerID, COUNT(x.CustomerID) OVER(PARTITION BY
x.CustomerID) y
FROM Sales.SalesOrderHeader x
ORDER BY 2 DESC) P)
ORDER BY 1, 2;

--2.2
SELECT "Imiê i nazwisko", Rok, Miesi¹c, "W miesi¹cu", "W roku", "W roku narastaj¹co",
SUM("W miesi¹cu") OVER (PARTITION BY "Imiê i nazwisko", Rok ORDER BY Miesi¹c ROWS
BETWEEN 1 PRECEDING AND CURRENT ROW)
AS "Obecny i poprzedni miesi¹c"
FROM(
SELECT DISTINCT p.FirstName + ' ' + p.LastName AS "Imiê i nazwisko",
YEAR(soh.OrderDate) AS Rok, MONTH(soh.OrderDate) AS Miesi¹c,
COUNT(soh.SalesOrderID) OVER (PARTITION BY p.FirstName + ' ' + p.LastName,
YEAR(soh.OrderDate), MONTH(soh.OrderDate)) AS "W miesi¹cu",
COUNT(soh.SalesOrderID) OVER (PARTITION BY p.FirstName + ' ' + p.LastName,
YEAR(soh.OrderDate)) AS "W roku",
COUNT(soh.SalesOrderID) OVER (PARTITION BY p.FirstName + ' ' + p.LastName,
YEAR(soh.OrderDate) ORDER BY MONTH(soh.OrderDate)) AS "W roku narastaj¹co"
FROM Person.Person p
JOIN HumanResources.Employee e ON e.BusinessEntityID = p.BusinessEntityID
JOIN Sales.SalesPerson sp ON sp.BusinessEntityID = e.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.SalesPersonID = sp.BusinessEntityID
) P;

--2.4
SELECT DISTINCT Kategoria, SUM("Cena max") OVER (PARTITION BY Kategoria) Suma
FROM(
SELECT DISTINCT cat.Name AS Kategoria, subcat.Name AS Podkategoria,
MAX(p.ListPrice) OVER (PARTITION BY cat.Name, subcat.Name) AS "Cena max"
FROM Production.ProductCategory cat
JOIN Production.ProductSubcategory subcat ON subcat.ProductCategoryID =
cat.ProductCategoryID
JOIN Production.Product p ON p.ProductSubcategoryID = subcat.ProductSubcategoryID
) P;

--2.5
SELECT Klient, DENSE_RANK() OVER(ORDER BY Liczba DESC) AS Pozycja
FROM (
SELECT DISTINCT p.FirstName + ' ' + p.LastName AS Klient, SUM(sod.OrderQty) OVER
(PARTITION BY p.FirstName + ' ' + p.LastName) Liczba
FROM Person.Person p
JOIN Sales.Customer c ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID = soh.SalesOrderID
) P
ORDER BY 2;

--2.6
SELECT Produkt, Tile AS Grupa, RANK() OVER(PARTITION BY Tile ORDER BY Srednia DESC)
Pozycja, "Œreania liczba sztuk"
FROM (
SELECT Produkt, NTILE(3) OVER(ORDER BY Srednia DESC) AS Tile, Srednia, SUM(Srednia)
OVER (PARTITION BY Produkt) "Œreania liczba sztuk"
FROM(
SELECT DISTINCT p.Name Produkt, CAST(AVG(CAST(sod.OrderQty AS FLOAT)) OVER (PARTITION BY p.Name) AS float) AS
Srednia
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON sod.ProductID = p.ProductID
) A) b;


--zad na zajêciach
SELECT DISTINCT e.Gender, DATEPART(q, soh.OrderDate) Kwartal, MONTH(soh.OrderDate) Miesi¹c, 
SUM(sod.OrderQty) OVER (PARTITION BY e.Gender, DATEPART(q, soh.OrderDate)ORDER BY MONTH(soh.OrderDate)) AS Suma,
SUM(sod.OrderQty) OVER (PARTITION BY MONTH(soh.OrderDate), e.Gender) AS "W miesi¹cu"
FROM HumanResources.Employee e
JOIN Sales.SalesPerson sp ON sp.BusinessEntityID = e.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON soh.SalesPersonID = sp.BusinessEntityID
JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID = soh.SalesOrderID
ORDER BY 2, 3, 4;
