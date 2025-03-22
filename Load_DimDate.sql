CREATE PROCEDURE Load_DimDate
AS
BEGIN
    -- Insert unique dates into Dim.Date
    INSERT INTO Dim.Date (Date, Month, Year, Day)
    SELECT DISTINCT
        CAST(o.OrderDate AS DATE) AS Date,
        MONTH(o.OrderDate) AS Month,
        YEAR(o.OrderDate) AS Year,
        DATENAME(WEEKDAY, o.OrderDate) AS Day -- Get the day of the week as a name
    FROM staging.Orders o;
END;




