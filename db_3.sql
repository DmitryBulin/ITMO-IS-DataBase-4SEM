1.
SELECT p.Name AS ProductName, pc.Name AS CategoryName
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory AS pc
ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE p.Color = 'Red' 
AND p.ListPrice >= 100
2.
SELECT pc1.Name
FROM Production.ProductSubcategory AS pc1
JOIN Production.ProductSubcategory AS pc2
ON pc1.Name = pc2.Name 
AND pc1.ProductSubcategoryID != pc2.ProductSubcategoryID
3.
SELECT pc.Name AS CategoryName, Count(p.ProductID) AS ProductCount
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory AS pc
ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
4.
SELECT psc.Name AS SubcategoryName, COUNT(p.ProductID) AS ProductCount
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
GROUP BY psc.ProductSubcategoryID, psc.Name
5.
SELECT TOP 3 psc.Name AS SubcategoryName
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
GROUP BY psc.ProductSubcategoryID, psc.Name
ORDER BY COUNT(p.ProductID) DESC
6.
SELECT psc.Name AS SubcategoryName, MAX(p.ListPrice) AS MaxPrice
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
WHERE p.Color = 'Red'
GROUP BY psc.ProductSubcategoryID, psc.Name
7.
SELECT v.Name AS VendorName, Count(p.ProductID) AS ProductCount
FROM Purchasing.Vendor AS v
JOIN Purchasing.ProductVendor AS pv
ON v.BusinessEntityID = pv.BusinessEntityID
JOIN Production.Product AS p
ON pv.ProductID = p.ProductID
GROUP BY v.Name
8.
SELECT p.Name AS ProductName
FROM Purchasing.ProductVendor AS pv
JOIN Production.Product AS p
ON pv.ProductID = p.ProductID
GROUP BY p.Name
HAVING COUNT(DISTINCT pv.BusinessEntityID) > 1
9.
SELECT TOP 1 p.Name AS ProductName
FROM Production.Product AS p
JOIN Purchasing.ProductVendor AS pv
ON p.ProductID = pv.ProductID
GROUP BY p.Name
ORDER BY COUNT(pv.BusinessEntityID) DESC
10.
SELECT TOP 1 pc.Name AS CategoryName
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory AS pc
ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN Purchasing.ProductVendor AS pv
ON p.ProductID = pv.ProductID
GROUP BY pc.Name
ORDER BY COUNT(p.ProductID) DESC
11.
SELECT pc.Name AS CategoryName, COUNT(DISTINCT psc.ProductSubcategoryID) AS SubcategoryCount, COUNT(p.ProductID) AS ProductCount
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory AS pc
ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
12.
SELECT v.CreditRating AS CreditRating, COUNT(ProductID) AS ProductCount
FROM Purchasing.ProductVendor AS pv
JOIN Purchasing.Vendor AS v
ON pv.BusinessEntityID = v.BusinessEntityID
GROUP BY v.CreditRating