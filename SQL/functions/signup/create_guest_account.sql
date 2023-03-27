
DROP PROCEDURE IF EXISTS create_guest_account;

-- Caller: guests
-- Senario: a new guest wants to creat an account
-- Function: insert a new record into People table and Guest table with the input guest info, where the new guest account is not activated
-- Input: new guest's information: username, password, and email address
-- Output: new guest's id
DELIMITER //
CREATE PROCEDURE create_guest_account (
  IN username       VARCHAR(100),
  IN password       VARCHAR(100),
  IN email_address  VARCHAR(100),
  OUT user_ID       BIGINT
)
BEGIN
  IF (
    SELECT COUNT(*) 
    FROM People 
    WHERE People.username = username
  ) THEN 
    SELECT -1 INTO user_ID; -- the given username already exists in the database
  ELSE 
    SET @default_credit_level = 5;
    SET @new_user_id = (
      SELECT MAX(People.ID) + 1
      FROM People
    );
    INSERT INTO People
      VALUES (@new_user_id, username, password, email_address, TRUE);
    INSERT INTO Guest
      VALUES (@new_user_id, FALSE, @default_credit_level, @default_credit_level, DEFAULT);
    SELECT @new_user_id INTO user_ID;
  END IF;
END //
DELIMITER ; 
