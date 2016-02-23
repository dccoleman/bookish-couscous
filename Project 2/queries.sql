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
SELECT TourName, L.LocationType, COUNT(L.LocationID) AS Count
FROM Tour T, Location L, Traveling Tr
WHERE T.TourID = Tr.TourID AND L.LocationID = Tr.LocationID
GROUP BY TourName, L.LocationType
ORDER BY TourName;

-- 6
/* Report the number of people taking each of the different tours.
Include the TourName, City, State and VehicleType. Make sure to count
the primary customer as well as those who are traveling along with him or her. */

SELECT TourName, Stateheld, City, VehicleType, COUNT(Tw.CustomerID)
FROM TravelingWith Tw, BookedTour B, Tour T
WHERE B.TourID = T.TourID AND B.CustomerID = Tw.TravelingWithID
GROUP BY TourName, TravelingWithID, Stateheld, City, VehicleType
ORDER BY TourName;

-- 7
SELECT CustomerID
FROM BookedTour
WHERE PurchaseDate >= DATE '2015-01-01'
AND PurchaseDate <= DATE '2016-12-31';

-- 8
SELECT TourID, Count(BookedTourID) as NumOccur
FROM BookedTour
GROUP BY TourID;

-- 9
SELECT Count(*) As TotalNumber
FROM BookedTour;