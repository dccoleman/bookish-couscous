
CREATE TRIGGER EvalBookedTourTotal
BEFORE INSERT ON BookedTour
FOR EACH ROW 
DECLARE
	cursor curs1(CID in VARCHAR) is
		(SELECT TravelingWith.Age
		FROM TravelingWith
		WHERE TravelingWith.CustomerID = CID)
		
		UNION
		
		(SELECT Customer.Age
		FROM Customer
		WHERE CID = Customer.CustomerID);
BEGIN 
:new.TotalPrice :=0;
	FOR currentAge in curs1(:new.CustomerID) LOOP
		IF (currentAge.Age < 18) THEN 
			:new.TotalPrice := :new.TotalPrice + 50;
		ELSE :new.TotalPrice := :new.TotalPrice + 100;
		END IF;
	END LOOP;
END; 
/

	
	

/* Inserting Sample Data into Tables */
--Guides
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (1111111111111,'One','Un',1111111111,'Car','Junior Guide',1,'01-JAN-2016');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (2222222222222,'Two','Deux',2222222222,'Amphibious','Senior Guide',2,'02-FEB-2016');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (3333333333333,'Three','Trois',3333333333,'Bus','Guide',3,'03-MAR-2000');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (4444444444444,'Four','Quatre',2222222222,'Amphibious','Guide',4,'04-APR-2012');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (5555555555555,'Five','Cinq',5555555555,'Bus','Senior Guide',5,'05-MAR-1995');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (1212121212121,'OneOne','UnUn',1111111112,'Car','Junior Guide',1,'01-JAN-2016');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (2323232323232,'TwoTwo','DeuxDeux',2222222223,'Amphibious','Senior Guide',2,'02-FEB-2016');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (3434343434343,'ThreeThree','TroisTrois',3333333334,'Bus','Guide',3,'03-MAR-2000');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (4545454545454,'FourFour','QuatreQuatre',2222222223,'Amphibious','Guide',4,'04-APR-2012');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (5656565656565,'FiveFive','CinqCinq',5555555556,'Bus','Senior Guide',5,'05-MAR-1995');





