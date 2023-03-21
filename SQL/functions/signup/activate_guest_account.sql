
DROP PROCEDURE IF EXISTS activate_guest_account;

-- Caller: administrators
-- Senario: a guest just created an account, and the new guest went to the front desk and paid the deposit fee
-- Function: activate the new guest's account
-- Input: guest_ID
-- Output: None
DELIMITER //
CREATE PROCEDURE activate_guest_account (
  IN guest_ID     BIGINT
)

BEGIN
	UPDATE Guest
	SET Guest.is_activated = TRUE
	WHERE Guest.ID = guest_ID;
END //
DELIMITER ;
