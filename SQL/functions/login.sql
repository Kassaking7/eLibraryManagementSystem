CREATE PROCEDURE match_password (
  IN [user_id]  BIGINT, 
  IN [password] VARCHAR(100),
  OUT [match]   BOOLEAN
)
  BEGIN
    SELECT CASE 
      WHEN COUNT(*) = 1 THEN CASE
        WHEN [People].[password] = [password] THEN TRUE
        ELSE FALSE
      ELSE FALSE INTO [match]
    FROM [People]
    WHERE [People].[ID] = [user_id];
  END
