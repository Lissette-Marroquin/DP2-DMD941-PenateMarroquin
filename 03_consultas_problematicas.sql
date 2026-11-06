/* =========================================================
   Script 03: Consultas SQL para las problemáticas
   ========================================================= */
USE AdventureWorksDW2022;
GO

-- Problemática 1: ¿Cómo evolucionaron las ventas por año?
SELECT d.CalendarYear                       AS Anio,
       SUM(f.SalesAmount)                   AS Ventas,
       COUNT(DISTINCT f.SalesOrderNumber)   AS Ordenes
FROM dbo.FactInternetSales f
JOIN dbo.DimDate d ON d.DateKey = f.OrderDateKey
GROUP BY d.CalendarYear
ORDER BY d.CalendarYear;
GO

-- Problemática 2: ¿Qué categoría vende más y cuál es su margen?
SELECT pc.EnglishProductCategoryName                          AS Categoria,
       SUM(f.SalesAmount)                                     AS Ventas,
       SUM(f.SalesAmount - f.TotalProductCost)                AS Ganancia,
       CAST(100.0 * SUM(f.SalesAmount - f.TotalProductCost)
            / SUM(f.SalesAmount) AS DECIMAL(5,1))             AS MargenPorc
FROM dbo.FactInternetSales f
JOIN dbo.DimProduct p             ON p.ProductKey = f.ProductKey
JOIN dbo.DimProductSubcategory ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
JOIN dbo.DimProductCategory pc    ON pc.ProductCategoryKey = ps.ProductCategoryKey
GROUP BY pc.EnglishProductCategoryName
ORDER BY Ventas DESC;
GO

-- Problemática 3: ¿Cuáles son los 5 productos más vendidos?
SELECT TOP 5 p.EnglishProductName      AS Producto,
       SUM(f.SalesAmount)              AS Ventas,
       SUM(f.OrderQuantity)            AS Unidades
FROM dbo.FactInternetSales f
JOIN dbo.DimProduct p ON p.ProductKey = f.ProductKey
GROUP BY p.EnglishProductName
ORDER BY Ventas DESC;
GO

-- Problemática 4: ¿En qué países se vende más?
SELECT t.SalesTerritoryCountry                                AS Pais,
       SUM(f.SalesAmount)                                     AS Ventas,
       CAST(100.0 * SUM(f.SalesAmount)
            / (SELECT SUM(SalesAmount) FROM dbo.FactInternetSales)
            AS DECIMAL(5,1))                                  AS PorcDelTotal
FROM dbo.FactInternetSales f
JOIN dbo.DimSalesTerritory t ON t.SalesTerritoryKey = f.SalesTerritoryKey
GROUP BY t.SalesTerritoryCountry
ORDER BY Ventas DESC;
GO

-- Problemática 5: ¿Quiénes son los 5 clientes que más compran?
SELECT TOP 5 c.FirstName + ' ' + c.LastName AS Cliente,
       SUM(f.SalesAmount)                   AS Ventas
FROM dbo.FactInternetSales f
JOIN dbo.DimCustomer c ON c.CustomerKey = f.CustomerKey
GROUP BY c.CustomerKey, c.FirstName, c.LastName
ORDER BY Ventas DESC;
GO
