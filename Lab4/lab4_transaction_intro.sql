-- Start a transaction. Withdraw 300 from Nils' account. 
-- Rollback the transaction
START TRANSACTION;
UPDATE Account_ SET balanceAccount = balanceAccount - 300 WHERE nrAccount = 1;
ROLLBACK;

-- Do the same thing again but do a commit instead of a rollback
START TRANSACTION;
UPDATE Account_ SET balanceAccount = balanceAccount - 300 WHERE nrAccount = 1;
COMMIT;
