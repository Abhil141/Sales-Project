CREATE PROCEDURE Load_DimCustomer
AS
BEGIN
    INSERT INTO Dim.Customer (CustomerID, CustomerName, LocationID)
    SELECT 
        cu.CustomerID,
        cu.CustomerName,
        l.LocationID
    FROM staging.Customers cu
    INNER JOIN Dim.Location l
        ON cu.DeliveryCityID = l.CityID;
END;


