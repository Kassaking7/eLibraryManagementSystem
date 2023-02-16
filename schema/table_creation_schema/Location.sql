CREATE TABLE Location (
  [ID]                INT NOT NULL AUTO_INCREMENT,
  [building]          VARCHAR(100) NOT NULL,
  [floor]             VARCHAR(100) NOT NULL,
  [room]              VARCHAR(100) NOT NULL,
  [open_hour]         VARCHAR(15) NOT NULL,

  PRIMARY KEY (ID),

  CONSTRAINT unique_location UNIQUE ([building], [floor], [room])
)

CREATE TABLE In_charged_by (
  [location_ID]       INT NOT NULL,
  [administrator_ID]  INT NOT NULL,

  PRIMARY KEY (location_ID, administrator_ID),
  
  FOREIGN KEY ([location_ID]) REFERENCES [Location]([ID]),
  FOREIGN KEY ([administrator_ID]) REFERENCES Administrator([ID])
)