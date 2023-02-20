-- Caller: guests or administrators
-- Senario: a guest or an administrator wants to login to the system
-- Function: Check if the input user id exists and the input password matches with the id, and distinguish if the user is a guest or an admin
-- Input: user_id, password
-- Output: whether the id and password matches, and whether the user is a guest
CREATE PROCEDURE match_password (
  IN user_id    BIGINT, 
  IN password   VARCHAR(100),
  OUT match     BOOLEAN,
  OUT is_guest  BOOLEAN
)
  BEGIN
    SELECT CASE 
      WHEN COUNT(*) = 1 THEN CASE
        WHEN People.password = password THEN TRUE
        ELSE FALSE
      END
      ELSE FALSE 
    END INTO match,
    CASE
      WHEN COUNT(*) = 1 THEN People.is_guest
      ELSE FALSE 
    END INTO is_guest
    FROM People
    WHERE People.ID = user_id;
  END
