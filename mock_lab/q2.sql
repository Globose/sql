USE dv1664;

SET SQL_SAFE_UPDATES = 0;


-- task 2
/*Write an SQL statement that shows info about students who 
have not borrowed any book. Table should have the following 
columns: stNum | Fname | Lname | numOfLeases. */

SELECT stNum, Fname, Lname, 0 AS numOfLeases FROM Student 
	WHERE stNum NOT IN (SELECT stNum FROM BookLease);


-- task 3
/*Write an SQL statement that shows each Book and its average lease time 
(the actual days, not the planned ones), only count leases that are completed 
(dateReturned is available). The result table should show the following columns: 
the ISBN, Title, and the average rental days as “AverageBorrowTime”. */

SELECT b.ISBN, b.Title, AVG(DATEDIFF(bl.dateReturned, bl.startDate)) AS 'AverageBorrowTime' 
FROM Book b LEFT JOIN BookLease bl ON b.ISBN = bl.ISBN GROUP BY b.ISBN;


-- task 4
/* Create a view that shows which Books are currently rented (dateReturned is null), 
with the columns ISBN, Title, Fname, Lname, and expected return date (e.g., startDate 
plus leaseInDays) as “ExpectedDate”. */

CREATE VIEW currently_rented AS 
	SELECT DISTINCT b.ISBN, b.Title, s.Fname, s.Lname, 
		DATE_ADD(bl.startDate, INTERVAL bl.leaseInDays DAY) AS 'ExpectedDate' 
FROM Book b JOIN BookLease bl ON b.ISBN = bl.ISBN JOIN Student s ON s.stNum = bl.stNum WHERE dateReturned IS NULL;


-- task 5
/* Create a trigger on the BookLease table which, when a lease is returned 
(when null is changed to date in returnDate), increases the respective Book's number of copies by 1. */

DROP TRIGGER IF EXISTS trigger_booklease;
DELIMITER //
CREATE TRIGGER trigger_booklease
AFTER UPDATE ON BookLease
FOR EACH ROW
	BEGIN
		IF OLD.dateReturned IS NULL AND NEW.dateReturned IS NOT NULL
			THEN UPDATE Book SET numOfCopies = numOfCopies + 1 WHERE ISBN = NEW.ISBN;
		END IF;
    END; //
DELIMITER ;


-- task 6
/* Create a procedure that handles a lease of a book. Checks must be made so that the book’s 
number of copies is not equal to zero. If no copy is available of the book (numOfCopies = 0) 
the lease must not go through (aborted). The procedure must check if the book is still 
available and do the following actions:

if available, it inserts the new row into the BookLease table, it decrements the numOfCopies 
in the Book table, and it displays the message “Row inserted”.
Else, nothing will happen except getting the message: “Row NOT inserted! No copies available.” */

DROP PROCEDURE BookBook;
DELIMITER //
CREATE PROCEDURE BookBook(bISBN VARCHAR(255), sNum VARCHAR(255))
BEGIN
	IF (SELECT numOfCopies FROM Book WHERE ISBN = bISBN) = 0
		THEN SELECT 'Row NOT inserted! No copies available' AS 'Error message';
    ELSE 
		INSERT INTO BookLease(ISBN,stNum,startDate,leaseInDays,dateReturned) VALUES(bISBN, sNum, DATE(NOW()), 30, NULL);
        UPDATE Book SET numOfCopies = numOfCopies -1 WHERE ISBN = bISBN;
        SELECT 'Row inserted';
    END IF;
    
END; //
DELIMITER ;


-- Task 7
/* Write an SQL statement that shows all students, each lease the student has made, 
and which books they have borrowed. If a student has not made any lease, s/he must 
still appear in the results. The result table should show the following columns: 
stNum | combine FName and LName as name_ | leaseNumber | ISBN. Display leaseNumber 
in descending order. */

SELECT s.stNum, CONCAT(s.Fname,' ', s.Lname) AS name_, b.leaseNumber, b.ISBN FROM Student s 
	LEFT JOIN BookLease b ON s.stNum = b.stNum ORDER BY b.leaseNumber DESC;


-- Task 8
/* Write an SQL statement that displays the students who are still borrowing a 
book. The result table should show the following columns: studentName (concatenate 
with a space: Fname and Lname), Title and ExpectedReturnDate. */

SELECT CONCAT(s.Fname,' ', s.Lname) AS studentName, b.Title,
		DATE_ADD(bl.startDate, INTERVAL bl.leaseInDays DAY) AS 'ExpectedReturnDate' 
	FROM Student s RIGHT JOIN BookLease bl ON s.stNum = bl.stNum 
    LEFT JOIN Book b ON b.ISBN = bl.ISBN WHERE bl.dateReturned IS NULL;
