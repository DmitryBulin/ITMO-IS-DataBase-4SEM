1.
SELECT SalesOrderID, ProductID, CAST (OrderQty AS float) * UnitPrice / SUM(OrderQty * UnitPrice) 
OVER(PARTITION BY SalesOrderID)
FROM Sales.SalesOrderDetail
2.
SELECT ProductID, ListPrice, ListPrice - MIN(ListPrice)
OVER(PARTITION BY ProductSubcategoryID)
FROM Production.Product
ORDER BY ListPrice DESC
3.
SELECT CustomerID, SalesOrderID, ROW_NUMBER()
OVER(PARTITION BY CustomerID ORDER BY OrderDate)
FROM Sales.SalesOrderHeader
4.1.
WITH AvgPricePerSubcategory (ProductSubcategoryID, AvgPrice) AS
(
    SELECT ProductSubcategoryID, AVG(ListPrice)
    FROM Production.Product
    GROUP BY ProductSubcategoryID
)
SELECT p.ProductID
FROM Production.Product AS p
JOIN AvgPricePerSubcategory AS apps
ON p.ProductSubcategoryID = apps.ProductSubcategoryID
WHERE p.ListPrice > apps.AvgPrice
4.2.
SELECT DISTINCT p.ProductID
FROM Production.Product AS p
JOIN 
(
    SELECT ProductSubcategoryID, AVG(ListPrice)
    OVER(PARTITION BY ProductSubcategoryID) AS AvgPrice
    FROM Production.Product
) AS apps
ON p.ProductSubcategoryID = apps.ProductSubcategoryID
WHERE p.ListPrice > apps.AvgPrice
5.
WITH ProductsPerSale (ProductID, ProductCount, RowNumber) AS
(
    SELECT 
        sod.ProductID,
        SUM(sod.OrderQty) OVER(
            PARTITION BY sod.ProductID, sod.SalesOrderID
            ORDER BY soh.OrderDate DESC
        ),
        ROW_NUMBER() OVER(
            PARTITION BY sod.ProductID
            ORDER BY soh.OrderDate DESC
        )
    FROM Sales.SalesOrderDetail AS sod
    JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
)
SELECT ProductID, AVG(ProductCount) OVER (PARTITION BY ProductID)
FROM ProductsPerSale
WHERE RowNumber <= 3
ORDER BY ProductID