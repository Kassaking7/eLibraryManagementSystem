CREATE TABLE Book (
  ISBN               VARCHAR(20),
  title              VARCHAR(50) NOT NULL,
  number_of_pages    INT NOT NULL,
  description        VARCHAR(6000),
  publisher_ID       BIGINT NOT NULL,
  publication_year   VARCHAR(7),
  
  PRIMARY KEY (ISBN),

  FOREIGN KEY (publisher_ID) REFERENCES Publisher(ID)
);