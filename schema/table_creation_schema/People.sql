CREATE TABLE People (
  ID                BIGINT NOT NULL,
  username          VARCHAR(100) NOT NULL,
  password          VARCHAR(100) NOT NULL,
  email_address     VARCHAR(100) NOT NULL UNIQUE,
  is_guest          BOOLEAN NOT NULL DEFAULT TRUE,

  PRIMARY KEY (ID)
);

CREATE TABLE Guest (
  ID                BIGINT NOT NULL,
  is_activated      BOOLEAN NOT NULL DEFAULT FALSE,
  credit_level      INT NOT NULL,
  remaining_credit  INT NOT NULL,
  late_fee          NUMERIC(10, 2) NOT NULL DEFAULT 0.00,

  PRIMARY KEY (ID),

  FOREIGN KEY (ID) REFERENCES People(ID)
)

CREATE TABLE Administrator (
  ID                BIGINT NOT NULL,
  can_edit_books    BOOLEAN NOT NULL,
  can_host_event    BOOLEAN NOT NULL,

  PRIMARY KEY (ID),

  FOREIGN KEY (ID) REFERENCES People(ID)
);
