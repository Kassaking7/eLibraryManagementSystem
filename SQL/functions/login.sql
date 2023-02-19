CREATE PROCEDURE match_password (
  IN [user_id]  INT, 
  IN [password] VARCHAR(100),
  IN [is_guest] BOOLEAN,
  OUT [match] BOOLEAN
)
  BEGIN
    SELECT CASE 
      WHEN COUNT(*) = 1 THEN CASE
        WHEN [People].[password] = [password] THEN TRUE
        ELSE FALSE 
      ELSE FALSE INTO [match]
    FROM [People]
    WHERE [People].[ID] = [user_id]
    AND [People].[ID] IN (
      CASE 
        WHEN [is_guest] THEN (
          SELECT [Guest].[ID] FROM [Guest]
        ) ELSE (
          SELECT [Administrator].[ID] FROM [Administrator]
        )
    );
  END
