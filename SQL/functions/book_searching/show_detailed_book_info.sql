-- Caller: guests
-- Senario: after getting the ISBN of the search results, display the list of detailed info of the search results.
-- Function: get the detailed info of the book with the book with given ISBN
-- Input: ISBN
-- Output: book title, authors, publisher name, publication year, tags, number of available copies, book description

DROP PROCEDURE IF EXISTS show_detailed_book_info;

DELIMITER //
CREATE PROCEDURE show_detailed_book_info (
  IN ISBN               VARCHAR(20)
)
  BEGIN
    SELECT DISTINCT 
    Book.title, 
    GROUP_CONCAT(Author.name) AS authors,
    Publisher.name AS publisher,
    Book.publication_year,
    GROUP_CONCAT(DISTINCT Tag.name SEPARATOR ',') AS tags,
    Copies.available_copies,
    Book.description
    FROM Book
    INNER JOIN Has_tag ON (Book.ISBN = Has_tag.ISBN)
    INNER JOIN Tag ON (Has_tag.tag_name = Tag.name)
    INNER JOIN Written_by ON (Book.ISBN = Written_by.ISBN)
    INNER JOIN Author ON (Written_by.author_ID = Author.ID)
    INNER JOIN Publisher ON (Book.publisher_ID = Publisher.ID)
    INNER JOIN (
      SELECT Copy.ISBN, sum(Copy.availability =1) AS available_copies
      FROM Copy
      WHERE Copy.ISBN = ISBN
      GROUP BY Copy.ISBN
    ) AS Copies ON (Book.ISBN = Copies.ISBN)
    WHERE Book.ISBN = ISBN;
  END //
  
  DELIMITER ;
