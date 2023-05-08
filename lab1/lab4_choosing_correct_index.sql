-- Choosing the correct index
SELECT SQL_NO_CACHE expid, mseason, fname, lname, pkname 
	FROM members INNER JOIN peaks 
    ON members.peakid = peaks.peakid
    WHERE sex = 'F' AND mseason = '1' AND peaks.peakid = 'EVER' 
    ORDER BY lname;

-- Remove previously created foreign and primary keys
ALTER TABLE exped DROP FOREIGN KEY fk_peaks;
ALTER TABLE exped DROP INDEX fk_peaks;
ALTER TABLE peaks DROP PRIMARY KEY;
ALTER TABLE members DROP PRIMARY KEY;





