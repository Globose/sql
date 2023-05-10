###########################################################1

CREATE TABLE Student 
(stNum VARCHAR(200) NOT NULL,
Fname VARCHAR(200) NOT NULL,
Lname VARCHAR(200) NOT NULL,
Age   INT NOT NULL,
Telephone VARCHAR(200),
Email VARCHAR(200) NOT NULL,
Address TEXT NOT NULL,
PRIMARY KEY (stNum)
);

CREATE TABLE Book (
ISBN VARCHAR(200) NOT NULL,
Title VARCHAR(200) NOT NULL,
Author VARCHAR(200) NOT NULL,
shelfNum VARCHAR(10) NOT NULL,
numOfCopies INT,
PRIMARY KEY (ISBN)
);

CREATE TABLE BookLease(
leaseNumber INT AUTO_INCREMENT NOT NULL,
ISBN VARCHAR(200),
stNum VARCHAR(200),
startDate DATE,
leaseInDays INT,
dateReturned DATE,
PRIMARY KEY (leaseNumber),
FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
FOREIGN KEY (stNum) REFERENCES Student(stNum)
);

###########################################################Q2
SELECT S.stNum, S.Fname, S.Lname, count(B.leaseNumber) AS num FROM booklease B RIGHt JOIN student S ON B.stNum = S.stNum
GROUP BY S.stNum
HAVING num = 0;
    #lars 3 anna 2 maria 3 anders 2 mikael 0

###########################################################Q3
SELECT L.ISBN, B.Title, AVG(DATEDIFF(L.dateReturned,L.startDate)) AS AverageBorrowTime FROM booklease L, book B WHERE L.ISBN = B.ISBN AND L.dateReturned IS NOT NULL
GROUP BY B.ISBN;
# F-0055-G has 2 leases with dateReturned, so 40 days/2 (average) = 20

###########################################################Q4

DROP VIEW IF EXISTS myView;

DELIMITER //
CREATE VIEW myView
AS
SELECT L.ISBN, B.Title, S.Fname, S.Lname, ADDDATE(L.startDate, L.leaseInDays) AS ExpectedDate FROM booklease L, book B, student S
WHERE L.ISBN = B.ISBN AND L.stNum = S.stNum AND L.dateReturned IS NULL; //

SELECT * from myView;

#OBS! Another option to calculate the ExpectedDate ==> DATE_ADD (L.startDate, INTERVAL L.leaseInDays DAY) AS ExpectedDate


###########################################################Q5

DROP TRIGGER IF EXISTS increase;

DELIMITER //

CREATE TRIGGER increase 
AFTER UPDATE on booklease FOR EACH ROW
BEGIN
IF OLD.dateReturned IS NULL AND NEW.dateReturned IS NOT NULL THEN
UPDATE book b SET b.numOfCopies = b.numOfCopies+1 WHERE b.ISBN = NEW.ISBN;
END IF;

END; //

SELECT * FROM booklease;
SELECT * FROM book;

UPDATE booklease SET dateReturned = CURRENT_DATE WHERE leaseNumber = 6;

###########################################################Q6

DROP procedure IF EXISTS CheckProc;

DELIMITER //

CREATE procedure CheckProc (IN RleaseNumber INT, IN RISBN VARCHAR(200),IN RstNum VARCHAR(200),IN RstartDate DATE,IN RleaseInDays INT ,IN RdateReturned DATE, OUT str TEXT) 
BEGIN
DECLARE flag INT;
SET flag = 0, str = '';

SELECT numOfCopies into flag FROM book b WHERE b.ISBN = RISBN;

if flag >=1 THEN
INSERT INTO booklease VALUES (RleaseNumber, RISBN, RstNum, RstartDate, RleaseInDays, RdateReturned);
UPDATE book b SET b.numOfCopies = b.numOfCopies-1 WHERE b.ISBN = RISBN;
SET str = 'Row Inserted';
ELSE
SET str = 'Row NOT inserted! No copies available.';
END IF;
SELECT str;
END; //

SELECT * FROM booklease;
SELECT * FROM book;

CALL CheckProc (11, 'F-0055-G', 'W6T5WZG', '2021-11-03', 10, NULL, @str); #Must proceed numberOfCopies 4
displays: 'Row Inserted'
CALL CheckProc (12, 'F-0055-G', 'W6T5WZG', '2021-11-03', 10, NULL, @str); #Must proceed numberOfCopies 3
displays: 'Row Inserted'
CALL CheckProc (13, 'F-0055-G', 'W6T5WZG', '2021-11-03', 10, NULL, @str); #Must proceed numberOfCopies 2
displays: 'Row Inserted'
CALL CheckProc (14, 'F-0055-G', 'W6T5WZG', '2021-11-03', 10, NULL, @str); #Must proceed numberOfCopies 1
displays: 'Row Inserted'
CALL CheckProc (15, 'F-0055-G', 'W6T5WZG', '2021-11-03', 10, NULL, @str); #Must not proceed numberOfCopies 0
displays: 'Row NOT inserted! No copies available.'



###########################################################Q7


SELECT S.stNum, CONCAT(S.Fname,' ', S.Lname) AS name_ , L.leaseNumber, L.ISBN
FROM student S 
LEFT JOIN booklease L ON S.stNum = L.stNum
ORDER BY L.leaseNumber DESC;


###########################################################Q8

SELECT CONCAT(S.Fname,' ', S.Lname) AS studentName, B.Title, adddate(L.startDate, L.LeaseInDays) as ExpectedReturnDate
FROM booklease L
LEFT JOIN student S  ON S.stNum = L.stNum
LEFT JOIN book B  ON B.ISBN = L.ISBN
WHERE L.dateReturned IS NULL;


###########################################################Q9
DROP FUNCTION IF EXISTS myTask;

DELIMITER //
CREATE FUNCTION myTask (RleaseNumber INT) RETURNS INT DETERMINISTIC
BEGIN
DECLARE num INT;
DECLARE numOfDays INT;

SELECT (DATEDIFF(B.dateReturned, B.startDate) - B.leaseInDays) INTO numOfDays FROM booklease B WHERE B.leaseNumber = RleaseNumber;

IF (numOfDays IS NULL OR numOfDays < 0) THEN
SET numOfDays = 0;
END IF;

RETURN numOfDays;
END //

SELECT B.leaseNumber, B.ISBN, S.Fname, S.Lname, myTask(B.leaseNumber) AS numOfOverdueDays, myTask(B.leaseNumber)*12.5 AS totalAmount FROM booklease B JOIN student S ON B.stNum = S.stNum
WHERE myTask(B.leaseNumber)>0;


###########################################################Q10
DROP FUNCTION IF EXISTS myTask;

DELIMITER //
CREATE FUNCTION myTask (RISBN VARCHAR(200)) RETURNS INT DETERMINISTIC
BEGIN
DECLARE num INT;

SELECT COUNT(B.leaseNumber) INTO num FROM booklease B WHERE B.ISBN = RISBN;


RETURN num;
END //

SELECT B.ISBN, B.Title, myTask(L.ISBN) AS numOfTimes FROM booklease L RIGHT JOIN book B ON L.ISBN = B.ISBN
GROUP BY B.ISBN
ORDER BY numOfTimes DESC;
