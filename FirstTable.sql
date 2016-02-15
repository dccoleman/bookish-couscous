DROP TABLE Traveling;
DROP TABLE Vehicle;
DROP TABLE Location;
DROP TABLE TravelingWith;
DROP TABLE BookedTour;
DROP TABLE Customer;
DROP TABLE Guide;
DROP TABLE Tour;


CREATE TABLE Guide
(
DriverLicense varchar(13) CONSTRAINT Guide_PK PRIMARY KEY,
FirstName varchar(255),
LastName varchar(255),
Phone int,
VehicleType varchar(255), 
Title varchar(255), 
Salary int, 
HireDate date
);

CREATE TABLE Vehicle
(
LicensePlate varchar(7) CONSTRAINT Vehicle_PK PRIMARY KEY,
VehicleType varchar(255),
VehicleMake varchar(255),
VehicleModel varchar(255),
VehicleYear int, 
MaxPassenger int
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
ChildCost number
);

CREATE TABLE Location
(
LocationID varchar(13) CONSTRAINT Location_PK PRIMARY KEY,
LocationName varchar(255),
LocationType varchar(255),
LocationAddress int,
Longitude number, 
Latitude number
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
FOREIGN KEY (TourID) REFERENCES Tour(TourID),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
FOREIGN KEY (DriverLicense) REFERENCES Guide(DriverLicense)
);