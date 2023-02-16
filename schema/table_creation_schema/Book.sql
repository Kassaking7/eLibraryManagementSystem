CREATE TABLE Book (
  [ISBN]              VARCHAR(20),
  [title]             VARCHAR(50) NOT NULL,
  [number_of_pages]   INT NOT NULL,
  [description]       VARCHAR(MAX),
  
  PRIMARY KEY ([ISBN])
)