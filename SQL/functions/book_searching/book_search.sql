-- Caller: guests
-- Senario: a guest wants to search a book
-- Function: search books that matches the given information
-- Input: ISBN, title, number of pages, tag name, author name, author nationality, author birth year, publisher name, publication year
-- Output: ISBN of the search books

DROP PROCEDURE IF EXISTS book_search;

DELIMITER //
CREATE PROCEDURE book_search (
  IN ISBN               VARCHAR(20),
  IN title              VARCHAR(50),
  IN tag_name           VARCHAR(50),
  IN author_name        VARCHAR(100),
  IN publisher_name     VARCHAR(100)
)
  BEGIN
    SELECT DISTINCT Book.ISBN
    FROM Book
    LEFT OUTER JOIN Has_tag ON (Book.ISBN = Has_tag.ISBN)
    LEFT OUTER JOIN Tag ON (Has_tag.tag_name = Tag.name)
    LEFT OUTER JOIN Written_by ON (Book.ISBN = Written_by.ISBN)
    LEFT OUTER JOIN Author ON (Written_by.author_ID = Author.ID)
    LEFT OUTER JOIN Publisher ON (Book.publisher_ID = Publisher.ID)
    WHERE (isnull(ISBN) or ISBN = Book.ISBN)
	AND Book.title LIKE CONCAT(IFNULL(title, ""), "%")
	AND CASE
    WHEN tag_name IS NULL THEN TRUE
    ELSE Tag.name LIKE CONCAT(IFNULL(tag_name, ""), "%")
  END
	AND CASE 
    WHEN author_name IS NULL THEN TRUE
    ELSE Author.name LIKE CONCAT(IFNULL(author_name, ""), "%")
  END
	AND Publisher.name LIKE CONCAT(IFNULL(publisher_name, ""), "%");
  END //
  DELIMITER ;
