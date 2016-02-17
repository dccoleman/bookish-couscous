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
SELECT T.TourName, HIST.HistCount, MUES.MuesCount, REST.RestCount
FROM Tour T, (
SELECT Tr.TourID, COUNT(L.LocationType) AS HistCount
FROM Traveling Tr, Location L
GROUP BY Tr.TourID, L.LocationType
HAVING L.LocationType Like 'Historic'
) AS HIST,(
SELECT Tr.TourID, COUNT(L.LocationType) AS MuesCount
FROM Traveling Tr, Location L
GROUP BY Tr.TourID, L.LocationType
HAVING L.LocationType Like 'Museum'
) AS MUES,(
SELECT Tr.TourID, COUNT(L.LocationType) AS RestCount
FROM Traveling Tr, Location L
GROUP BY Tr.TourID, L.LocationType
HAVING L.LocationType Like 'Restaurant'
) AS REST
GROUP BY T.TourID, T.TourName, HIST.HistCount, MUES.MuesCount, REST.RestCount;