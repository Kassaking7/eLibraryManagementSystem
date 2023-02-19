CREATE TABLE Borrowing (
  [ISBN]              VARCHAR(20) NOT NULL,
  [copy_ID]           INT NOT NULL,
  [borrowing_ID]      INT NOT NULL,
  [borrow_date]       DATE NOT NULL,
  [return_date]       DATE NOT NULL,
  [return_deadling]   DATE NOT NULL,
  [extend_number]     INT NOT NULL SET DEFAULT 0,
  [guest_ID]           INT NOT NULL,

  PRIMARY (ISBM, copy_ID, borrowing_ID),

  FOREIGN KEY ([ISBN]) REFERENCES Book([ISBN]),
  FOREIGN KEY ([copy_ID]) REFERENCES [Copy]([ID]),
  FOREIGN KEY ([guest_ID]) REFERENCES Guest([ID])
)