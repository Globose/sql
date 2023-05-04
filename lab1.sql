show databases;
use dv1664;

CREATE TABLE Cars (
	CarNumber int primary key,
    Brand varchar(255),
    Model varchar(255),
    Color varchar(255),
    PricePerDay int
);
SELECT * FROM Cars;

INSERT INTO Cars 
VALUES 
	(1, 'Peugeot', '208', 'Blue', 800),
	(2, 'Peugeot', '3008', 'Green', 700),
	(3, 'Volkswagen', 'Polo', 'Red', 600),
	(4, 'Volvo', 'V70', 'Silver', 1200),
    (5, 'Tesla', 'X', 'Black', 2000),
	(6, 'SAAB', '9-5', 'Green', 850),
	(7, 'Volvo', 'V40', 'Red', 900),
	(8, 'Fiat', '500', 'Black', 1050),
	(9, 'Volvo', 'V40', 'Green', 850),
	(10, 'Fiat', '500', 'Red', 950),
	(11, 'Volkswagen', 'Polo', 'Blue', 700),
	(12, 'BMW', 'M3', 'Black', 1599),
	(13, 'Volkswagen', 'Golf', 'Red', 1500);


DROP TABLE Customers;
CREATE TABLE Customers (
	CustomerNumber int primary key,
    CustomerName varchar(255),
    BirthDate DATE
);
SELECT * FROM Customers;

INSERT INTO Customers
VALUES 
	(1, 'Alice Andersson', '1990-05-05'),
	(2, 'Oscar Johansson', '1975-08-10'),
	(3, 'Nora Hansen', '1981-10-27'),
	(4, 'William Johansen', '2000-01-17'),
	(5, 'Lucía García', '1987-12-13'),
	(6, 'Hugo Fernández', '1950-03-16'),
	(7, 'Sofia Rossi', '1995-08-04'),
	(8, 'Francesco Russo', '2000-02-26'),
	(9, 'Olivia Smith', '1972-05-23'),
	(10, 'Oliver Jones', '1964-05-08'),
	(11, 'Shaimaa Elhawary', '1999-12-23'),
	(12, 'Mohamed Elshabrawy', '1997-11-07'),
	(13, 'Jing Wong', '1947-07-15'),
	(14, 'Wei Lee', '1962-09-29'),
	(15, 'Aadya Singh', '1973-01-01'),
	(16, 'Aarav Kumar', '1986-06-28'),
	(17, 'Louise Martin', '1994-04-22'),
	(18, 'Gabriel Bernard', '1969-12-01'),
	(19, 'Emma Smith', '1971-03-18'),
	(20, 'Noah Johnson', '1800-12-16'),
	(21, 'Alice Silva', '1988-12-04'),
	(22, 'Miguel Santos', '1939-12-29');

DROP TABLE Bookings;
CREATE TABLE Bookings (
	CustomerNumber int,
    CarNumber int,
    StartDate DATE,
    EndDate DATE,
    constraint PK_Bookings primary key (CustomerNumber, CarNumber, StartDate)
);
SELECT * FROM Bookings;

INSERT INTO Bookings
VALUES
	(1, 6, '2018-01-02', '2018-01-15'),
	(2, 1, '2018-01-03', '2018-01-05'),
	(4, 3, '2018-01-03', '2018-01-04'),
	(5, 8, '2018-01-04', '2018-01-30'),
	(6, 10, '2018-01-10', '2018-01-13'),
	(1, 1, '2018-01-20', '2018-01-25'),
	(2, 13, '2018-01-21', '2018-01-30'),
	(3, 6, '2018-01-22', '2018-01-30'),
	(1, 2, '2018-01-29', '2018-02-01'),
	(2, 5, '2018-02-02', '2018-02-06'),
	(6, 1, '2018-02-20', '2018-02-25'),
	(7, 6, '2018-02-21', '2018-02-24'),
	(8, 3, '2018-02-21', '2018-02-28'),
	(10, 3, '2018-02-22', '2018-02-26'),
	(9, 12, '2018-02-22', '2018-02-28'),
	(10, 13, '2018-03-01', '2018-03-10'),
	(11, 1, '2018-03-04', '2018-03-09'),
	(10, 3, '2018-03-11', '2018-03-14'),
	(8, 6, '2018-03-14', '2018-03-17'),
	(9, 5, '2018-03-14', '2018-03-30'),
	(7, 12, '2018-03-18', '2018-03-20'),
	(6, 8, '2018-03-18', '2018-04-02');

-- SELECTION, PROJECTION and RESTRICTION
SELECT CustomerName, Birthdate FROM Customers;
SELECT * FROM Cars WHERE PricePerDay > 1000;
SELECT Brand, Model FROM Cars WHERE Brand = 'Volvo';
SELECT CustomerName FROM Customers ORDER BY CustomerName DESC;
SELECT CustomerName FROM Customers WHERE YEAR(BirthDate) > 1989;
SELECT * FROM Cars WHERE Color = 'Red';
SELECT CustomerName FROM Customers WHERE YEAR(BirthDate) BETWEEN 1970 AND 1990;
SELECT * FROM Bookings WHERE EndDate-StartDate > 6;
SELECT * FROM Bookings WHERE StartDate < ('2018-02-25') AND EndDate > ('2018-02-01');
SELECT * FROM Customers WHERE CustomerName LIKE 'O%';

