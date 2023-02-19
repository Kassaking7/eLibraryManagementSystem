CREATE TABLE People (
  [ID]                INT NOT NULL -- AUTO_INCREMENT,
  [username]          VARCHAR(100) NOT NULL UNIQUE,
  [password]          VARCHAR(100) NOT NULL,

  PRIMARY KEY (ID)
)

CREATE TABLE Guest (
  [ID]                INT NOT NULL,
  [credit_level]      INT NOT NULL,
  [remaining_credit]  INT NOT NULL,
  [late_fee]          NUMERIC(10, 2) NOT NULL SET DEFAULT 0.00,

  PRIMARY KEY (ID),

  FOREIGN KEY ([ID]) REFERENCES People([ID])
)

CREATE TABLE Administrator (
  [ID]                INT NOT NULL,
  [can_edit_books]    BOOLEAN NOT NULL,
  [can_host_event]    BOOLEAN NOT NULL,

  PRIMARY KEY (ID),

  FOREIGN KEY ([ID]) REFERENCES People([ID])
)

CREATE TABLE Security_question (
  [people_ID]         INT NOT NULL,
  [question_ID]       INT NOT NULL,
  [question_prompt]   VARCHAR(MAX) NOT NULL,
  [answer]            VARCHAR(MAX) NOT NULL,

  PRIMARY KEY (people_ID, question_ID),

  CONSTRAINT unique_question_for_one_people UNIQUE ([people_ID], [question_prompt]),

  FOREIGN KEY ([people_ID]) REFERENCES People([ID])
)