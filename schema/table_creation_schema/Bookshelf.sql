CREATE TABLE Bookshelf (
  [ID]                INT NOT NULL AUTO_INCREMENT,
  [capacity]          INT NOT NULL,
  [current_amount]    INT NOT NULL,
  [location_ID]       INT NOT NULL,

  PRIMARY KEY (ID),

  FOREIGN KEY ([location_ID]) REFERENCES [Location]([ID])
)