-- SELECTION, PROJECTION and RESTRICTION

-- Show all customers with all their information.
SELECT * FROM Customers;

-- Show all customers, but only with their name and birthdate.
SELECT CustomerName, Birthdate FROM Customers;

-- Show all cars that cost more than 1000:- per day.
SELECT * FROM Cars WHERE PricePerDay > 1000;

-- Show all Volvo cars, only with their brand name and their model.
SELECT Brand, Model FROM Cars WHERE Brand = 'Volvo';

-- Show all customers, only with their names, in a sorted fashion based on their name. 
-- Both in ascending and descending order.
SELECT CustomerName FROM Customers ORDER BY CustomerName ASC;
SELECT CustomerName FROM Customers ORDER BY CustomerName DESC;

-- Show all customers, only with their names, that were born in 1990 or later 
-- in a sorted fashion based on their birthdate.
SELECT CustomerName FROM Customers WHERE YEAR(BirthDate) >= 1990 ORDER BY BirthDate;

-- Show all cars that are red and cost less than 1500.
SELECT * FROM Cars WHERE Color = 'Red' AND PricePerDay < 1500;

-- Show all customers, only with their names, that were born between 1970-1990.
SELECT CustomerName FROM Customers WHERE YEAR(BirthDate) BETWEEN 1970 AND 1990;

-- Show all bookings that are longer than 6 days.
SELECT * FROM Bookings WHERE DATEDIFF(EndDate,StartDate) > 5;

-- Show all bookings that overlap with the interval 2018-02-01 - 2018-02-25.
SELECT * FROM Bookings WHERE StartDate < '2018-02-25' AND EndDate > '2018-02-01';

-- Show all customers whose first name starts with an O.
SELECT * FROM Customers WHERE CustomerName LIKE 'O%';

