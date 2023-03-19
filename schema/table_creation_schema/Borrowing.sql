CREATE TABLE Borrowing (
  ISBN              VARCHAR(20) NOT NULL,
  copy_ID           BIGINT NOT NULL,
  borrowing_ID      BIGINT NOT NULL,
  borrow_date       DATE NOT NULL,
  return_date       DATE,
  return_deadline   DATE NOT NULL,
  extend_number     INT NOT NULL DEFAULT 0,
  guest_ID          BIGINT NOT NULL,

  PRIMARY KEY (ISBN, copy_ID, borrowing_ID),

  FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
  FOREIGN KEY (copy_ID) REFERENCES Copy(copy_ID),
  FOREIGN KEY (guest_ID) REFERENCES Guest(ID)
);
