/* =========================================================
   Script 02: Carga y exploración de datos
   ========================================================= */
USE AdventureWorksDW2022;
GO

-- Cantidad de registros de las tablas que usa el cubo
SELECT 'FactInternetSales'     AS Tabla, COUNT(*) AS Registros FROM dbo.FactInternetSales
UNION ALL SELECT 'DimDate',               COUNT(*) FROM dbo.DimDate
UNION ALL SELECT 'DimProduct',            COUNT(*) FROM dbo.DimProduct
UNION ALL SELECT 'DimProductSubcategory', COUNT(*) FROM dbo.DimProductSubcategory
UNION ALL SELECT 'DimProductCategory',    COUNT(*) FROM dbo.DimProductCategory
UNION ALL SELECT 'DimCustomer',           COUNT(*) FROM dbo.DimCustomer
UNION ALL SELECT 'DimSalesTerritory',     COUNT(*) FROM dbo.DimSalesTerritory;
GO

-- Resumen general de las ventas por internet
SELECT
    COUNT(*)                                        AS LineasDeVenta,
    COUNT(DISTINCT SalesOrderNumber)                AS Ordenes,
    COUNT(DISTINCT CustomerKey)                     AS Clientes,
    SUM(SalesAmount)                                AS VentasTotales,
    SUM(SalesAmount - TotalProductCost)             AS GananciaTotal,
    MIN(OrderDate)                                  AS PrimeraVenta,
    MAX(OrderDate)                                  AS UltimaVenta
FROM dbo.FactInternetSales;
GO

-- Revisión de calidad: valores nulos en llaves y medidas
SELECT
    SUM(CASE WHEN ProductKey     IS NULL THEN 1 ELSE 0 END) AS ProductKeyNulos,
    SUM(CASE WHEN CustomerKey    IS NULL THEN 1 ELSE 0 END) AS CustomerKeyNulos,
    SUM(CASE WHEN OrderDateKey   IS NULL THEN 1 ELSE 0 END) AS OrderDateKeyNulos,
    SUM(CASE WHEN SalesAmount    IS NULL THEN 1 ELSE 0 END) AS SalesAmountNulos
FROM dbo.FactInternetSales;
GO
