-- Caller: guests
-- Senario: a guest wants to search a book
-- Function: search books that matches the given information
-- Input: ISBN, title, number of pages, tag name, author name, author nationality, author birth year, publisher name, publication year
-- Output: ISBN of the search books
CREATE PROCEDURE book_search (
  IN ISBN               VARCHAR(20),
  IN title              VARCHAR(50),
  IN number_of_pages    INT,
  IN tag_name           VARCHAR(50),
  IN author_name        VARCHAR(100),
  IN author_nationality VARCHAR(100),
  IN author_birth_year  VARCHAR(7),
  IN publisher_name     VARCHAR(100),
  IN publication_year   VARCHAR(7),
  OUT result_ISBN       VARCHAR(20)
)
  BEGIN
    SELECT DISTINCT Book.ISBN INTO result_ISBN
    FROM Book
    INNER JOIN Has_tag ON (Book.ISBN = Has_tag.ISBN)
    INNER JOIN Tag ON (Has_tag.tag_name = Tag.name)
    INNER JOIN Written_by ON (Book.ISBN = Written_by.ISBN)
    INNER JOIN Author ON (Written_by.author_ID = Author.ID)
    INNER JOIN Publisher ON (Book.publisher_ID = Publisher.ID)
    WHERE Book.title LIKE CONCAT(ISNULL(title, ""), "%")
    AND Book.number_of_pages LIKE CONCAT(ISNULL(number_of_pages, ""), "%")
    AND Tag.name LIKE CONCAT(ISNULL(tag_name, ""), "%")
    AND Author.name LIKE CONCAT(ISNULL(author_name, ""), "%")
    AND Author.nationality LIKE CONCAT(ISNULL(author_nationality, ""), "%")
    AND Author.birth_year LIKE CONCAT(ISNULL(author_birth_year, ""), "%")
    AND Publisher.name LIKE CONCAT(ISNULL(publisher_name, ""), "%")
    AND Book.publication_year LIKE CONCAT(ISNULL(publication_year, ""), "%");
  END
