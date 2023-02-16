CREATE TABLE Event (
  [ID]                INT NOT NULL AUTO_INCREMENT,
  [name]              VARCHAR(100) NOT NULL,
  [start_date_time]   DATETIME NOT NULL,
  [end_date_time]     DATETIME NOT NULL,
  [capacity]          INT NOT NULL,
  [current_amount]    INT NOT NULL,
  [description]       VARCHAR(MAX),
  [hosted_at]         INT NOT NULL,
  [hosted_by]         INT NOT NULL,

  PRIMARY KEY (ID),

  FOREIGN KEY ([hosted_at]) REFERENCES [Location]([ID]),
  FOREIGN KEY ([hosted_by]) REFERENCES Administrator([ID])
)

CREATE TABLE Registration (
  [guest_ID]          INT NOT NULL,
  [event_ID]          INT NOT NULL,

  PRIMARY KEY (guest_ID, event_ID),

  FOREIGN KEY ([guest_ID]) REFERENCES Guest([ID]),
  FOREIGN KEY ([event_ID]) REFERENCES [Event]([ID])
)