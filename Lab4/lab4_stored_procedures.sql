-- spSumAccount procedure
DROP PROCEDURE IF EXISTS spSumAccount;
DELIMITER //
CREATE PROCEDURE spSumAccount()
BEGIN
	DECLARE sumBalanceAccount INT;
    DECLARE sumAmountAccountLog INT DEFAULT 0;
    
	SELECT SUM(balanceAccount) INTO sumBalanceAccount FROM Account_;
	SELECT SUM(amountAccountLog) INTO sumAmountAccountLog FROM AccountLog;
    
    IF (sumAmountAccountLog IS NULL) THEN SET sumAmountAccountLog = 0;
    END IF;
    
    SELECT sumBalanceAccount, sumAmountAccountLog;
END; //
DELIMITER ;

CALL spSumAccount();


-- Stored procedure that will handle the withdrawal process of a customer
DROP PROCEDURE IF EXISTS spWithdraw;
DELIMITER //
CREATE PROCEDURE spWithdraw(accountNumber INT, amount DECIMAL)
BEGIN
	START TRANSACTION;
    UPDATE Account_ SET balanceAccount = balanceAccount - amount 
    WHERE nrAccount = accountNumber;
    
    IF (SELECT balanceAccount FROM Account_ WHERE nrAccount = accountNumber) < 0
    THEN ROLLBACK;
    
    ELSE COMMIT;
    END IF;
END; //
DELIMITER ;

CALL spWithdraw(5,20000);
