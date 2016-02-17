-- 1 
SELECT LicensePlate, VehicleMake, VehicleModel 
FROM Vehicle 
WHERE MaxPassenger > 10;

-- 2 
SELECT FirstName, LastName, LicensePlate, VehicleMake, VehicleModel
FROM Vehicle Ve, Guide Gu
WHERE Ve.VehicleType = Gu.VehicleType
AND Gu.DriverLicense = 1111111111111;

-- 3
SELECT Cu.CustomerID, Cu.FirstName, Cu.LastName, Cu.Age, COUNT(Bt.BookedTourID) AS cntBT
FROM Customer Cu, BookedTour Bt
WHERE Cu.CustomerID = Bt.CustomerID
GROUP BY Cu.CustomerID, Cu.FirstName, Cu.LastName, Cu.Age;

-- 4
SELECT Gu.DriversLicense, Gu.FirstName, Gu.LastName, Gu.Age, COUNT(Bt.BookedTourID) AS cntBT
FROM Guide Gu, BookedTour Bt,
WHERE Gu.DriversLicense = Bt.DriversLicense
GROUP BY Gu.DriversLicense, Gu.FirstName, Gu.LastName, Gu.Title;


