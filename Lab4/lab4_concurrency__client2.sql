USE dv1664;

-- Dirty reads
SET SQL_SAFE_UPDATES = 0;

SELECT @@transaction_isolation; -- Checks current isolation level.
SET SESSION transaction_isolation = 'REPEATABLE-READ';
SELECT * FROM vBalance;

SET SESSION transaction_isolation = 'READ-UNCOMMITTED';
SELECT * FROM vBalance; -- Ingvar has 500 on his account

UPDATE Account_ SET balanceAccount = balanceAccount - 500
	WHERE nameAccount = 'Ingvar';