--Vehicles
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (1111111,'Car','Ford','Mustang','05-DEC-1996',4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (2222222,'Bus','Mystery','Machine','12-JAN-2001',4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (3333333,'Amphibious','Scrooge','McDuckMobile','16-AUG-2002',36);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (4444444,'Bus','Rolls Royce','WealthMobile','30-MAY-1995',2);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (5555555,'Car','Dodge','Hellcat','30-JAN-1000',4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (1212121,'Car','Ford','Mustang','05-DEC-1996',4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (2323232,'Bus','Mystery','Machine','12-JAN-2001',4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (3434343,'Amphibious','Scrooge','McDuckMobile','16-AUG-2002',36);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (4545454,'Bus','Rolls Royce','WealthMobile','30-MAY-1995',2);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (5656565,'Car','Dodge','Hellcat','30-JAN-1000',4);

--Tours
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (1111111,'Tour A', 'Words', 'Worcester', 'MA', 7, 'Car', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (2222222,'Tour B', 'Words', 'D.C.', 'D.C.', 7, 'Amphibious', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (0000000,'Tour C', 'Words', 'Maryland', 'MA', 7, 'Bus', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (3333333,'Tour D', 'Words', 'Boston', 'MA', 7, 'Car', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (4444444,'Tour E', 'Words', 'Detroit', 'MI', 7, 'Car', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (5555555,'Tour F', 'Words', 'Las Vegas', 'Nevada', 7, 'Amphibious', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (1212121,'Tour G', 'Words', 'Worcester', 'MA', 7, 'Car', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (2323232,'Tour H', 'Words', 'D.C.', 'D.C.', 7, 'Amphibious', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (0101010,'Tour I', 'Words', 'Maryland', 'MA', 7, 'Bus', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (3434343,'Tour J', 'Words', 'Boston', 'MA', 7, 'Car', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (4545454,'Tour K', 'Words', 'Detroit', 'MI', 7, 'Car', 10, 3);
INSERT INTO Tour (TourID, TourName, Description, City, StateHeld, Duration, VehicleType, AdultCost, ChildCost)
VALUES (5656565,'Tour L', 'Words', 'Las Vegas', 'Nevada', 7, 'Amphibious', 10, 3);

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
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (1212121, 'Some Place', 'Restaurant','1234 somewhere street',7,5);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (2323232, 'The Moon', 'Historic','Space',8,3);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (3434343, 'Death Star', 'Museum','Really Far Away',9,8);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (4545454, 'Forest Moon of Endor', 'Historic','Outer Rim',10,5);
INSERT INTO Location (LocationID, LocationName, LocationType, LocationAddress, Longitude, Latitude)
VALUES (5656565, 'Worcester', 'Restaurant','Middle of MA',11,111);

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
VALUES (1212121, 'Abby', 'Jacob jingle heimer schmitt','Drewry Lane',2223334445,100);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (2323232, 'Elzani', 'brown','100 Institute Rd. ',2223334446,100);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (3434343, 'Kyle', 'brown','100 Institute Rd. ',3334445556,100);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (4545454, 'Ben', 'Vincentelli','20 Dix Street',4445556667,100);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (5656565, 'Stan', 'Lee','21 Dix Street',5556667778,100);
INSERT INTO Customer (CustomerID, FirstName, LastName, Address, Phone, Age)
VALUES (6767676, 'Shirly', 'Temple','22 Dix Street',6667778889,100);




-- Still Need to Double the Below Data

-- TravelingWith
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (2222222, 1111111, 'John', 'Jacob jingle heimer schmitt',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (3333333, 1111111, 'John', 'Jacob jingle heimer schmitt',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (4444444, 1111111, 'John', 'Jacob jingle heimer schmitt',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (5555555, 1111111, 'John', 'Jacob jingle heimer schmitt',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (6666666, 1111111, 'John', 'Jacob jingle heimer schmitt',7);

INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (3333333, 2222222, 'Jake', 'brown',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (4444444, 3333333, 'Alex', 'brown',7);

INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (5555555, 4444444, 'Ben', 'Stevens',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (6666666, 4444444, 'Ben', 'Stevens',7);

--BookedTours
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID)
VALUES (1111111111111,'01-JAN-2015','12-FEB-2016',111,1111111,1111111111111,1111111);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID)
VALUES (2222222222222,'20-FEB-2014','20-FEB-2014',222,2222222,2222222222222,2222222);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID)
VALUES (3333333333333,'31-MAY-2016','28-FEB-2018',333,3333333,3333333333333,3333333);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID)
VALUES (4444444444444,'20-OCT-2012','29-APR-2013',444,4444444,4444444444444,4444444);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID)
VALUES (5555555555555,'12-DEC-2015','30-MAR-2020',555,5555555,5555555555555,4444444);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID)
VALUES (6666666666666,'15-AUG-2020','15-AUG-2021',666,0000000,5555555555555,6666666);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID)
VALUES (7777777777777,'15-AUG-2021','16-AUG-2021',666,0000000,5555555555555,6666666);


-- Traveling
INSERT INTO Traveling (TourID, LocationID)
VALUES (1111111, 1111111);
INSERT INTO Traveling (TourID, LocationID)
VALUES (1111111, 2222222);

INSERT INTO Traveling (TourID, LocationID)
VALUES (4444444, 3333333);
INSERT INTO Traveling (TourID, LocationID)
VALUES (4444444, 2222222);

INSERT INTO Traveling (TourID, LocationID)
VALUES (2222222, 1111111);
INSERT INTO Traveling (TourID, LocationID)
VALUES (2222222, 3333333);
INSERT INTO Traveling (TourID, LocationID)
VALUES (2222222, 4444444);
INSERT INTO Traveling (TourID, LocationID)
VALUES (2222222, 5555555);
INSERT INTO Traveling (TourID, LocationID)
VALUES (2222222, 2222222);

INSERT INTO Traveling (TourID, LocationID)
VALUES (3333333, 4444444);
INSERT INTO Traveling (TourID, LocationID)
VALUES (3333333, 5555555);
INSERT INTO Traveling (TourID, LocationID)
VALUES (3333333, 2222222);

INSERT INTO Traveling (TourID, LocationID)
VALUES (0000000, 2222222);

INSERT INTO Traveling (TourID, LocationID)
VALUES (0000000, 1111111);

