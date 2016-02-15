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

--Location
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (1111111, "Some Place", "Restaurant","1234 somewhere street",7,5);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (2222222, "The Moon", "Historic","Space",8,3);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (3333333, "Death Star", "Museum","Really Far Away",9,8);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (4444444, "Forest Moon of Endor", "Historic","Outer Rim",10,5);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (5555555, "Worcester", "Restaurant","Middle of MA",11,111);

-- Customer 
