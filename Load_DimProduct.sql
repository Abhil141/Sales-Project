CREATE OR ALTER PROCEDURE Load_DimProduct
AS
BEGIN
    -- Insert distinct products into Dim.Product, including ProductID from StockItemID
    INSERT INTO Dim.Product (ProductID, ProductName, StockGroupID)
    SELECT DISTINCT
        si.StockItemID AS ProductID, -- Retrieve ProductID from StockItemID
        si.StockItemName AS ProductName,
        sisg.StockGroupID AS StockGroupID -- Default to 0 if missing
    FROM Staging.StockItems si
    LEFT JOIN Staging.StockItemStockGroups sisg
        ON si.StockItemID = sisg.StockItemID
    LEFT JOIN Dim.StockGroup sg
        ON sg.StockGroupID = sisg.StockGroupID -- Ensure the StockGroupID matches Dim.StockGroups
END;
GO