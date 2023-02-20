CREATE TABLE Event (
  [ID]                BIGINT NOT NULL AUTO_INCREMENT,
  [name]              VARCHAR(100) NOT NULL,
  [start_date_time]   DATETIME NOT NULL,
  [end_date_time]     DATETIME NOT NULL,
  [capacity]          INT NOT NULL,
  [current_amount]    INT NOT NULL,
  [description]       VARCHAR(MAX),
  [location_ID]       BIGINT NOT NULL,
  [admin_ID]          BIGINT NOT NULL,

  PRIMARY KEY ([ID]),

  FOREIGN KEY ([location_ID]) REFERENCES [Location]([ID]),
  FOREIGN KEY ([admin_ID]) REFERENCES Administrator([ID])
)

CREATE TABLE Registration (
  [guest_ID]          BIGINT NOT NULL,
  [event_ID]          BIGINT NOT NULL,

  PRIMARY KEY (guest_ID, event_ID),

  FOREIGN KEY ([guest_ID]) REFERENCES Guest([ID]),
  FOREIGN KEY ([event_ID]) REFERENCES [Event]([ID])
)