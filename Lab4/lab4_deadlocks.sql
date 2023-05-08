USE dv1664;

-- DEADLOCKS
-- SETUP
SET SQL_SAFE_UPDATES = 0;
UPDATE Account_ SET balanceAccount = 100 WHERE nameAccount = 'Anna';


-- Client 1
SET SESSION transaction_isolation = 'SERIALIZABLE';

START TRANSACTION;
SELECT * FROM Account_ WHERE nameAccount = 'Anna';

-- Reset the balance on account Anna
UPDATE Account_ SET balanceAccount = 0 WHERE nameAccount = 'Anna';
-- Deadlock acquired and detected?

SELECT * FROM Account_ WHERE nameAccount = 'Anna';

ROLLBACK;


-- Client 2
SET SESSION transaction_isolation = 'SERIALIZABLE';

START TRANSACTION;
-- Reset the balance on account Anna
UPDATE Account_ SET balanceAccount = 0 WHERE nameAccount = 'Anna';
-- If lock proceed.

SELECT * FROM Account_ WHERE nameAccount = 'Anna';
ROLLBACK;
