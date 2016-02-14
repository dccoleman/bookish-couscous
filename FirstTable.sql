DROP TABLE Traveling;
DROP TABLE Guide;
DROP TABLE Vehicle;
DROP TABLE Tour;
DROP TABLE Location;


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
LocationID varchar(13) CONSTRAINT Locaiton_PK PRIMARY KEY,
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