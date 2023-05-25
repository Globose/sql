SET SQL_SAFE_UPDATES = 0;
USE dv1664;

DROP TRIGGER IF EXISTS trigger_orders;
DELIMITER //

CREATE TRIGGER trigger_orders
AFTER UPDATE on Orders FOR EACH ROW
BEGIN
	DECLARE customer_name VARCHAR(255);
	DECLARE customer_address VARCHAR(255);
        
	SELECT C.customerName INTO customer_name FROM Customer C 
		WHERE NEW.customerNumber = C.customerNumber;
        
	SELECT C.invoiceAddress INTO customer_address FROM Customer C
		WHERE NEW.customerNumber = C.customerNumber;
        
	UPDATE Orders SET message = concat(customer_name, ': Kul att du skickar godis till dig själv!')
		WHERE orderNumber = NEW.orderNumber AND NEW.recipientAddress = customer_address; 
END; //


DROP TRIGGER IF EXISTS trigger_orders;
DELIMITER //


DELETE FROM Orders WHERE orderNumber = 4;
INSERT INTO Orders VALUES(4, 700, "Kajsa Kavat", "Hemv 4", 123, 1, "Ha en bra dag!");
SELECT * FROM Orders O LEFT JOIN Customer C ON O.customerNumber = C.customerNumber;

