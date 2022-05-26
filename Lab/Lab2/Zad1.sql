--Zad1

WITH Sprzedaz AS
(
	SELECT Sales.SalesPerson.BusinessEntityID, Sales.SalesOrderDetail.ProductID, Production.Product.Name, YEAR(Sales.SalesOrderHeader.OrderDate) AS Rok, SUM(Sales.SalesOrderDetail.OrderQty) AS Liczba
	FROM Sales.SalesPerson
	RIGHT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesPersonID = Sales.SalesPerson.BusinessEntityID
	JOIN Sales.SalesOrderDetail ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
	JOIN Production.Product ON Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
	GROUP BY Sales.SalesPerson.BusinessEntityID, Sales.SalesOrderDetail.ProductID, Production.Product.Name, YEAR(Sales.SalesOrderHeader.OrderDate)
)
SELECT *
FROM Sprzedaz;

--1a
SELECT PracownikID, ProduktID, "Nazwa produktu", [2011], [2012], [2013], [2014]
FROM (
SELECT sp.BusinessEntityID AS PracownikID, sod.ProductID AS ProduktID, Production.Product.Name AS "Nazwa produktu", YEAR(soh.OrderDate) AS Rok, sod.OrderQty AS "Liczba produktów"
FROM Sales.SalesPerson sp
RIGHT JOIN Sales.SalesOrderHeader soh ON soh.SalesPersonID = sp.BusinessEntityID
JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product ON Production.Product.ProductID = sod.ProductID
) AS sumamry
PIVOT(
 SUM("Liczba produktów")
 FOR Rok IN ([2011], [2012], [2013], [2014])
) AS P
ORDER BY 1;

--1b
SELECT pracID, Rok, [712], [870], [711], [715], [708]
FROM(
	SELECT ssp.BusinessEntityID AS pracID, pp.ProductID AS prodID, 
		YEAR(ssoh.OrderDate) AS Rok, ssod.OrderQty AS Liczba
	FROM Sales.SalesPerson ssp
	RIGHT JOIN Sales.SalesOrderHeader ssoh ON ssp.BusinessEntityID = ssoh.SalesPersonID
	JOIN Sales.SalesOrderDetail ssod ON ssod.SalesOrderID = ssoh.SalesOrderID
	JOIN Production.Product pp ON pp.ProductID = ssod.ProductID
	WHERE pp.ProductID IN (SELECT TOP 5 ProductID FROM Sales.SalesOrderDetail GROUP BY ProductID ORDER BY SUM(OrderQty) DESC)
) x
PIVOT(
	SUM(Liczba)
FOR
	prodID in ([712], [870], [711], [715], [708])
) y
ORDER BY 1, 2;



--Zad2

SELECT Rok, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12]
FROM (
SELECT DISTINCT YEAR(s.OrderDate) AS Rok, MONTH(s.OrderDate) AS Miesiac, s.CustomerId AS "Roczni klienci"
FROM Sales.SalesOrderHeader s) AS summary
PIVOT(
COUNT("Roczni klienci") 
FOR Miesiac IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) AS P
ORDER BY 1;



--Zad3

SELECT "Imie i nazwisko", [2011], [2012], [2013], [2014]
FROM (
SELECT p.FirstName + ' ' + p.LastName AS "Imie i nazwisko", YEAR(Sales.SalesOrderHeader.OrderDate) AS Rok, Sales.SalesOrderHeader.SalesOrderID AS "Liczba transakcji"
FROM Person.Person p
JOIN Sales.SalesPerson ON Sales.SalesPerson.BusinessEntityID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesPersonID = Sales.SalesPerson.BusinessEntityID) AS summary
PIVOT(
COUNT("Liczba transakcji")
FOR Rok IN ([2011], [2012], [2013], [2014])) AS P;


--Zad4
SELECT YEAR(Sales.SalesOrderHeader.OrderDate) AS Rok, MONTH(Sales.SalesOrderHeader.OrderDate) AS Miesi¹c, DAY(Sales.SalesOrderHeader.OrderDate) AS Dzieñ, 
SUM(Sales.SalesOrderHeader.TotalDue) AS Suma, COUNT(DISTINCT Sales.SalesOrderDetail.ProductID) AS "Liczba ró¿nych produktów"
FROM Sales.SalesOrderHeader
JOIN Sales.SalesOrderDetail ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
GROUP BY YEAR(Sales.SalesOrderHeader.OrderDate), MONTH(Sales.SalesOrderHeader.OrderDate), DAY(Sales.SalesOrderHeader.OrderDate)
ORDER BY 1, 2, 3;


