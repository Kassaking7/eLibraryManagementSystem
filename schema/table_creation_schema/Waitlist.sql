CREATE TABLE Waitlist (
  ISBN              VARCHAR(20) NOT NULL,
  guest_ID          BIGINT NOT NULL,
  priority          INT NOT NULL,

  PRIMARY KEY (ISBN, guest_ID),

  CONSTRAINT unique_priority_for_one_book UNIQUE (ISBN, priority),

  FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
  FOREIGN KEY (guest_ID) REFERENCES Guest(ID)
);