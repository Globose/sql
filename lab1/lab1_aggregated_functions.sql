-- AGGREGATED FUNCTIONS
-- Show the average price per day for the cars.
SELECT AVG(PricePerDay) AS 'Average Price' FROM Cars;

-- Show the total price per day for the cars.
SELECT SUM(PricePerDay) AS 'Total Price' FROM Cars;

-- Show the average price for red cars.
SELECT AVG(PricePerDay) AS 'Average Red Car Price' FROM Cars WHERE Color = 'Red';

-- Show the total price for all cars grouped by the different colors.
SELECT Color, AVG(PricePerDay) FROM Cars GROUP BY Color;

-- Show how many cars are of red color.
SELECT COUNT(*) AS 'Red Cars Count' FROM Cars WHERE Color = 'Red';

-- Show how many cars exists of each color.
SELECT Color, COUNT(Color) AS 'Number of cars' FROM Cars GROUP BY Color;

-- Show the car that is the most expensive to rent. (Do not hard code this 
-- with the most expensive price, instead use ORDER and LIMIT.)
SELECT * FROM Cars ORDER BY PricePerDay DESC LIMIT 1;
