-- View
-- Create a view, that shows all the information about black cars.
DROP VIEW IF EXISTS view_black_cars;
CREATE VIEW view_black_cars AS SELECT * FROM Cars WHERE Color = 'Black';
SELECT * FROM view_black_cars;


-- Create a view that shows all information about black cars and the addition of the weekly price as a column.
DROP VIEW IF EXISTS view_black_cars_info;
CREATE VIEW view_black_cars_info AS SELECT Cars.*, PricePerDay*7 AS 'PricePerWeek' FROM Cars;
SELECT * FROM view_black_cars_info;


-- Try and insert a car into both views created. What happens? Why? What's the difference between the views?
INSERT INTO view_black_cars VALUES (99, 'Ferrari', 'LaFerrari', 'Red', 700); -- Works
INSERT INTO view_black_cars_info VALUES (98, 'Peugeot', '308', 'Green', 50, 350); -- Does not work

-- A view is a virtual table. An added column doesn't exist in any table in the database.
-- When you insert into view_black_cars MySQL knows which table that has to get updated
-- But when you try insert into view_black_cars_info, there is no table that can store
-- the information about weekly price.


-- Create a view that shows all the cars available for booking at this current time.
DROP VIEW IF EXISTS currently_available;
CREATE VIEW currently_available AS SELECT * FROM Cars WHERE CarNumber NOT IN
	(SELECT CarNumber FROM Bookings WHERE EndDate > NOW() AND StartDate < NOW());
SELECT * FROM currently_available;

-- Alter the previous view, with the condition that the cars have to be available for at least 3 days of renting.
DROP VIEW IF EXISTS currently_available_3;
CREATE VIEW currently_available_3 AS SELECT * FROM Cars WHERE CarNumber NOT IN
	(SELECT CarNumber FROM Bookings WHERE EndDate > NOW() 
    AND StartDate < DATE_ADD(NOW(), INTERVAL 2 DAY));
SELECT * FROM currently_available_3;

