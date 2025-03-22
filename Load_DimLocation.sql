CREATE PROCEDURE Load_DimLocation
AS
BEGIN
    INSERT INTO Dim.Location (CityID, CityName, StateProvinceID, StateProvinceName)
    SELECT DISTINCT 
        c.CityID, 
        c.CityName, 
        sp.StateProvinceID, 
        sp.StateProvinceName
    FROM staging.Cities c
    INNER JOIN staging.StateProvinces sp
    ON c.StateProvinceID = sp.StateProvinceID
    INNER JOIN staging.Customers cu
    ON c.CityID = cu.DeliveryCityID
    INNER JOIN staging.Orders o
    ON cu.CustomerID = o.CustomerID
    WHERE o.OrderID IS NOT NULL;
END;






