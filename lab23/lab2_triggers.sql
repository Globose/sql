USE dv1664;

-- TRIGGERS
-- 1. Add an additional column to Customers that contains the amount of times a customer 
-- has booked a car. Then create an after insert trigger on the Bookings table that 
-- increments the newly created column in Customers whenever they do a successful booking of a car.

ALTER TABLE Customers ADD NumberOfBookings INT DEFAULT 0;
SELECT * FROM Customers;

DROP TRIGGER IF EXISTS trigger_customers;
DELIMITER //
CREATE TRIGGER trigger_customers
AFTER INSERT ON Bookings
FOR EACH ROW
	BEGIN
        UPDATE Customers SET NumberOfBookings = NumberOfBookings + 1 WHERE CustomerNumber = NEW.CustomerNumber;
    END; //
DELIMITER ;

INSERT INTO Bookings VALUES (2,5,'2022-05-01','2022-05-05');

-- Would it be possible to do this trigger with a BEFORE trigger? Why/Why not? yes

