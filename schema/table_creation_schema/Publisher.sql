CREATE TABLE Publisher (
  [ID]                INT NOT NULL AUTO_INCREMENT,
  [name]              VARCHAR(100) NOT NULL,
  [address]           VARCHAR(MAX),

  PRIMARY KEY (ID)
)

CREATE TABLE Published_by (
  [ISBN]              VARCHAR(20) NOT NULL,
  [publisher_ID]      INT NOT NULL,

  PRIMARY KEY (ISBN, publisher_ID),
  
  FOREIGN KEY ([ISBN]) REFERENCES Book([ISBN]),
  FOREIGN KEY ([publisher_ID]) REFERENCES Publisher([ID])
)