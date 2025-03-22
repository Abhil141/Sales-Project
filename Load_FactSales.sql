CREATE OR ALTER PROCEDURE Load_FactSales
AS
BEGIN
    INSERT INTO Fact.Sales (OrderID, ProductID, CustomerID, Quantity, UnitPrice, LineTotal, DateID, LocationID, StockGroupID)
    SELECT 
        o.OrderID,
        p.ProductID,
        o.CustomerID,
        ol.Quantity,
        ol.UnitPrice,
        ol.Quantity * ol.UnitPrice AS LineTotal,
        d.DateID,
        l.LocationID,
        sg.StockGroupID
    FROM staging.OrderLines ol
    INNER JOIN Fact.[Order] o
        ON ol.OrderID = o.OrderID
    INNER JOIN Dim.Product p
        ON ol.StockItemID = p.ProductID
    INNER JOIN Dim.Date d
        ON o.DateID = d.DateID
    INNER JOIN Dim.Location l
        ON o.LocationID = l.LocationID
    Inner JOIN Dim.StockGroup sg
        ON p.StockGroupID = sg.StockGroupID;
END;
GO




