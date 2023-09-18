import mysql.connector
from mysql.connector import errorcode
# 数据库连接配置
config = {
    'user': 'root',
    'password': '196851444',
    'host': 'localhost',
    'database': 'elibrarydb',
    'raise_on_warnings': True
}

# 数据库名称
db_name = 'elibrarydb'

# 连接到MySQL服务器
conn = mysql.connector.connect(**config)
cursor = conn.cursor()

def create_database(cursor):
    try:
        cursor.execute(
            "CREATE DATABASE {}".format(db_name))
    except mysql.connector.Error as err:
        print("Failed creating database: {}".format(err))
        exit(1)
def drop_database(cursor):
    try:
        cursor.execute("DROP DATABASE {}".format(db_name))
        print("Database {} dropped successfully.".format(db_name))
    except mysql.connector.Error as err:
        print("Failed dropping database: {}".format(err))
        exit(1)
def create_tables(cursor):
    cursor.execute('''
    CREATE TABLE People (
    ID                BIGINT NOT NULL AUTO_INCREMENT,
    username          VARCHAR(100) NOT NULL UNIQUE,
    password          VARCHAR(100) NOT NULL,
    email_address     VARCHAR(100) NOT NULL UNIQUE,
    is_guest          BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (ID)
    );
    ''')

    cursor.execute('''
    CREATE TABLE Guest (
    ID                BIGINT NOT NULL,
    is_activated      BOOLEAN NOT NULL DEFAULT TRUE,
    credit_level      INT NOT NULL DEFAULT 5,
    remaining_credit  INT NOT NULL DEFAULT 5,
    late_fee          NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES People(ID)
    );
    ''')

    cursor.execute('''
    CREATE TABLE Administrator (
    ID                BIGINT NOT NULL,
    can_edit_books    BOOLEAN NOT NULL DEFAULT true,
    can_host_event    BOOLEAN NOT NULL DEFAULT true,
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES People(ID)
    );
    ''')

    cursor.execute('''
    CREATE TABLE Publisher (
    ID                BIGINT NOT NULL AUTO_INCREMENT,
    name              VARCHAR(100) NOT NULL,
    address           VARCHAR(6000),
    PRIMARY KEY (ID)
    );
    ''')

    cursor.execute('''
    CREATE TABLE Location (
    ID                BIGINT NOT NULL AUTO_INCREMENT,
    building          VARCHAR(100) NOT NULL,
    floor             VARCHAR(100) NOT NULL,
    room              VARCHAR(100) NOT NULL,
    open_time         TIME NOT NULL,
    close_time        TIME NOT NULL,

    PRIMARY KEY (ID),

    CONSTRAINT unique_location UNIQUE (building, floor, room)
    );
    ''')

    cursor.execute('''
    CREATE TABLE In_charged_by (
    location_ID       BIGINT NOT NULL,
    administrator_ID  BIGINT NOT NULL,

    PRIMARY KEY (location_ID, administrator_ID),
    
    FOREIGN KEY (location_ID) REFERENCES Location(ID),
    FOREIGN KEY (administrator_ID) REFERENCES Administrator(ID)
    );
    ''')

    cursor.execute('''
    CREATE TABLE Event (
    ID                BIGINT NOT NULL AUTO_INCREMENT,
    name              VARCHAR(100) NOT NULL,
    start_date_time   DATETIME NOT NULL,
    end_date_time     DATETIME NOT NULL,
    capacity          INT NOT NULL,
    current_amount    INT NOT NULL,
    description       VARCHAR(6000),
    location_ID       BIGINT NOT NULL,
    admin_ID          BIGINT NOT NULL,

    PRIMARY KEY (ID),

    FOREIGN KEY (location_ID) REFERENCES Location(ID),
    FOREIGN KEY (admin_ID) REFERENCES Administrator(ID)
    );
    ''')
    cursor.execute('''
    CREATE INDEX event_index ON Event(start_date_time, end_date_time);
    ''')
    cursor.execute('''
    CREATE TABLE Registration (
    guest_ID          BIGINT NOT NULL,
    event_ID          BIGINT NOT NULL,

    PRIMARY KEY (guest_ID, event_ID),

    FOREIGN KEY (guest_ID) REFERENCES Guest(ID),
    FOREIGN KEY (event_ID) REFERENCES Event(ID)
    );
    ''')

    cursor.execute('''
    CREATE TABLE Book (
    ISBN               VARCHAR(20),
    title              VARCHAR(150) NOT NULL,
    number_of_pages    INT NOT NULL,
    publisher_ID       BIGINT NOT NULL,
    publication_year   VARCHAR(7),
    
    PRIMARY KEY (ISBN),

    FOREIGN KEY (publisher_ID) REFERENCES Publisher(ID)
    );
    ''')
    cursor.execute('''
    CREATE INDEX book_index ON Book(title);
    ''')
    cursor.execute('''
    CREATE TABLE Author (
    ID                BIGINT NOT NULL AUTO_INCREMENT,
    name              VARCHAR(100) NOT NULL,
    nationality       VARCHAR(100),
    birth_year        VARCHAR(7),

    PRIMARY KEY (ID)
    );
    ''')
    cursor.execute('''
    CREATE TABLE Written_by (
    ISBN              VARCHAR(20) NOT NULL,
    author_ID         BIGINT NOT NULL,

    PRIMARY KEY (ISBN, author_ID),
    
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
    FOREIGN KEY (author_ID) REFERENCES Author(ID)
    );
    ''')
    cursor.execute('''
    CREATE TABLE Bookshelf (
    ID                BIGINT NOT NULL AUTO_INCREMENT,
    capacity          INT NOT NULL,
    current_amount    INT NOT NULL,
    location_ID       BIGINT NOT NULL,

    PRIMARY KEY (ID),

    FOREIGN KEY (location_ID) REFERENCES Location(ID)
    );
    ''')

    cursor.execute('''
    CREATE TABLE Copy (
    ISBN              VARCHAR(20) NOT NULL,
    copy_ID           BIGINT NOT NULL,
    availability      BOOLEAN NOT NULL,
    bookshelf_ID      BIGINT NOT NULL,

    PRIMARY KEY (ISBN, copy_ID),

    FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
    FOREIGN KEY (bookshelf_ID) REFERENCES Bookshelf(ID)
    );
    ''')
    cursor.execute('''
    CREATE INDEX copy_index ON Copy(copy_ID);
    ''')
    cursor.execute('''
    CREATE TABLE Tag (
    name    VARCHAR(50) NOT NULL,
    PRIMARY KEY (name)
    );
    ''')

    cursor.execute('''
    CREATE TABLE Has_tag (
    ISBN              VARCHAR(20) NOT NULL,
    tag_name          VARCHAR(50) NOT NULL,

    PRIMARY KEY (ISBN, tag_name),
    
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
    FOREIGN KEY (tag_name) REFERENCES Tag(name)
    );
    ''')
    cursor.execute('''
    CREATE INDEX tag_index ON Has_tag(tag_name);
    ''')
    cursor.execute('''
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
    ''')

    cursor.execute('''
    CREATE TRIGGER insert_into_guest
    AFTER INSERT ON People
    FOR EACH ROW
    BEGIN
        IF NEW.is_guest = TRUE THEN
            INSERT INTO Guest (ID) VALUES (NEW.ID);
        END IF;
    END;
   ''')
    
    cursor.execute('''
    CREATE TRIGGER insert_into_admin
    AFTER INSERT ON People
    FOR EACH ROW
    BEGIN
        IF NEW.is_guest = FALSE THEN
            INSERT INTO administrator (ID) VALUES (NEW.ID);
        END IF;
    END;
   ''')
    cursor.execute('''
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
   ''')

# 尝试使用数据库，如果存在则删除
try:
    cursor.execute("USE {}".format(db_name))
    drop_database(cursor)
except mysql.connector.Error as err:
    if err.errno != errorcode.ER_BAD_DB_ERROR:
        print(err)
        exit(1)

# 创建新的数据库
create_database(cursor)
print("Database {} created successfully.".format(db_name))
conn.database = db_name
create_tables(cursor)
print("Tables created successfully.")

# 关闭连接
cursor.close()
conn.close()

