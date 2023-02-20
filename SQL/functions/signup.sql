SET @default_credit_level = 5;
SET @user_count = 100;

-- Caller: guests
-- Senario: a new guest wants to creat an account
-- Function: insert a new record into People table and Guest table with the input guest info, where the new guest account is not activated
-- Input: new guest's information: username, password, and email address
-- Output: None
CREATE PROCEDURE create_guest_account (
  IN [username]       VARCHAR(100),
  IN [password]       VARCHAR(100),
  IN [email_address]  VARCHAR(100)
)
  BEGIN
    @user_count := @user_count + 1
    INSERT INTO [People]
      VALUE(@user_count, [username], [password], [email_address], TRUE);
    INSERT INTO [Guest]
      VALUE(@user_count, FALSE, @default_credit_level, @default_credit_level, DEFAULT);
  END


-- Caller: administrators
-- Senario: a guest just created an account, and the new guest went to the front desk and paid the deposit fee
-- Function: activate the new guest's account
-- Input: guest_ID
-- Output: None
CREATE PROCEDURE activate_guest_account (
  IN [guest_ID]     BIGINT
)
  BEGIN
    UPDATE [Guest]
    SET [Guest].[availability] = TRUE
    WHERE [Guest].[ID] = [guest_ID];
  END
