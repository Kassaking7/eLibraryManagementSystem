-- Caller: guests
-- Senario: a new guest wants to creat an account
-- Function: insert a new record into People table and Guest table with the input guest info, where the new guest account is not activated
-- Input: new guest's information: username, password, and email address
-- Output: new guest's id
CREATE PROCEDURE create_guest_account (
  IN username       VARCHAR(100),
  IN password       VARCHAR(100),
  IN email_address  VARCHAR(100),
  OUT user_ID       BIGINT
)
  BEGIN
    @user_count := @user_count + 1
    INSERT INTO People
      VALUE(@user_count, username, password, email_address, TRUE);
    INSERT INTO Guest
      VALUE(@user_count, FALSE, @default_credit_level, @default_credit_level, DEFAULT);
    SELECT @user_count INTO user_ID
  END