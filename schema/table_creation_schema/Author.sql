CREATE TABLE Author (
  ID                BIGINT NOT NULL AUTO_INCREMENT,
  name              VARCHAR(100) NOT NULL,
  nationality       VARCHAR(100),
  birth_year        VARCHAR(7),

  PRIMARY KEY (ID)
);

CREATE TABLE Written_by (
  ISBN              VARCHAR(20) NOT NULL,
  author_ID         BIGINT NOT NULL,

  PRIMARY KEY (ISBN, author_ID),
  
  FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
  FOREIGN KEY (author_ID) REFERENCES Author(ID)
);