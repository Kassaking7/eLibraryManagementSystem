CREATE TABLE Copy (
  [ISBN]              VARCHAR(20) NOT NULL,
  [wait_ID]           INT NOT NULL,
  [priority]          INT NOT NULL,
  [made_by]           INT NOT NULL,

  PRIMARY KEY (ISBN, wait_ID),

  CONSTRAINT unique_priority_for_one_book UNIQUE ([ISBN], [priority])

  FOREIGN KEY ([ISBN]) REFERENCES Book([ISBN]),
  FOREIGN KEY ([made_by]) REFERENCES Guest([ID])
)