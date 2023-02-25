## Search by ISBN
call book_search('1', null, null, null, null); # Expected: 1
call book_search('12', null, null, null, null); # Expected: 12

## Search by Book Name
call book_search(null, 'D', null, null, null); # Expected: 11, 27
call book_search(null, 'Vampires', null, null, null); # Expected: 1
call book_search(null, 'Vampiress', null, null, null); # Expected: no result
call book_search(null, 'Vampi', null, null, null); # Expected: 1


# Search by tag_name
call book_search(null, null, 'Western', null, null); # Expected: 15, 17, 25, 50

# Search by author_name  
call book_search(null, null, null, 'Durante Downey', null); # Expected: 26, 39, 49
call book_search(null, null, null, 'Durante', null); # Expected: 26, 39, 49

# Search by publisher_name
call book_search(null, null, null, null, 'Coriss Slocom'); # Expected: 33, 6


# Search by tag and publisher_name
call book_search(null, 'Vamp', null, null, 'Joeann'); # Expected: 1

# Search by tag and author_name
call book_search(null, 'Brave', null, 'Durante Downey', null); # Expected: 26