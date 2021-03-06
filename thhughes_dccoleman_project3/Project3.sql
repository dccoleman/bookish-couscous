/* Part 1 */

/* Dropping all tables */
DROP TABLE Traveling;
DROP TABLE Location;
DROP TABLE TravelingWith;
DROP TABLE BookedTour;
DROP TABLE Customer;
DROP TABLE Guide;
DROP TABLE Tour;
DROP TABLE Vehicle;

/* Creating tables */
CREATE TABLE Guide
(
DriverLicense varchar(13) CONSTRAINT Guide_PK PRIMARY KEY,
FirstName varchar(255),
LastName varchar(255),
Phone int,
VehicleType varchar(255), 
Title varchar(255), 
Salary int, 
HireDate date,
CONSTRAINT guideTitle CHECK (Title in ('Junior Guide','Guide','Senior Guide')),
CONSTRAINT guideVehicleType CHECK (VehicleType in ('Car','Amphibious','Bus'))
);

CREATE TABLE Vehicle
(
LicensePlate varchar(7) CONSTRAINT Vehicle_PK PRIMARY KEY,
VehicleType varchar(255),
VehicleMake varchar(255),
VehicleModel varchar(255),
VehicleYear date, 
MaxPassenger int,
CONSTRAINT vehicleType CHECK (VehicleType in ('Car','Amphibious','Bus'))
);

CREATE TABLE Tour
(
TourID varchar(13) CONSTRAINT Tour_PK PRIMARY KEY,
TourName varchar(255),
Description varchar(255),
City varchar(255),
StateHeld varchar(255), 
Duration int, 
VehicleType varchar(255), 
AdultCost number,
ChildCost number,
CONSTRAINT tourVehicleType CHECK (VehicleType in ('Car','Amphibious','Bus'))
);

CREATE TABLE Location
(
LocationID varchar(13) CONSTRAINT Location_PK PRIMARY KEY,
LocationName varchar(255),
LocationType varchar(255),
LocationAddress varchar(255),
Longitude number, 
Latitude number,
CONSTRAINT locationTypeIs CHECK (LocationType in ('Historic','Museum','Restaurant'))
);

