USE public;
SET SQL_SAFE_UPDATES = 1;

DROP TABLE members;
-- Count the rows in the tables
SHOW TABLES;
SELECT COUNT(*) FROM exped;
SELECT COUNT(*) FROM members;
SELECT COUNT(*) FROM peaks;

/* For each SELECT query you add SQL_NO_CACHE,
 also add EXPLAIN before every query */

-- PRIMARY KEY as index
EXPLAIN SELECT SQL_NO_CACHE * FROM members WHERE expid = 'EVER99107' AND leader = 1;
SELECT SQL_NO_CACHE * FROM members WHERE expid = 'EVER99107' AND leader = 1;

ALTER TABLE members ADD CONSTRAINT pk PRIMARY KEY (expid, membid, myear);


-- Foreign key as index
SELECT SQL_NO_CACHE * FROM exped AS E INNER JOIN peaks AS P
	ON E.peakid = P.peakid ORDER BY P.peakid LIMIT 10;

EXPLAIN SELECT SQL_NO_CACHE * FROM exped AS E INNER JOIN peaks AS P
	ON E.peakid = P.peakid ORDER BY P.peakid LIMIT 10;

-- Add primary key
ALTER TABLE peaks ADD CONSTRAINT pk PRIMARY KEY (peakid);

-- Add foreign key
ALTER TABLE exped ADD CONSTRAINT fk_peaks FOREIGN KEY (peakid)
	REFERENCES peaks (peakid);
    
SELECT SQL_NO_CACHE * FROM exped AS E INNER JOIN peaks AS P
	ON E.peakid = P.peakid ORDER BY P.peakid LIMIT 10;
    
/* It's way quicker with a foreign key */
