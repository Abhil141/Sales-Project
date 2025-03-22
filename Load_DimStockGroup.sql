CREATE PROCEDURE Load_DimStockGroup
AS
BEGIN
    INSERT INTO Dim.StockGroup (StockGroupID, StockGroupName)
    SELECT 
        sg.StockGroupID,
        sg.StockGroupName
    FROM staging.StockGroups sg;
END;
