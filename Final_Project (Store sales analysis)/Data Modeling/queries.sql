USE FinalProject_DB;
GO

-- Query 1: Total sales per year and store type
SELECT d.[Year], t.StoreType, SUM(CAST(f.Sales AS BIGINT)) AS TotalSales
FROM FactSales f
JOIN DimStore s ON f.Store = s.Store
JOIN DimStoreType t ON s.StoreTypeKey = t.StoreTypeKey
JOIN DimDate d ON f.[Date] = d.[Date]
GROUP BY d.[Year], t.StoreType
ORDER BY d.[Year], t.StoreType;

-- Query 2: Average sales on open days, promo vs no promo
SELECT fl.Promo, AVG(CAST(f.Sales AS FLOAT)) AS AvgSales
FROM FactSales f
JOIN DimFlags fl ON f.FlagKey = fl.FlagKey
WHERE fl.[Open] = 1
GROUP BY fl.Promo;

-- Query 3: Top 10 stores by total sales
SELECT TOP 10 f.Store, SUM(CAST(f.Sales AS BIGINT)) AS TotalSales
FROM FactSales f
GROUP BY f.Store
ORDER BY TotalSales DESC;

-- Query 4: Total sales and customers per assortment
SELECT a.Assortment,
       SUM(CAST(f.Sales AS BIGINT)) AS TotalSales,
       SUM(CAST(f.Customers AS BIGINT)) AS TotalCustomers
FROM FactSales f
JOIN DimStore s ON f.Store = s.Store
JOIN DimAssortment a ON s.AssortmentKey = a.AssortmentKey
GROUP BY a.Assortment
ORDER BY TotalSales DESC;

-- Query 5: Average sales per day of week (open days only)
SELECT d.DayOfWeek, AVG(CAST(f.Sales AS FLOAT)) AS AvgSales
FROM FactSales f
JOIN DimDate d ON f.[Date] = d.[Date]
JOIN DimFlags fl ON f.FlagKey = fl.FlagKey
WHERE fl.[Open] = 1
GROUP BY d.DayOfWeek
ORDER BY d.DayOfWeek;

-- Query 6: Average sales per competition distance category (open days only)
SELECT c.CompetitionDistanceCategory, AVG(CAST(f.Sales AS FLOAT)) AS AvgSales
FROM FactSales f
JOIN DimStore s ON f.Store = s.Store
JOIN DimCompetitionDistance c ON s.CompetitionDistanceCategoryKey = c.CompetitionDistanceCategoryKey
JOIN DimFlags fl ON f.FlagKey = fl.FlagKey
WHERE fl.[Open] = 1
GROUP BY c.CompetitionDistanceCategory;
