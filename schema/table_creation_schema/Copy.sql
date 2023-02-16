CREATE TABLE Copy (
  [ISBN]              VARCHAR(20) NOT NULL,
  [copy_ID]           INT NOT NULL,
  [availability]      BOOLEAN NOT NULL,
  [stored_in]         INT NOT NULL,

  PRIMARY KEY (ISBN, copy_ID),

  FOREIGN KEY ([ISBN]) REFERENCES Book([ISBN]),
  FOREIGN KEY ([stored_in]) REFERENCES Bookshelf([ID])
)