--Zad5
SET DATEFIRST 1;
SELECT CASE
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 1 THEN 'Styczeñ'
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 2 THEN 'Luty'
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 3 THEN 'Marzec'
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 4 THEN 'Kwiecieñ'
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 5 THEN 'Maj'
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 6 THEN 'Czerwiec'
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 7 THEN 'Lipiec'
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 8 THEN 'Sierpieñ'
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 9 THEN 'Wrzesieñ'
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 10 THEN 'PaŸdziernik'
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 11 THEN 'Listopad'
	WHEN MONTH(Sales.SalesOrderHeader.OrderDate) = 12 THEN 'Grudzieñ'
	ELSE NULL
END Miesi¹c,
CASE
	WHEN DATEPART(dw, Sales.SalesOrderHeader.OrderDate) = 1 THEN 'Poniedzia³ek'
	WHEN DATEPART(dw, Sales.SalesOrderHeader.OrderDate) = 2 THEN 'Wtorek'
	WHEN DATEPART(dw, Sales.SalesOrderHeader.OrderDate) = 3 THEN 'Œroda'
	WHEN DATEPART(dw, Sales.SalesOrderHeader.OrderDate) = 4 THEN 'Czwartek'
	WHEN DATEPART(dw, Sales.SalesOrderHeader.OrderDate) = 5 THEN 'Pi¹tek'
	WHEN DATEPART(dw, Sales.SalesOrderHeader.OrderDate) = 6 THEN 'Sobota'
	WHEN DATEPART(dw, Sales.SalesOrderHeader.OrderDate) = 7 THEN 'Niedziela'
	ELSE NULL
END Dzieñ,
SUM(Sales.SalesOrderHeader.TotalDue) AS Suma, COUNT(DISTINCT Sales.SalesOrderDetail.ProductID) AS "Liczba ró¿nych produktów"
FROM Sales.SalesOrderHeader
JOIN Sales.SalesOrderDetail ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
GROUP BY MONTH(Sales.SalesOrderHeader.OrderDate), DATEPART(dw, Sales.SalesOrderHeader.OrderDate) ORDER BY MONTH(Sales.SalesOrderHeader.OrderDate),
DATEPART(dw, Sales.SalesOrderHeader.OrderDate);


--Zad6


SELECT * FROM(
	SELECT pp.FirstName Imie, pp.LastName Nazwisko, COUNT(ssoh.SalesOrderID) liczba, SUM(ssoh.TotalDue) kwota,
	CASE
		WHEN (
			SELECT COUNT(DISTINCT Rok)
			FROM(
				SELECT CustomerId, YEAR(OrderDate) Rok, COUNT(SalesOrderID) Zamowienia FROM Sales.SalesOrderHeader
				WHERE TotalDue > 1.5 * (SELECT AVG(TotalDue) FROM Sales.SalesOrderHeader)
				GROUP BY CustomerID, YEAR(OrderDate)
				HAVING COUNT(SalesOrderID) >= 2
			) AS temp
			WHERE temp.CustomerId=sc.CustomerID)>=4 THEN 'Platynowa'
		WHEN 
			(SELECT COUNT(SalesOrderID) FROM Sales.SalesOrderHeader
			WHERE TotalDue > 1.5 * (SELECT AVG(TotalDue) FROM Sales.SalesOrderHeader) AND CustomerID=sc.CustomerID) >= 2 THEN 'Zlota'
		WHEN COUNT(ssoh.SalesOrderID) >= 5 THEN 'Srebrna'
	END karta
	FROM Person.Person pp 
	JOIN Sales.Customer sc ON pp.BusinessEntityID = sc.PersonID
	JOIN Sales.SalesOrderHeader ssoh ON sc.CustomerID = ssoh.CustomerID
	GROUP BY pp.FirstName, pp.LastName, sc.CustomerID
) AS summary
WHERE karta IS NOT NULL
ORDER BY 2,1;

--Zad na zajeciach
SELECT DISTINCT TOP 5 Size FROM Production.Product;

SELECT Dzieñ, [S], [M], [L]
FROM (
	SELECT DISTINCT DATEPART(dw, soh.OrderDate) AS Dzieñ, 
	CASE
		WHEN pro.Size = '38' THEN 'S'
		WHEN pro.Size = '40' THEN 'M'
		WHEN pro.Size = '46' THEN 'L' END Rozmiar, soh.CustomerID AS "Liczba ró¿nych klientów"
	FROM Sales.SalesOrderHeader soh
	JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID = soh.SalesOrderID
	JOIN Production.Product pro ON pro.ProductID = sod.ProductID
) AS summary
PIVOT(
COUNT("Liczba ró¿nych klientów")
FOR Rozmiar IN ([S], [M], [L])) AS P
ORDER BY 1;
