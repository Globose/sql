SET SQL_SAFE_UPDATES = 0;

-- ISOLATION LEVEL
-- The default isolation level is REPEATABLE READ.
SELECT @@transaction_isolation; -- Checks current isolation level.
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;


-- Environment setup
UPDATE Account_ SET balanceAccount = 300 WHERE nameAccount = 'Anna';
UPDATE Account_ SET balanceAccount = 0 WHERE nameAccount = 'Ingvar';

CREATE VIEW vBalance AS 
	SELECT * FROM Account_ WHERE nameAccount = 'Anna' OR nameAccount = 'Ingvar';
SELECT * FROM vBalance;


-- Client 1
START TRANSACTION;
UPDATE Account_ SET balanceAccount = balanceAccount - 500 
	WHERE nameAccount = 'Anna';
UPDATE Account_ SET balanceAccount = balanceAccount + 500 
	WHERE nameAccount = 'Ingvar';
SELECT * FROM vBalance;

-- Anna can not go below 0, rollback
ROLLBACK;
SELECT * FROM vBalance;


-- Client 2
SELECT @@transaction_isolation; -- Checks current isolation level.
SET SESSION transaction_isolation = 'REPEATABLE-READ';
SELECT * FROM vBalance;

SET SESSION transaction_isolation = 'READ-UNCOMMITTED';
SELECT * FROM vBalance; -- Ingvar has 500 on his account

UPDATE Account_ SET balanceAccount = balanceAccount - 500
	WHERE nameAccount = 'Ingvar';

SELECT * FROM vBalance;

