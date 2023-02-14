1.
SELECT p.Name 
FROM Production.Product AS p
WHERE p.ProductID = (
    SELECT TOP 1 ProductID
    FROM Sales.SalesOrderDetail
    GROUP BY ProductID
    ORDER BY COUNT(ProductID) DESC
)
2.
SELECT soh.CustomerID
FROM Sales.SalesOrderHeader AS soh
WHERE soh.SalesOrderID = (
    SELECT TOP 1 sod.SalesOrderID
    FROM Sales.SalesOrderDetail AS sod
    GROUP BY sod.SalesOrderID
    ORDER BY SUM(sod.UnitPrice * sod.OrderQty) DESC
)
3.
SELECT p.ProductID
FROM Production.Product AS p
WHERE p.ProductID IN (
    SELECT sod.ProductID
    FROM Sales.SalesOrderDetail AS sod
    JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
    GROUP BY sod.ProductID
    HAVING COUNT(DISTINCT soh.CustomerID) = 1
)
4.
SELECT p1.ProductID
FROM Production.Product AS p1
WHERE p1.ListPrice > (
    SELECT AVG(p2.ListPrice)
    FROM Production.Product AS p2
    WHERE p1.ProductSubcategoryID = p2.ProductSubcategoryID
)
5.
SELECT p.ProductId
FROM Production.Product AS p
WHERE p.ProductID IN (
    SELECT sod.ProductID
    FROM Sales.SalesOrderHeader AS soh
    JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
    WHERE soh.CustomerID IN (
        SELECT soh2.CustomerID
        FROM Sales.SalesOrderHeader AS soh2
        JOIN Sales.SalesOrderDetail AS sod2
        ON soh2.SalesOrderID = sod2.SalesOrderID
        JOIN Production.Product AS p2
        ON sod2.ProductID = p2.ProductID
        GROUP BY soh2.CustomerID
        HAVING COUNT(DISTINCT p2.Color) = 1
    )
    GROUP BY sod.ProductID
    HAVING COUNT(DISTINCT soh.CustomerID) > 1
)
6.
SELECT p.ProductId
FROM Production.Product AS p
WHERE p.ProductID IN (
    SELECT sod.ProductID
    FROM Sales.SalesOrderDetail AS sod
    JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
    GROUP BY soh.CustomerID, sod.ProductID
    HAVING COUNT(DISTINCT sod.SalesOrderID) = (
        SELECT COUNT(DISTINCT soh2.SalesOrderID)
        FROM Sales.SalesOrderHeader AS soh2
        WHERE soh.CustomerID = soh2.CustomerID
    )
)
7.
SELECT c.CustomerID
FROM Sales.Customer AS c
WHERE c.CustomerID IN (
    SELECT DISTINCT soh.CustomerID
    FROM Sales.SalesOrderDetail AS sod
    JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
    GROUP BY soh.CustomerID, sod.ProductID
    HAVING COUNT(DISTINCT sod.SalesOrderID) = (
        SELECT COUNT(DISTINCT soh2.SalesOrderID)
        FROM Sales.SalesOrderHeader AS soh2
        WHERE soh.CustomerID = soh2.CustomerID
    )
)
8.
SELECT p.ProductID
FROM Production.Product AS p
JOIN Sales.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
JOIN Sales.SalesOrderHeader AS soh
ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY p.ProductID
HAVING COUNT(DISTINCT soh.CustomerID) <= 3
9.
SELECT DISTINCT sod.ProductID
FROM Sales.SalesOrderDetail AS sod
WHERE sod.SalesOrderID IN (
    SELECT soh.SalesOrderID
    FROM Sales.SalesOrderDetail AS sod2
    JOIN Sales.SalesOrderHeader AS soh
    ON sod2.SalesOrderID = soh.SalesOrderID
    JOIN Production.Product AS p
    ON sod2.ProductID = p.ProductID
    GROUP BY soh.SalesOrderID
    HAVING MAX(p.ListPrice) IN (
        SELECT MAX(p2.ListPrice)
        FROM Production.ProductCategory AS pc
        JOIN Production.ProductSubcategory AS psc
        ON pc.ProductCategoryID = psc.ProductCategoryID
        JOIN Production.Product AS p2
        ON psc.ProductSubcategoryID = p2.ProductSubcategoryID
        GROUP BY pc.ProductCategoryID
    )
)
10.
SELECT DISTINCT soh.CustomerID
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod
ON soh.SalesOrderID = sod.SalesOrderID
WHERE sod.SalesOrderID IN (
    SELECT soh2.SalesOrderID
    FROM Sales.SalesOrderHeader AS soh2
    JOIN Sales.SalesOrderDetail AS sod2
    ON soh2.SalesOrderID = sod2.SalesOrderID
    GROUP BY soh2.SalesOrderID
    HAVING COUNT(sod2.ProductID) >= 3
)
AND sod.ProductID IN (
    SELECT sod2.ProductID
    FROM Sales.SalesOrderDetail AS sod2
    WHERE sod.SalesOrderID != sod2.SalesOrderID
    GROUP BY sod2.ProductID
    HAVING COUNT(DISTINCT sod2.SalesOrderID) >= 3
)
GROUP BY soh.CustomerID
HAVING COUNT(DISTINCT sod.SalesOrderID) >= 2
11.
SELECT soh.SalesOrderID
FROM Production.Product AS p
JOIN Sales.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
JOIN Sales.SalesOrderHeader AS soh
ON sod.SalesOrderID = soh.SalesOrderID
WHERE p.ProductID IN (
    SELECT DISTINCT sod2.ProductID
    FROM Sales.SalesOrderDetail AS sod2
    JOIN Sales.SalesOrderHeader AS soh2
    ON sod2.SalesOrderID = soh2.SalesOrderID
    GROUP BY sod2.ProductID, soh2.CustomerID
    HAVING COUNT(DISTINCT soh2.SalesOrderID) >= 2
)
12.
SELECT p.ProductID
FROM Production.Product AS p
WHERE p.ProductID IN (
    SELECT DISTINCT sod.ProductID
    FROM Sales.SalesOrderDetail AS sod
    JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
    GROUP BY sod.ProductID
    HAVING COUNT(DISTINCT soh.CustomerID) >= 3
)
13.
SELECT DISTINCT psc.ProductSubcategoryID
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
WHERE 3 < (
    SELECT COUNT(*)
    FROM (
        SELECT DISTINCT sod.ProductID
        FROM Sales.SalesOrderDetail AS sod
        JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
        JOIN Production.Product AS p2
        ON sod.ProductID = p2.ProductID
        AND p2.ProductSubcategoryID = psc.ProductSubcategoryID
        GROUP BY sod.ProductID
        HAVING COUNT(DISTINCT soh.SalesOrderID) > 3
    ) AS suitable_count
)
14.
SELECT p.ProductID
FROM Production.Product AS p
WHERE p.ProductID IN (
    SELECT DISTINCT sod.ProductID
    FROM Sales.SalesOrderDetail AS sod
    JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
    GROUP BY sod.ProductID, soh.CustomerID
    HAVING COUNT(DISTINCT soh.SalesOrderID) BETWEEN 2 AND 3
)