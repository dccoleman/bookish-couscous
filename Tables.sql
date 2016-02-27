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
