CREATE TABLE Publisher (
  ID                BIGINT NOT NULL AUTO_INCREMENT,
  name              VARCHAR(100) NOT NULL,
  address           VARCHAR(MAX),

  PRIMARY KEY (ID)
)