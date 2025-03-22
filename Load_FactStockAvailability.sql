CREATE OR ALTER PROCEDURE Load_FactStockAvailability
AS
BEGIN
    -- Insert data into Fact.StockAvailability using Dim.Product for single StockGroupID per ProductID
    INSERT INTO Fact.StockAvailability (ProductID, StockGroupID, QuantityOnHand, BinLocation)
    SELECT 
        si.StockItemID AS ProductID,
        dp.StockGroupID,  -- Use StockGroupID from Dim.Product to ensure each ProductID gets a single StockGroupID
        sh.QuantityOnHand,
        sh.BinLocation
    FROM staging.StockItems si
    LEFT JOIN staging.StockItemHoldings sh
        ON si.StockItemID = sh.StockItemID
    JOIN Dim.Product dp
        ON si.StockItemID = dp.ProductID;  -- Join with Dim.Product to get the correct StockGroupID

END;





