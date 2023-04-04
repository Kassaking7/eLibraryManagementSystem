CREATE TABLE Location (
  ID                BIGINT NOT NULL AUTO_INCREMENT,
  building          VARCHAR(100) NOT NULL,
  floor             VARCHAR(100) NOT NULL,
  room              VARCHAR(100) NOT NULL,
  open_time         TIME NOT NULL,
  close_time        TIME NOT NULL,

  PRIMARY KEY (ID),

  CONSTRAINT unique_location UNIQUE (building, floor, room)
);

CREATE INDEX location_index ON Location(building, floor, room);

CREATE TABLE In_charged_by (
  location_ID       BIGINT NOT NULL,
  administrator_ID  BIGINT NOT NULL,

  PRIMARY KEY (location_ID, administrator_ID),
  
  FOREIGN KEY (location_ID) REFERENCES Location(ID),
  FOREIGN KEY (administrator_ID) REFERENCES Administrator(ID)
);
