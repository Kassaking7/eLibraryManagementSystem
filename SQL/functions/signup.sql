SET @default_credit_level = 5;
SET @user_count = 100;

CREATE PROCEDURE signup (
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



CREATE PROCEDURE activate_guest (
  IN [guest_ID]     BIGINT
)
  BEGIN
    UPDATE [Guest]
    SET [Guest].[availability] = TRUE
    WHERE [Guest].[ID] = [guest_ID];
  END
