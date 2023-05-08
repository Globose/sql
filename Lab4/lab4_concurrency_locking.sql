-- Concurrency and locking (1) SELECT
-- CLIENT 1
START TRANSACTION; 
UPDATE Account_ SET balanceAccount = balanceAccount - 3000
WHERE nrAccount = 1;
SELECT * FROM Account_;
ROLLBACK;

SELECT * FROM Account_;

-- CLIENT 2
SELECT * FROM Account_;


-- Concurrency and locking (2) UPDATE
-- CLIENT 1
START TRANSACTION;
UPDATE Account_ SET balanceAccount = balanceAccount - 3000
WHERE nrAccount = 1;
SELECT * FROM Account_;

COMMIT;
SELECT * FROM Account_;

-- CLIENT 2
UPDATE Account_ SET balanceAccount = balanceAccount - 3000 WHERE nrAccount = 1;
SELECT * FROM Account_;

-- Client 1 locks the Account_ table, when UPDATE is called in 
-- Client 2, it has to wait for the TRANSACTION of Client 1 to finish.
-- When COMMIT is executed, the UPDATE in Client 2 can run.
