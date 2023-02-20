CREATE TABLE Bookshelf (
  ID                BIGINT NOT NULL AUTO_INCREMENT,
  capacity          INT NOT NULL,
  current_amount    INT NOT NULL,
  location_ID       BIGINT NOT NULL,

  PRIMARY KEY (ID),

  FOREIGN KEY (location_ID) REFERENCES Location(ID)
)