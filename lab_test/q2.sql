USE dv1664;

-- Uppgift 2
SELECT C.customerNumber, A.candyName, A.pricePerGram, O.message FROM Customer C RIGHT JOIN Orders O ON C.customerNumber = O.customerNumber 
	LEFT JOIN Candy A ON O.candyNumber = A.candyNumber;


-- Uppgift 3
SELECT A.candyName, A.pricePerGram, A.gelatinfri, SUM(weight) AS totalSåld 
FROM Candy A LEFT JOIN Orders O ON A.candyNumber = O.candyNumber GROUP BY A.candyName;



-- Uppgift 4
DROP VIEW IF EXISTS customer_order_info;
CREATE VIEW customer_order_info AS SELECT C.customerName, C.invoiceAddress, 
Count(O.orderNumber) AS antaletOrdrar, SUM(O.weight) AS totaltKöp
FROM Customer C LEFT JOIN Orders O ON C.customerNumber = O.customerNumber GROUP BY C.customerNumber;


-- Uppgift 5
DROP TRIGGER IF EXISTS trigger_order;
DELIMITER //
CREATE TRIGGER trigger_orders
AFTER INSERT ON Orders
FOR EACH ROW
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
DELIMITER ;

DELETE FROM Orders WHERE orderNumber = 4;
INSERT INTO Orders VALUES(4, 700, "Andreas", "Stora vägen 4", 123, 3, "Ha en bra dag!");
SELECT * FROM Orders;

-- Uppgift 6
-- Function returns the average spending for a customer based on customernumber
DROP FUNCTION IF EXISTS average_spending;
DELIMITER //
CREATE FUNCTION average_spending (customer_number INT) 
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
	DECLARE avg_spending INT;
    DECLARE customer_name VARCHAR(255);
    
    SELECT customerName INTO customer_name FROM Customer WHERE customerNumber = customer_number;
    
	SELECT SUM(O.weight*A.pricePerGram)/Count(O.customerNumber) INTO avg_spending 
	FROM Customer C JOIN Orders O ON C.customerNumber = O.customerNumber
	JOIN Candy A ON O.candyNumber = A.candyNumber WHERE C.customerNumber = customer_number;
    
    IF (avg_spending IS NULL) THEN SET avg_spending = 0;
    END IF;
    
    RETURN concat(customer_name, ' ', avg_spending);
END; //
DELIMITER ;



-- Uppgift 7
SELECT O.orderNumber, C.customerNumber, C.customerName, A.candyNumber, A.candyName 
FROM Customer C LEFT JOIN Orders O ON C.customerNumber = O.customerNumber 
LEFT JOIN Candy A ON O.candyNumber = A.candyNumber;


-- Uppgift 8
SELECT A.candyName, SUM(O.weight) AS totalVikt FROM Candy A LEFT JOIN Orders O ON A.candyNumber = O.candyNumber 
GROUP BY A.candyNumber ORDER BY COUNT(O.candyNumber) DESC LIMIT 1;



