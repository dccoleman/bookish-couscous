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
SELECT Gu.DriverLicense, Gu.FirstName, Gu.LastName, Gu.Title, COUNT(Bt.BookedTourID) AS cntBT
FROM Guide Gu, BookedTour Bt
WHERE Gu.DriverLicense = Bt.DriverLicense
GROUP BY Gu.DriverLicense, Gu.FirstName, Gu.LastName, Gu.Title;


-- 5 
SELECT T.TourName, COUNT(Tr.LocationType = 'Historic'), COUNT(Tr.LocationType = 'Museum'), COUNT(Tr.LocationType = 'Restaurant')
FROM Tour T, (SELECT * FROM Traveling NATURAL JOIN Location) AS Tr
GROUP BY T.TourName