-- Caller: guests
-- Senario: after getting the ISBN of the search results, display the list of general info of the search results.
-- Function: get the general info of the book with the book with given ISBN
-- Input: ISBN
-- Output: book title, authors, publisher name, publication year, tags
CREATE PROCEDURE show_general_book_info (
  IN ISBN               VARCHAR(20)
)
  BEGIN
    SELECT DISTINCT 
    Book.title, 
    GROUP_CONCAT(Author.name) AS authors,
    Publisher.name AS publisher,
    Book.publication_year,
    GROUP_CONCAT(Tag.name) AS tags
    FROM Book
    INNER JOIN Has_tag ON (Book.ISBN = Has_tag.ISBN)
    INNER JOIN Tag ON (Has_tag.tag_name = Tag.name)
    INNER JOIN Written_by ON (Book.ISBN = Written_by.ISBN)
    INNER JOIN Author ON (Written_by.author_ID = Author.ID)
    INNER JOIN Publisher ON (Book.publisher_ID = Publisher.ID)
    WHERE Book.ISBN = ISBN;
  END