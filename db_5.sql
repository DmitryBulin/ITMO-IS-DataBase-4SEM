1.1.
SELECT t1.CustomerID, AVG(t1.ProductCount)
FROM (
    SELECT soh.CustomerID, COUNT(DISTINCT sod.ProductID) AS ProductCount
    FROM Sales.SalesOrderDetail AS sod
    JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
    GROUP BY soh.CustomerID, soh.SalesOrderID
) AS t1
GROUP BY t1.CustomerID
ORDER BY t1.CustomerID
1.2.
WITH PersonProducts(CustomerID, ProductCount) AS
(
    SELECT soh.CustomerID, COUNT(DISTINCT sod.ProductID) AS ProductCount
    FROM Sales.SalesOrderDetail AS sod
    JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
    GROUP BY soh.CustomerID, soh.SalesOrderID
)
SELECT CustomerID, AVG(ProductCount)
FROM PersonProducts
GROUP BY CustomerID
ORDER BY CustomerID
2.
WITH 
SalesPerCustomer (CustomerID, SalesCount) AS
(
SELECT DISTINCT CustomerID, COUNT(SalesOrderID)
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
),
ProductsPerCustomer (CustomerID, ProductID, SalesCount) AS
(
SELECT soh.CustomerID, sod.ProductID, COUNT(DISTINCT soh.SalesOrderID)
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh
ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY soh.CustomerID, sod.ProductID
)
SELECT t1.CustomerID, t2.ProductID, t2.SalesCount / t1.SalesCount
FROM ProductsPerCustomer AS t2
JOIN SalesPerCustomer AS t1
ON t2.CustomerID = t1.customerID
GROUP BY t2.ProductID, t1.customerID
3.
WITH SalesPerProduct (ProductID, SalesCount) AS
(
SELECT ProductID, COUNT(DISTINCT SalesOrderID)
FROM Sales.SalesOrderDetail
GROUP BY ProductID
),
CustomersPerProduct (ProductID, CustomersCount) AS
(
SELECT sod.ProductID, COUNT(DISTINCT soh.CustomerID)
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh
ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY sod.ProductID
)
SELECT t1.ProductID, t1.SalesCount, t2.CustomersCount
FROM SalesPerProduct AS t1
JOIN CustomersPerProduct AS t2
ON t1.ProductID = t2.ProductID
4.
SELECT CustomerID, Max(SubTotal) AS MaxCost, MIN(SubTotal) AS MinCost
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
5.
WITH ProductsPerSale (SalesOrderID, CustomerID, ProductsCount) AS
(
SELECT soh.SalesOrderID, soh.CustomerID, COUNT(DISTINCT sod.ProductID)
FROM Sales.SalesOrderDetails AS sod
JOIN Sales.SalesOrderHeader AS soh
ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY soh.SalesOrderID
)
SELECT t1.CustomerID
FROM ProductsPerSale AS t1
WHERE 1 = MAX(
SELECT COUNT(DISTINCT SalesOrderID)
FROM ProductsPerSale
GROUP BY ProductsCount
WHERE t1.CustomerID = CustomerID
)
6.
WITH ProductsPerCustomer (CustomerID, ProductID, SalesCount) AS
(
SELECT soh.CustomerID, sod.ProductID, COUNT(DISTINCT soh.SalesOrderID)
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh
ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY soh.CustomerID, sod.ProductID
)
SELECT t1.CustomerID
FROM ProductsPerCustomer AS t1
GROUP BY CustomerID
HAVING MIN(SalesCount) = 2