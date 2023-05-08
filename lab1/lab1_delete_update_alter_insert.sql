-- Delete Update, Alter & Insert

-- Necessary to do certain operations, eg. update table withour a where that uses a KEY column
SET SQL_SAFE_UPDATES = 0;


-- There is a customer born in 1800 according to the records, this is obviously not possible so delete that customer.
DELETE FROM Customers WHERE YEAR(BirthDate) = 1800; 

SELECT * FROM Customers ORDER BY YEAR(BirthDate);
DELETE FROM Customers WHERE CustomerNumber=20 AND YEAR(BirthDate)=1800;


-- The Tesla X car that is available for renting needs to have its price increased by 200:-.
SELECT * FROM Cars WHERE Brand = 'Tesla';
UPDATE Cars SET PricePerDay = PricePerDay + 200 WHERE CarNumber = 5;


-- All the Peugeot cars also needs to be increased in price, in this case by 20%.
UPDATE Cars SET PricePerDay = PricePerDay*1.20 WHERE Brand = 'Peugeot';


-- Now we fast forward into the future and Sweden has changed its currency to Euros (€). 
-- Fix both the data itself (assume the conversion rate is 10SEK == 1 EUR) and the table 
-- so it can handle the new prices.
UPDATE Cars SET PricePerDay = PricePerDay*0.1;


-- Can we construct a PK in the Bookings table without adding a new column? 
-- If yes, do that. If not, add another column that allows you to uniquely identify each booking.
ALTER TABLE Bookings ADD PRIMARY KEY (CustomerNumber, CarNumber, StartDate);
