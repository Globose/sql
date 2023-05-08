use dv1664;

-- STORED PROCEDURES
-- 1. Create a stored procedure that collects all the cars that are available between two dates. 
-- The inputs to the procedure is starting and ending dates, and prints all the car numbers 
-- that are available to be booked between the two dates.

DROP PROCEDURE GetCarsAvailable;
DELIMITER //
CREATE PROCEDURE GetCarsAvailable(IN start_date DATE, IN end_date DATE)
BEGIN
	SELECT * FROM Cars WHERE CarNumber NOT IN (
		SELECT CarNumber FROM Bookings WHERE StartDate <= end_date AND EndDate >= start_date
        );
END; //
DELIMITER ;

CALL GetCarsAvailable('2018-02-22','2018-02-26');


-- 2. Create a stored procedure that handles the booking of renting a car. The input 
-- to the procedure is the starting and ending dates, the cars number,  and the customer 
-- number. If it is successful it should return 0, if it is unsuccessful in booking it should return 1.

DROP PROCEDURE BookCar;
DELIMITER //
CREATE PROCEDURE BookCar(IN start_date DATE, IN end_date DATE, IN car_number INT, IN customer_number INT, OUT result INT)
BEGIN
	DECLARE count_bookings INT;
    SET count_bookings = (
		SELECT COUNT(*) FROM Bookings WHERE car_number = CarNumber
        AND StartDate <= end_date AND EndDate >= start_date
    );
    
    IF count_bookings != 0 OR customer_number NOT IN (SELECT CustomerNumber FROM Customers)
		OR start_date > end_date THEN SET result := 1;
    ELSE 
		INSERT INTO Bookings VALUES (customer_number, car_number, start_date, end_date);
        SET RESULT := 0;
    END IF;
    
END; //
DELIMITER ;

CALL BookCar('2020-02-22','2020-02-26', 10, 6, @result);
SELECT @result;
SELECT * FROM Bookings;
SELECT * FROM Customers;




