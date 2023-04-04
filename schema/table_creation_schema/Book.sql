CREATE TABLE Book (
  ISBN               VARCHAR(20),
  title              VARCHAR(150) NOT NULL,
  number_of_pages    INT NOT NULL,
  publisher_ID       BIGINT NOT NULL,
  publication_year   VARCHAR(7),
  
  PRIMARY KEY (ISBN),

  FOREIGN KEY (publisher_ID) REFERENCES Publisher(ID)
);

CREATE INDEX book_index ON Book(title);