
DROP PROCEDURE IF EXISTS match_password;

DELIMITER //

-- Caller: guests or administrators
-- Senario: a guest or an administrator wants to login to the system
-- Function: Check if the input user id exists and the input password matches with the id, and distinguish if the user is a guest or an admin
-- Input: user_id, password
-- Output: whether the id and password matches, and whether the user is a guest
CREATE PROCEDURE match_password (
  IN user_id          BIGINT, 
  IN password         VARCHAR(100),
  OUT password_match  BOOLEAN
)
BEGIN
    SELECT CASE 
      WHEN COUNT(*) >= 1 THEN TRUE
      ELSE FALSE 
    END INTO password_match
    FROM People
    WHERE People.ID = user_id
    AND People.password = password;
END //

DELIMITER ;
