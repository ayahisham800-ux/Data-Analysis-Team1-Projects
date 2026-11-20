-- Star Schema build script for FinalProject_DB
-- Prerequisite: Store_Raw and Train_Raw were already imported with Import Flat File.
-- Run the sections in order. Each table can only be created once.

USE FinalProject_DB;
GO

-- 1) DimStore
CREATE TABLE DimStore (
    Store INT PRIMARY KEY,
    StoreType VARCHAR(1),
    Assortment VARCHAR(1),
    CompetitionDistance FLOAT NULL,
    CompetitionOpenSinceMonth INT NULL,
    CompetitionOpenSinceYear INT NULL,
    Promo2 INT,
    Promo2SinceWeek INT NULL,
    Promo2SinceYear INT NULL,
    PromoInterval VARCHAR(20) NULL,
    CompetitionDistanceMissing INT,
    CompetitionOpenDateMissing INT,
    Promo2InfoMissing INT,
    CompetitionDistanceCategory VARCHAR(20) NULL
);

INSERT INTO DimStore
SELECT Store, StoreType, Assortment, CompetitionDistance,
       CompetitionOpenSinceMonth, CompetitionOpenSinceYear, Promo2,
       Promo2SinceWeek, Promo2SinceYear, PromoInterval,
       CompetitionDistanceMissing, CompetitionOpenDateMissing,
       Promo2InfoMissing, CompetitionDistanceCategory
FROM Store_Raw;
GO

-- 2) DimDate
CREATE TABLE DimDate (
    [Date] DATE PRIMARY KEY,
    [Year] INT,
    [Month] INT,
    [Day] INT,
    DayOfWeek INT
);

INSERT INTO DimDate
SELECT DISTINCT CAST([Date] AS DATE), [Year], [Month], [Day], DayOfWeek
FROM Train_Raw;
GO

-- 3) FactSales
CREATE TABLE FactSales (
    Store INT NOT NULL,
    [Date] DATE NOT NULL,
    Sales INT,
    Customers INT,
    [Open] INT,
    Promo INT,
    StateHoliday VARCHAR(1),
    SchoolHoliday INT,
    PRIMARY KEY (Store, [Date]),
    FOREIGN KEY (Store) REFERENCES DimStore(Store),
    FOREIGN KEY ([Date]) REFERENCES DimDate([Date])
);

INSERT INTO FactSales
SELECT Store, CAST([Date] AS DATE), Sales, Customers, [Open],
       Promo, StateHoliday, SchoolHoliday
FROM Train_Raw;
GO

-- 4) DimFlags
CREATE TABLE DimFlags (
    FlagKey INT IDENTITY(1,1) PRIMARY KEY,
    [Open] INT,
    Promo INT,
    StateHoliday VARCHAR(1),
    SchoolHoliday INT
);

INSERT INTO DimFlags ([Open], Promo, StateHoliday, SchoolHoliday)
SELECT DISTINCT [Open], Promo, StateHoliday, SchoolHoliday
FROM FactSales;

ALTER TABLE FactSales ADD FlagKey INT NULL;
GO

UPDATE f
SET f.FlagKey = d.FlagKey
FROM FactSales f
JOIN DimFlags d
  ON f.[Open] = d.[Open]
 AND f.Promo = d.Promo
 AND f.StateHoliday = d.StateHoliday
 AND f.SchoolHoliday = d.SchoolHoliday;

ALTER TABLE FactSales
ADD CONSTRAINT FK_FactSales_DimFlags
FOREIGN KEY (FlagKey) REFERENCES DimFlags(FlagKey);
GO

-- 5) Small dimensions split from DimStore
CREATE TABLE DimStoreType (
    StoreTypeKey INT IDENTITY(1,1) PRIMARY KEY,
    StoreType VARCHAR(1)
);
CREATE TABLE DimAssortment (
    AssortmentKey INT IDENTITY(1,1) PRIMARY KEY,
    Assortment VARCHAR(1)
);
CREATE TABLE DimPromoInterval (
    PromoIntervalKey INT IDENTITY(1,1) PRIMARY KEY,
    PromoInterval VARCHAR(20)
);
CREATE TABLE DimCompetitionDistance (
    CompetitionDistanceCategoryKey INT IDENTITY(1,1) PRIMARY KEY,
    CompetitionDistanceCategory VARCHAR(20)
);
GO

INSERT INTO DimStoreType (StoreType)
SELECT DISTINCT StoreType FROM DimStore WHERE StoreType IS NOT NULL;
INSERT INTO DimAssortment (Assortment)
SELECT DISTINCT Assortment FROM DimStore WHERE Assortment IS NOT NULL;
INSERT INTO DimPromoInterval (PromoInterval)
SELECT DISTINCT PromoInterval FROM DimStore WHERE PromoInterval IS NOT NULL;
INSERT INTO DimCompetitionDistance (CompetitionDistanceCategory)
SELECT DISTINCT CompetitionDistanceCategory FROM DimStore WHERE CompetitionDistanceCategory IS NOT NULL;
GO

ALTER TABLE DimStore ADD StoreTypeKey INT NULL,
                         AssortmentKey INT NULL,
                         PromoIntervalKey INT NULL,
                         CompetitionDistanceCategoryKey INT NULL;
GO

UPDATE s SET s.StoreTypeKey = d.StoreTypeKey
FROM DimStore s JOIN DimStoreType d ON s.StoreType = d.StoreType;
UPDATE s SET s.AssortmentKey = d.AssortmentKey
FROM DimStore s JOIN DimAssortment d ON s.Assortment = d.Assortment;
UPDATE s SET s.PromoIntervalKey = d.PromoIntervalKey
FROM DimStore s JOIN DimPromoInterval d ON s.PromoInterval = d.PromoInterval;
UPDATE s SET s.CompetitionDistanceCategoryKey = d.CompetitionDistanceCategoryKey
FROM DimStore s JOIN DimCompetitionDistance d
  ON s.CompetitionDistanceCategory = d.CompetitionDistanceCategory;
GO

ALTER TABLE DimStore ADD
    CONSTRAINT FK_DimStore_StoreType FOREIGN KEY (StoreTypeKey) REFERENCES DimStoreType(StoreTypeKey),
    CONSTRAINT FK_DimStore_Assortment FOREIGN KEY (AssortmentKey) REFERENCES DimAssortment(AssortmentKey),
    CONSTRAINT FK_DimStore_PromoInterval FOREIGN KEY (PromoIntervalKey) REFERENCES DimPromoInterval(PromoIntervalKey),
    CONSTRAINT FK_DimStore_CompDist FOREIGN KEY (CompetitionDistanceCategoryKey) REFERENCES DimCompetitionDistance(CompetitionDistanceCategoryKey);
GO

-- 6) Row-count checks (expected: 1115, 942, 1017209 / 4, 3, 3, 3)
SELECT COUNT(*) AS DimStoreRows FROM DimStore;
SELECT COUNT(*) AS DimDateRows FROM DimDate;
SELECT COUNT(*) AS FactSalesRows FROM FactSales;
SELECT COUNT(*) AS EmptyFlagKey FROM FactSales WHERE FlagKey IS NULL;
