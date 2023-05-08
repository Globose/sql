-- DROP
SET SQL_SAFE_UPDATES = 0;

-- Drop the table Cars.
DROP TABLE Cars;

-- Why didn't it work? Fix so that you can drop the table.
-- It did work

-- Delete all the rows of table Customers.
DELETE FROM Customers; -- SQL_SAFE_UPDATES has to be 0.

-- Alternatively
TRUNCATE TABLE Customers;


-- What's the difference between DROP TABLE and DELETE?
-- DROP TABLE removes the entire TABLE from a database while
-- DELETE only removes rows from a table.






