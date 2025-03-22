CREATE OR ALTER PROCEDURE Load_FactOrder
AS
BEGIN
    -- Insert order details into Fact.Order
    INSERT INTO Fact.[Order] (OrderID, CustomerID, DateID, OrderTotal, OrderQuantity, LocationID)
    SELECT 
        o.OrderID,
        o.CustomerID,
        d.DateID,
        SUM(ol.Quantity * ol.UnitPrice) AS OrderTotal,
        SUM(ol.Quantity) AS OrderQuantity,
        l.LocationID
    FROM staging.Orders o
    INNER JOIN staging.OrderLines ol
        ON o.OrderID = ol.OrderID
    INNER JOIN Dim.Date d
        ON CAST(o.OrderDate AS DATE) = d.Date
    INNER JOIN staging.Customers c
        ON o.CustomerID = c.CustomerID
    INNER JOIN Dim.Location l
        ON c.DeliveryCityID = l.CityID
    WHERE o.OrderID IS NOT NULL -- Ensure that only valid orders are included
    GROUP BY o.OrderID, o.CustomerID, d.DateID, l.LocationID;
END;
GO



