SET @default_credit_level = 5;
SET @user_count = 0;

CREATE PROCEDURE signup (
  IN [username] VARCHAR(100),
  IN [password] VARCHAR(100)
)
  BEGIN
  @user_count := @user_count + 1
  INSERT INTO [People]
    VALUE(@user_count * 10 + 1, [username], [password]);
  INSERT INTO [Guest]
    VALUE(@user_count * 10 + 1, @default_credit_level, @default_credit_level, DEFAULT)
  END
