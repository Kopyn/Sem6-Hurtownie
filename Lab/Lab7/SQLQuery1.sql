--3.1

SELECT Kopinski.DIM_CUSTOMER.CountryRegionCode, COUNT(DISTINCT Kopinski.DIM_CUSTOMER.CustomerID) AS "Liczba roznych klientow"
FROM Kopinski.DIM_CUSTOMER
GROUP BY Kopinski.DIM_CUSTOMER.CountryRegionCode;

--3.2

SELECT Rok, [AU], [CA], [DE], [FR], [GB], [US]
FROM (
SELECT DISTINCT dt.Year AS Rok, dc.CountryRegionCode AS Region, dc.CustomerID AS "Liczba klientow" 
FROM Kopinski.DIM_CUSTOMER dc
JOIN Kopinski.FACT_SALES fs ON fs.CustomerID = dc.CustomerID
JOIN Kopinski.DIM_TIME dt ON dt.PK_TIME = fs.OrderDate
WHERE dt.Year = 2012 OR dt.Year = 2013
) AS t
PIVOT(
	COUNT("Liczba klientow")
	FOR Region IN ([AU], [CA], [DE], [FR], [GB], [US])
) AS p
ORDER BY Rok;

--3.3

--2012
SELECT dc.CountryRegionCode AS Region, SUM(fs.OrderQty) [2012 Order Qty], COUNT(DISTINCT fs.CustomerID) [2012 Customer distinct count]
FROM Kopinski.DIM_CUSTOMER dc
JOIN Kopinski.FACT_SALES fs ON fs.CustomerID = dc.CustomerID
JOIN Kopinski.DIM_TIME dt ON dt.PK_TIME = fs.OrderDate
WHERE dt.Year = 2012
GROUP BY dc.CountryRegionCode
ORDER BY Region


--2013
SELECT dc.CountryRegionCode AS Region, SUM(fs.OrderQty) [2013 Order Qty], COUNT(DISTINCT fs.CustomerID) [2013 Customer distinct count]
FROM Kopinski.DIM_CUSTOMER dc
JOIN Kopinski.FACT_SALES fs ON fs.CustomerID = dc.CustomerID
JOIN Kopinski.DIM_TIME dt ON dt.PK_TIME = fs.OrderDate
WHERE dt.Year = 2013
GROUP BY dc.CountryRegionCode
ORDER BY Region

SELECT Region, [2012 Order Qty], [2012 Customer distinct count],  [2013 Order Qty], [2013 Customer distinct count]
FROM (
	SELECT dc.CountryRegionCode AS Region, SUM(fs.OrderQty) [2012 Order Qty], COUNT(DISTINCT fs.CustomerID) [2012 Customer distinct count]
	FROM Kopinski.DIM_CUSTOMER dc
	JOIN Kopinski.FACT_SALES fs ON fs.CustomerID = dc.CustomerID
	JOIN Kopinski.DIM_TIME dt ON dt.PK_TIME = fs.OrderDate
	WHERE dt.Year = 2012
	GROUP BY dc.CountryRegionCode
) AS DD
JOIN (
	SELECT dc.CountryRegionCode AS Region2013, SUM(fs.OrderQty) [2013 Order Qty], COUNT(DISTINCT fs.CustomerID) [2013 Customer distinct count]
	FROM Kopinski.DIM_CUSTOMER dc
	JOIN Kopinski.FACT_SALES fs ON fs.CustomerID = dc.CustomerID
	JOIN Kopinski.DIM_TIME dt ON dt.PK_TIME = fs.OrderDate
	WHERE dt.Year = 2013
	GROUP BY dc.CountryRegionCode
) DT ON DD.Region = DT.Region2013
ORDER BY Region;

--3.4

SELECT Kategoria, Podkategoria, [AU], [CA], [DE], [FR], [GB], [US]
FROM (
SELECT dp.CategoryName AS Kategoria, dp.SubCategoryName AS Podkategoria, dc.CountryRegionCode AS Region, fs.OrderQty AS "Liczba zamowien"
FROM Kopinski.DIM_CUSTOMER dc
JOIN Kopinski.FACT_SALES fs ON fs.CustomerID = dc.CustomerID
JOIN Kopinski.DIM_PRODUCT dp ON dp.ProductID = fs.ProductID
) AS t
PIVOT(
	SUM("Liczba zamowien")
	FOR Region IN ([AU], [CA], [DE], [FR], [GB], [US])
) AS p
ORDER BY Kategoria, Podkategoria;

--3.5
SELECT Podkategoria FROM (
SELECT DISTINCT dp.SubCategoryName AS Podkategoria, SUM(fs.OrderQty) SUMA
FROM Kopinski.DIM_PRODUCT dp
JOIN Kopinski.FACT_SALES fs ON fs.ProductID = dp.ProductID
GROUP BY dp.SubCategoryName
HAVING COUNT(DISTINCT dp.ProductID) > 10
) AS P
ORDER BY SUMA DESC
;

--3.6


