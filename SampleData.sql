/* Inserting Sample Data into Tables */
--Guides
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary)
VALUES (1111111111111,'One','Un',1111111111,'Car','Junior Guide',1);
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary)
VALUES (2222222222222,'Two','Deux',2222222222,'Amphibious','Senior Guide',2);
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary)
VALUES (3333333333333,'Three','Trois',3333333333,'Bus','Guide',3);
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary)
VALUES (4444444444444,'Four','Quatre',2222222222,'Amphibious','Guide',4);
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary)
VALUES (5555555555555,'Five','Cinq',5555555555,'Bus','Senior Guide',5);

--Vehicles
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (1111111,'Car','Ford','Mustang',1995,4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (2222222,'Bus','Mystery','Machine',1984,4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (3333333,'Amphibious','Scrooge','McDuckMobile',1897,36);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (4444444,'Bus','Rolls Royce','WealthMobile',1993,2);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (5555555,'Car','Dodge','Hellcat',2015,4);

--Tours
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (1111111,'Tour A', 'Words', 'Worcester', 'MA', 7, 'Car', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (2222222,'Tour B', 'Words', 'D.C.', 'D.C.', 7, 'Amphibious', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (1111111,'Tour C', 'Words', 'Maryland', 'MA', 7, 'Bus', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (3333333,'Tour D', 'Words', 'Boston', 'MA', 7, 'Car', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (4444444,'Tour E', 'Words', 'Detroit', 'MI', 7, 'Car', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (5555555,'Tour F', 'Words', 'Las Vegas', 'Nevada', 7, 'Amphibious', 10, 3);

--Location
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (1111111, 'Some Place', 'Restaurant','1234 somewhere street',7,5);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (2222222, 'The Moon', 'Historic','Space',8,3);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (3333333, 'Death Star', 'Museum','Really Far Away',9,8);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (4444444, 'Forest Moon of Endor', 'Historic','Outer Rim',10,5);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (5555555, 'Worcester', 'Restaurant','Middle of MA',11,111);

-- Customer 
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (1111111, 'John', 'Jacob jingle heimer schmitt','Drewry Lane',2223334444,7);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (2222222, 'Jake', 'brown','100 Institute Rd. ',2223334444,7);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (3333333, 'Alex', 'brown','100 Institute Rd. ',3334445555,7);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (4444444, 'Ben', 'Stevens','20 Dix Street',4445556666,7);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (5555555, 'Stan', 'van Zyl','21 Dix Street',5556667777,7);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (6666666, 'Shirly', 'Price','22 Dix Street',6667778888,7);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (7777777, 'Carol', 'Thompson','22 Dix Street',7778889999,7);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (8888888, 'Nancy', 'Cyganski','23 Dix Street',8889991010,7);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (9999999, 'Courtney', 'Dotson','3 Dean Street',9991011111,7);

