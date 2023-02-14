1.
SELECT Color, COUNT(ProductID)
FROM Production.Product
WHERE ListPrice >= 30
GROUP BY Color
2.
SELECT Color, MIN(ListPrice)
FROM Production.Product
WHERE ListPrice > 100
GROUP BY Color
3.
SELECT ProductSubcategoryID, COUNT(ProductID)
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
4.
SELECT ProductID, COUNT(DISTINCT SalesOrderID)
FROM Sales.SalesOrderDetail
GROUP BY ProductID
5.
SELECT ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(DISTINCT SalesOrderID) > 5
6.
SELECT CustomerID
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, OrderDate
HAVING COUNT(DISTINCT SalesOrderID) > 1
7.
SELECT SalesOrderID
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(DISTINCT ProductID) > 3
8.
SELECT ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(DISTINCT SalesOrderID) > 3
9.
SELECT ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(DISTINCT SalesOrderID) IN (3, 5)
10.
SELECT ProductSubcategoryID
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
HAVING COUNT(ProductID) > 10
11.
SELECT ProductID
FROM Sales.SalesOrderDetail
WHERE OrderQty = 1
GROUP BY ProductID
12.
SELECT TOP 1 SalesOrderID
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY COUNT(DISTINCT ProductID) DESC
13.
SELECT TOP 1 SalesOrderID
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY SUM(UnitPrice * OrderQty) DESC
14.
SELECT ProductSubcategoryID, COUNT(ProductID)
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL 
AND Color IS NOT NULL
GROUP BY ProductSubcategoryID
15.
SELECT Color
FROM Production.Product
GROUP BY Color
ORDER BY COUNT(ProductID) DESC
16.
SELECT ProductID
FROM Sales.SalesOrderDetail
WHERE OrderQty > 1
GROUP BY ProductID
HAVING COUNT(DISTINCT SalesOrderID) > 2