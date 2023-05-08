-- TEST FUNCTION
drop function func;
DELIMITER //
CREATE FUNCTION func ( val1 INT )
RETURNS INT
DETERMINISTIC
BEGIN
   DECLARE val2 INT;
   SET val2 = val1 + 1;
   RETURN val2;
END; //
DELIMITER ;

SELECT func (20000);

-- TEST
SET @te := 1;
SELECT 0 INTO @te FROM Cars WHERE CarNumber = 5 AND CarNumber IN (
		SELECT CarNumber FROM Bookings WHERE StartDate < ('2020-01-01') AND EndDate > ('2016-01-01')
    );
SELECT @te;

-- Testing UPDATE
INSERT INTO Cars VALUES (14, 'Ferrari', 'LaFerrari', 'Pink', 90000);
SELECT * FROM Cars;
UPDATE Cars SET Color = 'Red' WHERE CarNumber = 14;