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
    BookInfo.title, 
    GROUP_CONCAT(DISTINCT BookInfo.authorName SEPARATOR ',') AS authors,
    BookInfo.publisherName AS publisher,
    BookInfo.publicationYear,
    GROUP_CONCAT(DISTINCT BookInfo.tagName SEPARATOR ',') AS tags,
    BookInfo.availableCopies
    FROM (
      SELECT 
      Book.title AS title, 
      Publisher.name AS publisherName, 
      Book.publication_year AS publicationYear, 
      IFNULL(Copies.available_copies, 0) AS availableCopies, 
      Author.name AS authorName, 
      Tag.name AS tagName
      FROM Book
      LEFT OUTER JOIN Has_tag ON (Book.ISBN = Has_tag.ISBN)
      LEFT OUTER JOIN Tag ON (Has_tag.tag_name = Tag.name)
      LEFT OUTER JOIN Written_by ON (Book.ISBN = Written_by.ISBN)
      LEFT OUTER JOIN Author ON (Written_by.author_ID = Author.ID)
      LEFT OUTER JOIN Publisher ON (Book.publisher_ID = Publisher.ID)
      LEFT OUTER JOIN (
        SELECT Copy.ISBN, sum(Copy.availability = 1) AS available_copies
        FROM Copy
        WHERE Copy.ISBN = ISBN
        GROUP BY Copy.ISBN
      ) AS Copies ON (Book.ISBN = Copies.ISBN)
      WHERE Book.ISBN = ISBN
    ) AS BookInfo
    GROUP BY BookInfo.title, BookInfo.publisherName, BookInfo.publicationYear, BookInfo.availableCopies;
  END //
  
  DELIMITER ;
