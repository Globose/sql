-- 1. USER DEFINED FUNCTIONS
-- 1. Create a function that checks if a car is available for renting between two dates.
-- The input to the function should be the starting and ending dates of the rental,
-- the cars number, and it should return 0 if it is not available and 1 if it is available between the two dates.
DROP FUNCTION IF EXISTS available_for_renting;
DELIMITER //
CREATE FUNCTION available_for_renting (car_num INT, date_start DATE, date_end DATE) RETURNS INT
READS SQL DATA
BEGIN
	DECLARE count_bookings INT;
    SET count_bookings = (
		SELECT COUNT(*) FROM Bookings 
        WHERE car_num = CarNumber
        AND StartDate <= date_end AND EndDate >= date_start
    );
    
    IF count_bookings > 0 THEN RETURN 0;
    ELSE RETURN 1;
    END IF;
END; //
DELIMITER ;

SELECT available_for_renting(13,'2018-01-01', '2018-01-19');


-- 2. Create a function that sums the total amount of days cars have been booked and returns the sum.
DROP FUNCTION IF EXISTS sum_booked_days;
DELIMITER //
CREATE FUNCTION sum_booked_days()
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE var_sum INT;
	SELECT SUM(DATEDIFF(EndDate,StartDate)+1) INTO var_sum FROM Bookings;
	RETURN var_sum;
END; //
DELIMITER ;

SELECT sum_booked_days();


-- 3. Extend the previous function so that if there is an input parameter that matches a 
-- cars unique number, then it should only return the sum of the car. If the number 
-- doesn't match or it is -1, it returns the total sum as before
DROP FUNCTION sum_booked_days_num;
DELIMITER //
CREATE FUNCTION sum_booked_days_num(car_num INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE var_sum INT DEFAULT sum_booked_days();
    IF (car_num IN (SELECT CarNumber FROM Cars)) THEN
		SELECT SUM(DATEDIFF(EndDate,StartDate)+1) INTO var_sum FROM Bookings WHERE CarNumber = car_num;
	END IF;
	IF (var_sum IS NULL) THEN 
		SELECT 0 INTO var_sum;
	END IF;
	RETURN var_sum;
END; //
DELIMITER ;

SELECT sum_booked_days_num(1);

