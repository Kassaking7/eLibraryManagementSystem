-- Caller: guests
-- Senario: after getting the ISBN of the search results, display the list of general info of the search results.
-- Function: get the general info of the book with the book with given ISBN
-- Input: ISBN
-- Output: book title, authors, publisher name, publication year, tags

DROP PROCEDURE IF EXISTS show_general_book_info;

DELIMITER //
CREATE PROCEDURE show_general_book_info (
  IN ISBN               VARCHAR(20)
)
  BEGIN
    SELECT DISTINCT
    BookInfo.title, 
    GROUP_CONCAT(DISTINCT BookInfo.authorName SEPARATOR ',') AS authors,
    BookInfo.publisherName AS publisher,
    BookInfo.publication_year,
    GROUP_CONCAT(DISTINCT BookInfo.tagName SEPARATOR ',') AS tags
    FROM (
      SELECT 
        Book.title AS title, 
        Author.name AS authorName,
        Publisher.name AS publisherName,
        Book.publication_year,
        Tag.name AS tagName
      FROM Book
      LEFT OUTER JOIN Has_tag ON (Book.ISBN = Has_tag.ISBN)
      LEFT OUTER JOIN Tag ON (Has_tag.tag_name = Tag.name)
      LEFT OUTER JOIN Written_by ON (Book.ISBN = Written_by.ISBN)
      LEFT OUTER JOIN Author ON (Written_by.author_ID = Author.ID)
      LEFT OUTER JOIN Publisher ON (Book.publisher_ID = Publisher.ID)
      WHERE Book.ISBN = ISBN
    ) AS BookInfo
    GROUP BY BookInfo.title, BookInfo.publication_year, BookInfo.publisherName;
  END //
  
  DELIMITER ;
