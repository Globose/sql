-- JOINS
-- Show the Cartesian product between Cars and Bookings.
SELECT * FROM Cars CROSS JOIN Bookings;


-- Show the Cartesian product between Customers and Bookings.
SELECT * FROM Customers CROSS JOIN Bookings;


-- Show the results of converting the previous two joins to inner joins.
SELECT * FROM Cars INNER JOIN Bookings ON Cars.CarNumber=Bookings.CarNumber;


-- Show the names of all the customers that has made a booking.
SELECT CustomerName FROM Customers INNER JOIN Bookings 
ON Customers.CustomerNumber=Bookings.CustomerNumber;


-- Same as the previous but without all the duplicates.
SELECT DISTINCT CustomerName FROM Customers INNER JOIN Bookings 
ON Customers.CustomerNumber=Bookings.CustomerNumber;


-- Show all the Volkswagen cars that has been booked at least once.
SELECT DISTINCT Cars.* FROM Cars INNER JOIN Bookings 
ON Cars.CarNumber=Bookings.CarNumber WHERE Brand='Volkswagen';


-- Show all the customers that has rented a Volkswagen.
SELECT DISTINCT Customers.* FROM Customers
INNER JOIN Bookings ON Customers.CustomerNumber=Bookings.CustomerNumber
INNER JOIN Cars ON Bookings.CarNumber=Cars.CarNumber WHERE Brand='Volkswagen';

-- Alternatively
SELECT * FROM Customers WHERE CustomerNumber IN (
	SELECT CustomerNumber FROM Bookings WHERE CarNumber IN (
		SELECT CarNumber FROM Cars WHERE Brand='Volkswagen'
    )
);


-- Show all cars that has been booked at least once.
SELECT DISTINCT Cars.* FROM Cars INNER JOIN Bookings
ON Cars.CarNumber = Bookings.CarNumber ORDER BY CarNumber;

-- Alternatively
SELECT * FROM Cars WHERE CarNumber IN (SELECT CarNumber FROM Bookings);


-- Show all cars that has never been booked.
SELECT DISTINCT Cars.* FROM Cars LEFT JOIN Bookings
ON Cars.CarNumber = Bookings.CarNumber WHERE Bookings.CarNumber IS NULL;

-- Alternatively
SELECT * FROM Cars WHERE CarNumber NOT IN (SELECT CarNumber FROM Bookings);


-- Show all the black cars that has been booked at least once.
SELECT DISTINCT Cars.* FROM Cars INNER JOIN Bookings 
ON Cars.CarNumber = Bookings.CarNumber WHERE Color = 'Black';

-- Alternatively
SELECT * FROM Cars WHERE Color='Black' AND CarNumber IN (SELECT CarNumber FROM Bookings);