-- AGGREGATED FUNCTIONS
SELECT AVG(PricePerDay) FROM Cars;
SELECT SUM(PricePerDay) FROM Cars;
SELECT AVG(PricePerDay) FROM Cars WHERE Color = 'Red';
SELECT Color, AVG(PricePerDay) FROM Cars GROUP BY Color;
SELECT Color, COUNT(Color) FROM Cars GROUP BY Color;
SELECT * FROM Cars ORDER BY PricePerDay DESC LIMIT 1;

-- JOINS
SELECT * FROM Cars JOIN Bookings;
SELECT * FROM Customers JOIN Bookings;
SELECT * FROM Cars JOIN Bookings ON Cars.CarNumber=Bookings.CarNumber;
SELECT * FROM Customers JOIN Bookings ON Customers.CustomerNumber=Bookings.CustomerNumber;
SELECT DISTINCT CustomerName FROM Customers JOIN Bookings ON Customers.CustomerNumber=Bookings.CustomerNumber;
SELECT DISTINCT Cars.CarNumber, Brand FROM Cars JOIN Bookings ON Cars.CarNumber=Bookings.CarNumber WHERE Brand='Volkswagen';

SELECT * FROM Customers WHERE CustomerNumber IN (
	SELECT CustomerNumber FROM Bookings WHERE CarNumber IN (
		SELECT CarNumber FROM Cars WHERE Brand='Volkswagen'
    )
);

SELECT * FROM Cars WHERE CarNumber IN (SELECT CarNumber FROM Bookings);
SELECT * FROM Cars WHERE CarNumber NOT IN (SELECT CarNumber FROM Bookings);
SELECT * FROM Cars WHERE Color='Black' AND CarNumber IN (SELECT CarNumber FROM Bookings);


-- NESTED QUERIES
SELECT * FROM Cars WHERE PricePerDay > (SELECT AVG(PricePerDay) FROM Cars);
SELECT * FROM Cars WHERE Color='Black' ORDER BY PricePerDay LIMIT 1;
SELECT * FROM Cars ORDER BY PricePerDay LIMIT 1;
SELECT * FROM Cars WHERE Color='Black' AND CarNumber IN (SELECT CarNumber FROM Bookings);

-- IN
SELECT * FROM Cars WHERE PricePerDay IN (700, 800, 850);
SELECT * FROM Customers WHERE YEAR(BirthDate) IN (1990, 1995, 2000);
SELECT * FROM Bookings WHERE StartDate IN ('2018-01-03','2018-03-18','2018-02-22');

-- BETWEEN
SELECT * FROM Cars WHERE PricePerDay BETWEEN 600 AND 1000;
SELECT * FROM Customers WHERE YEAR(BirthDate) BETWEEN 1960 and 1980;
select * from Bookings where (date(EndDate)-date(StartDate)) < 4;

SELECT * FROM Cars WHERE CarNumber NOT IN (
	SELECT CarNumber FROM Bookings WHERE StartDate < ('2018-02-05') AND EndDate > ('2018-02-02')
);

SELECT * FROM Cars WHERE CarNumber IN (
	SELECT CarNumber FROM Bookings GROUP BY CarNumber ORDER BY COUNT(CarNumber) DESC
);

SELECT * FROM Customers WHERE CustomerNumber IN (SELECT CustomerNumber FROM Bookings) 
	and month(BirthDate) < 3;

-- Delete Update, Alter & Insert
SET SQL_SAFE_UPDATES = 0;
select * from Customers order by year(BirthDate);
select * from Customers where year(BirthDate) = 1800;
delete from Customers where year(BirthDate) = 1800;

update Cars set PricePerDay = PricePerDay + 200 where CarNumber = 5;
select * from Cars;

update Cars set PricePerDay = PricePerDay*1.20 where Brand = 'Peugeot';
update Cars set PricePerDay = PricePerDay*0.1;


-- View
drop view view_black_cars;
create view view_black_cars as select * from Cars where Color = 'black';
select * from view_black_cars;

drop view view_b;
create view view_b as select CarNumber, Brand, Model, Color, PricePerDay, PricePerDay*7 'PricePerWeek' from Cars;
select * from view_b;

insert into view_black_cars values (1, 'Peugeot', '206', 'Black', 70); -- Works
insert into view_b values (1, 'Peugeot', '208', 'Blue', 80, 540); -- Not works

select * from Bookings;

drop view currently_available;
create view currently_available as select * from Cars where CarNumber not in
	(select CarNumber from Bookings where EndDate > now());
select * from currently_available;

-- DROP
drop table Cars;

select * from Customers;
delete from Customers;





