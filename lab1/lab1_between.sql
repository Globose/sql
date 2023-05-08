-- BETWEEN
-- Show all cars whose price is in the range 600 - 1000.
SELECT * FROM Cars WHERE PricePerDay BETWEEN 600 AND 1000;

-- Show all the customers who are born between 1960 - 1980.
SELECT * FROM Customers WHERE YEAR(BirthDate) BETWEEN 1960 AND 1980;

-- Show all bookings that last between 2 - 4 days.
SELECT * FROM Bookings WHERE DATEDIFF(EndDate,StartDate) < 4 
AND DATEDIFF(EndDate,StartDate) > 0;


-- A mix of everything
-- Show all the cars that are eligible for booking between 2018-01-10 - 2018-01-20.
SELECT * FROM Cars WHERE CarNumber NOT IN (
	SELECT CarNumber FROM Bookings WHERE StartDate < '2018-01-20' AND EndDate > '2018-01-10'
);

-- Show the car that has been booked the most.
SELECT * FROM Cars WHERE CarNumber IN (
	SELECT CarNumber FROM Bookings GROUP BY CarNumber ORDER BY COUNT(CarNumber) DESC
) LIMIT 1;


-- Show all the customers who are born in January or February and has booked at least one car.
SELECT * FROM Customers WHERE CustomerNumber IN (SELECT CustomerNumber FROM Bookings) 
AND MONTH(BirthDate) BETWEEN 1 AND 2;