CREATE TABLE Traveling
(
TourID varchar(13),
LocationID varchar(13),
CONSTRAINT fk_tourid FOREIGN KEY (TourID) REFERENCES Tour(TourID), 
CONSTRAINT fk_locaitonid FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

CREATE TABLE Customer
(
CustomerID varchar(13) CONSTRAINT Customer_PK PRIMARY KEY,
FirstName varchar(255),
LastName varchar(255),
Address varchar(255),
Phone int,
Age int
);

CREATE TABLE TravelingWith
(
TravelingWithID varchar(13),
CustomerID varchar(13),
FirstName varchar(255),
LastName varchar(255),
Age int,
CONSTRAINT TravelingWith_PK PRIMARY KEY (TravelingWithID,CustomerID),
FOREIGN KEY (TravelingWithID) REFERENCES Customer(CustomerID),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE BookedTour
(
BookedTourID varchar(13) CONSTRAINT BookedTour_PK PRIMARY KEY,
PurchaseDate date,
TravelDate date,
TotalPrice int,
TourID varchar(13),
DriverLicense varchar(13),
CustomerID varchar(13),
LicensePlate varchar(7),
FOREIGN KEY (TourID) REFERENCES Tour(TourID),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
FOREIGN KEY (DriverLicense) REFERENCES Guide(DriverLicense),
FOREIGN KEY (LicensePlate) REFERENCES Vehicle(LicensePlate)
);

CREATE VIEW BookedTour_AD AS
SELECT BookedTourID, c.CustomerID, g.DriverLicense, c.firstName AS CustomerFirstName, 
c.lastName AS CustomerLastName, c.age AS CustomerAge, TourName, PurchaseDate, TravelDate,
g.firstName AS GuideFirstName, g.lastName AS GuideLastName, LicensePlate, TotalPrice
FROM BookedTour bt, Guide g, Customer c, Tour t
WHERE bt.driverlicense = g.driverlicense 
	AND bt.customerid = c.customerid 
	AND bt.tourID = t.tourid;

SET SERVEROUTPUT ON FORMAT WORD_WRAPPED;


/* Triggers */
-- Project 2 Trigger
PROMPT =========EVALBOOKEDTOURTOTAL=========

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


/* Part 2 */ 
-- Problem 1
/*
	This will error out if a Senior Guide is entered that has a salary < $50,000
*/
PROMPT =========SRGUIDESALARYCHECK=========

CREATE TRIGGER SrGuideSalaryCheck
BEFORE INSERT OR UPDATE ON Guide
FOR EACH ROW
BEGIN 
	IF (:new.title = 'Senior Guide') Then
		IF (:new.salary < 50000) Then
			RAISE_APPLICATION_ERROR(-20003, 'Pay your Senior Guides More than 50,000!');
		END IF;
	END IF;
END;
/

-- Problem 2
/*
	This will error out if the Bus that is entered was not made after Jan 1 of 2010
*/
PROMPT =========BUSAGECHECKING=========
CREATE OR REPLACE TRIGGER BusAgeChecking
BEFORE INSERT OR UPDATE ON Vehicle
FOR EACH ROW
BEGIN 
	IF (:new.VehicleType = 'Bus') Then
		IF (:new.VehicleYear < '01-JAN-2010') Then
			RAISE_APPLICATION_ERROR(-20003, 'Get a newer bus!');
		END IF;
	END IF;
END;
/
	
	
PROMPT =========CHECKTBOSTONTOURVEHICLE=========
-- Problem 3
CREATE TRIGGER CheckTBostonTourVehicle
BEFORE INSERT OR UPDATE ON Tour
FOR EACH ROW
BEGIN 
	IF (:new.City = 'Boston') Then
		IF (:new.VehicleType = 'Bus') Then
			RAISE_APPLICATION_ERROR(-20003, 'Vehicle type must be amphibious');
		END IF;
		IF (:new.VehicleType = 'Car') Then
			RAISE_APPLICATION_ERROR(-20003, 'Vehicle type must be amphibious');
		END IF;
	END IF;
END;
/

PROMPT =========SETPURCHASEDATE=========
-- Problem 4
CREATE TRIGGER SetPurchaseDate
BEFORE INSERT ON BookedTour
FOR EACH ROW
BEGIN
	:new.PurchaseDate := ADD_MONTHS(SYSDATE, 3);
END;
/

PROMPT =========Guides Booking More than One Tour A Day=========
CREATE TRIGGER GuideTourBookLimiter
BEFORE INSERT ON BookedTour
FOR EACH ROW
DECLARE
	CURSOR c1(DL in VARCHAR) IS
	SELECT DriverLicense, TravelDate
	FROM BookedTour
	WHERE DriverLicense = DL;
BEGIN
	FOR TravelDate in c1(:new.DriverLicense) LOOP
		IF :new.TravelDate = TravelDate.TravelDate THEN
			RAISE_APPLICATION_ERROR(-20003, 'Guide already has tour booked that day');
		END IF;
	END LOOP;
END;
/



PROMPT ========== STARTING DATA ENTRY =====================

	
	

/* Inserting Sample Data into Tables */
--Guides
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (1111111111111,'One','Un',1111111111,'Car','Junior Guide',1,'01-JAN-2016');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (2222222222222,'Two','Deux',2222222222,'Amphibious','Senior Guide',50001,'02-FEB-2016');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (3333333333333,'Three','Trois',3333333333,'Bus','Guide',3,'03-MAR-2000');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (4444444444444,'Four','Quatre',2222222222,'Amphibious','Guide',4,'04-APR-2012');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (5555555555555,'Five','Cinq',5555555555,'Bus','Senior Guide',50000000,'05-MAR-1995');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (1212121212121,'OneOne','UnUn',1111111112,'Car','Junior Guide',1,'01-JAN-2016');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (2323232323232,'TwoTwo','DeuxDeux',2222222223,'Amphibious','Senior Guide',222222,'02-FEB-2016');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (3434343434343,'ThreeThree','TroisTrois',3333333334,'Bus','Guide',3,'03-MAR-2000');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (4545454545454,'FourFour','QuatreQuatre',2222222223,'Amphibious','Guide',4,'04-APR-2012');
INSERT INTO Guide (DriverLicense,FirstName,LastName,Phone,VehicleType,Title,Salary,HireDate)
VALUES (5656565656565,'FiveFive','CinqCinq',5555555556,'Bus','Senior Guide',100000,'05-MAR-1995');





--Vehicles
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (1111111,'Car','Ford','Mustang','05-DEC-1996',4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (2222222,'Bus','Mystery','Machine','12-JAN-2012',4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (3333333,'Amphibious','Scrooge','McDuckMobile','16-AUG-2002',36);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (4444444,'Bus','Rolls Royce','WealthMobile','30-MAY-3001',2);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (5555555,'Car','Dodge','Hellcat','30-JAN-1000',4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (1212121,'Car','Ford','Mustang','05-DEC-1996',4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (2323232,'Bus','Mystery','Machine','12-JAN-2021',4);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (3434343,'Amphibious','Scrooge','McDuckMobile','16-AUG-2002',36);
INSERT INTO Vehicle (LicensePlate,VehicleType,VehicleMake,VehicleModel,VehicleYear,MaxPassenger)
VALUES (4545454,'Bus','Rolls Royce','WealthMobile','30-MAY-2011',2);
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
VALUES (1212121, 1111111, 'John', 'Jacob jingle heimer schmitt',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (2323232, 1111111, 'John', 'Jacob jingle heimer schmitt',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (3434343, 1111111, 'John', 'Jacob jingle heimer schmitt',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (4545454, 1111111, 'John', 'Jacob jingle heimer schmitt',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (5656565, 1111111, 'John', 'Jacob jingle heimer schmitt',7);

INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (3333333, 2222222, 'Jake', 'brown',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (4444444, 3333333, 'Alex', 'brown',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (1212121, 2222222, 'Jake', 'brown',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (2323232, 3333333, 'Alex', 'brown',7);

INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (5555555, 4444444, 'Ben', 'Stevens',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (6666666, 4444444, 'Ben', 'Stevens',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (5656565, 4444444, 'Ben', 'Stevens',7);
INSERT INTO TravelingWith (TravelingWithID, CustomerID, FirstName, LastName, Age)
VALUES (6767676, 4444444, 'Ben', 'Stevens',7);


--BookedTours
PROMPT =============BOOKED TOURS=============
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (1111111111111,'01-JAN-2015','12-FEB-2016',111,1111111,1111111111111,1111111,1111111);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (2222222222222,'20-FEB-2014','20-FEB-2014',222,2222222,2222222222222,2222222,2222222);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (3333333333333,'31-MAY-2016','28-FEB-2018',333,4444444,3333333333333,3333333,3333333);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (4444444444444,'20-OCT-2012','29-APR-2013',444,4444444,4444444444444,4444444,4444444);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (5555555555555,'12-DEC-2015','30-MAR-2020',555,5555555,5555555555555,4444444,5555555);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (6666666666666,'15-AUG-2020','15-AUG-2021',666,0000000,5555555555555,6666666,1212121);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (7777777777777,'15-AUG-2021','16-AUG-2021',666,0000000,5555555555555,6666666,2323232);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (8888888888888,'15-AUG-2021','17-AUG-2021',666,0000000,5555555555555,6666666,3434343);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (9999999999999,'01-JAN-2015','26-FEB-2016',111,1111111,1111111111111,1111111,4545454);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (1010101010101,'20-FEB-2014','29-JUN-2014',222,2222222,2222222222222,2222222,5656565);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (1101101101101,'31-MAY-2016','21-FEB-2018',333,4444444,3333333333333,3333333,1111111);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (1212121212121,'20-OCT-2012','10-APR-2013',444,4444444,4444444444444,4444444,1111111);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (1313131313131,'12-DEC-2015','31-MAR-2020',555,5555555,5555555555555,4444444,1111111);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (1414141414141,'15-AUG-2020','13-AUG-2021',666,0000000,5555555555555,6666666,1111111);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (1515151515151,'15-AUG-2021','12-AUG-2021',666,0000000,5555555555555,6666666,1111111);
INSERT INTO BookedTour (BookedTourID,PurchaseDate,TravelDate,TotalPrice,TourID,DriverLicense,CustomerID, LicensePlate)
VALUES (1616161616161,'15-AUG-2021','29-AUG-2021',666,0000000,5555555555555,6666666,1111111);
PROMPT ===================END BOOKED TOURS===================

-- Still Need to Double the Below Data
-- Traveling
PROMPT ==1s==
INSERT INTO Traveling (TourID, LocationID)
VALUES (1111111, 1111111);
INSERT INTO Traveling (TourID, LocationID)
VALUES (1111111, 2222222);
INSERT INTO Traveling (TourID, LocationID)
VALUES (1111111, 3333333);
INSERT INTO Traveling (TourID, LocationID)
VALUES (1111111, 4444444);

PROMPT ==4s==
INSERT INTO Traveling (TourID, LocationID)
VALUES (4444444, 3333333);
INSERT INTO Traveling (TourID, LocationID)
VALUES (4444444, 2222222);
INSERT INTO Traveling (TourID, LocationID)
VALUES (4444444, 1111111);
INSERT INTO Traveling (TourID, LocationID)
VALUES (4444444, 5555555);

PROMPT ==2s==
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
VALUES (2222222, 1212121);
INSERT INTO Traveling (TourID, LocationID)
VALUES (2222222, 2323232);
INSERT INTO Traveling (TourID, LocationID)
VALUES (2222222, 3434343);
INSERT INTO Traveling (TourID, LocationID)
VALUES (2222222, 4545454);
INSERT INTO Traveling (TourID, LocationID)
VALUES (2222222, 5656565);

PROMPT ==3s==
INSERT INTO Traveling (TourID, LocationID)
VALUES (1212121, 4444444);
INSERT INTO Traveling (TourID, LocationID)
VALUES (1212121, 5555555);
INSERT INTO Traveling (TourID, LocationID)
VALUES (1212121, 2222222);
INSERT INTO Traveling (TourID, LocationID)
VALUES (1212121, 1111111);
INSERT INTO Traveling (TourID, LocationID)
VALUES (1212121, 1212121);
INSERT INTO Traveling (TourID, LocationID)
VALUES (1212121, 2323232);

PROMPT ==0s==
INSERT INTO Traveling (TourID, LocationID)
VALUES (0000000, 2222222);
INSERT INTO Traveling (TourID, LocationID)
VALUES (0000000, 1111111);
INSERT INTO Traveling (TourID, LocationID)
VALUES (0000000, 3333333);
INSERT INTO Traveling (TourID, LocationID)
VALUES (0000000, 4444444);


