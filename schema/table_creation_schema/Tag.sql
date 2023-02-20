CREATE TABLE Tag (
  [name]              VARCHAR(50) NOT NULL,

  PRIMARY KEY ([name])
)

CREATE TABLE Has_tag (
  [ISBN]              VARCHAR(20) NOT NULL,
  [tag_name]          VARCHAR(50) NOT NULL,

  PRIMARY KEY ([ISBN], [tag_name]),
  
  FOREIGN KEY ([ISBN]) REFERENCES Book([ISBN]),
  FOREIGN KEY ([tag_name]) REFERENCES Tag([name])
)