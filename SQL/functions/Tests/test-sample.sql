##############################
## test_password
##############################
# Test the function for checking if user password is correct 
call match_password('1', '0123Kem45mis!@', @password_match_t1);
select @password_match_t1 as t1; #Expect: 1

call match_password('1', '0123em45mis!@', @password_match_f1);
select @password_match_f1 as f1; #Expect: 0






##############################
## test_activateGuestAccount
##############################
# test the functino for activate Guest Account
## In the Guest table, "is_activated" should be 1 for the users with these ID. No other changes to the current account
call activate_guest_account(1);
call activate_guest_account(9);
call activate_guest_account(11);
call activate_guest_account(0);
call activate_guest_account(12);




##############################
## test_createGuestAccoun
##############################
# Test the function for creating guest account
## Expected these account to appear in both Guest and People Tables.
## In the People table, "is_guest" should be 1 for these inserted rows
## In the Guest table, "is_activated" should be 0 for these rows
## In the Guest table, "credit_level" and "remaining_credit" should be 5, and "late_fee" should be 0.

call create_guest_account('user1', 'zxdchf12345', '12345@gmail.com', @userid_t1);
select @userid_t1 as t1;

call create_guest_account('guest2', '1234512345', '12345@qq.com', @userid_t2);
select @userid_t2 as t2;

call create_guest_account('user4', '341hf12345', '5345@gmail.com', @userid_t3);
select @userid_t3 as t3;

call create_guest_account('user5', 'z341145', '151345@gmail.com', @userid_t4);
select @userid_t4 as t4;





##############################
## test_bookSearch
##############################
# test the bookSearch function
## Search by ISBN
call book_search('1', null, null, null, null); # Expected: 1
call book_search('12', null, null, null, null); # Expected: 12
## Search by Book Name
call book_search(null, 'D', null, null, null); # Expected: 11, 27
call book_search(null, 'Vampires', null, null, null); # Expected: 1
call book_search(null, 'Vampiress', null, null, null); # Expected: no result
call book_search(null, 'Vampi', null, null, null); # Expected: 1
## Search by tag_name
call book_search(null, null, 'Western', null, null); # Expected: 15, 17, 25, 50
## Search by author_name  
call book_search(null, null, null, 'Durante Downey', null); # Expected: 26, 39, 49
call book_search(null, null, null, 'Durante', null); # Expected: 26, 39, 49
## Search by publisher_name
call book_search(null, null, null, null, 'Coriss Slocom'); # Expected: 33, 6
## Search by tag and publisher_name
call book_search(null, 'Vamp', null, null, 'Joeann'); # Expected: 1
## Search by tag and author_name
call book_search(null, 'Brave', null, 'Durante Downey', null); # Expected: 26






##############################
## test_showDetailedBookInfo
##############################
# Test the function for showeing book info (detailed)
# Will show the book's (title, authors, publisher, publication_year, tags, available_copies, description)
call show_detailed_book_info(1);  # Expect: (Vampires,	(Quinta Po,Aimil Mayman),	Joeann Abrahamsohn, 1998, Drama, 0, augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat)
call show_detailed_book_info(13); # Expect: (Wedding Party, The (Die Bluthochzeit), Brion Biddwell, Lena Greasley, 2011, Comedy, 1, elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo)
call show_detailed_book_info(18); # Expect: (Funny Girl, Geordie Constantine, Nataniel Raselles, 2002,	African, 0, ,)
call show_detailed_book_info(24); # Expect: (Sweet Sixteen,	Keslie Palley, Joeann Abrahamsohn,	2004,	Comedy,	1, curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros)
call show_detailed_book_info(11); # Expect: (Darby's Rangers,	Ximenes Howells, Courtney Sheward,	 African, 0, leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec)
call show_detailed_book_info(16); # Expect: (To Live (Huozhe), Nonna Trowsdall, Sancho Skegg,	2004,	Thriller,	0	, ,)
 



##############################
## test_showGeneralBookInfo
##############################
# Test the function for showeing book info (general)
# Will show the book's (title, authors, publisher, publication_year, tags)
call show_general_book_info(10); # Expect: ( Choke, (Ailis Gorrick, Ciel Raffan, Ingemar Billany), Lorettalorna Brunnstein, 2002, Drama)
call show_general_book_info(2);  # Expect: (Punk's Dead: SLC Punk! 2, 	Josey O'Henecan, 	Keriann Meachan,	2007,	Thriller)
call show_general_book_info(3);  # Expect: (Star Packer, The,	Cyrillus Bedo,	Anselma Spurr,	1998,	Comedy)
call show_general_book_info(51); # Expect: (null, null, null, null, null)






##############################
## test_borrowAdmin
##############################
# test the borrow function (via Admin)
- Reset Credit Level
UPDATE GUEST
SET remaining_credit = 5
WHERE GUEST.ID = 11;

-- Reset Copy
UPDATE Copy
SET availability = true
WHERE ISBN = 47 OR ISBN = 3 OR ISBN = 21 OR ISBN = 13;

## No Update
call borrow_via_admin(10, 47, 1, @enough_credit1);
select @enough_credit1; # Expect 0

## After the update, the guest with ID 11 should have remaining_credit 4
## Book with ISBN 47 should have 2 copy available
call borrow_via_admin(11, 47, 1, @enough_credit2);
select @enough_credit2; # Expect 1

## After the update, the guest with ID 11 should have remaining_credit 3
## Book with ISBN 47 should have 1 copy available
call borrow_via_admin(11, 47, 2, @enough_credit3);
select @enough_credit3; # Expect 1

## After the update, the guest with ID 11 should have remaining_credit 2
## Book with ISBN 47 should have 0 copy available
call borrow_via_admin(11, 47, 3, @enough_credit4);
select @enough_credit4; # Expect 1

## After the update, the guest with ID 11 should have remaining_credit 1
## Book with ISBN 3 should have 0 copy available
call borrow_via_admin(11, 3, 1, @enough_credit5);
select @enough_credit5; # Expect 1

## After the update, the guest with ID 11 should have remaining_credit 0
## Book with ISBN 21 should have 0 copy available
call borrow_via_admin(11, 21, 1, @enough_credit6);
select @enough_credit6; # Expect 1

## No Update
call borrow_via_admin(11, 13, @enough_credit7);
select @enough_credit7, @copy_available7; # Expect 0





##############################
## test_borrowGues
##############################
# test the borrow function (via Guest)
## After the updete, the guest with ID 10 should have remaining_credit 5
## Book with ISBN 1 should have 0 copy available
call borrow_via_guest(10, 1, @enough_credit1, @copy_available1);
select @enough_credit1, @copy_available1; # Expect 0 and 0


## After the updete, the guest with ID 11 should have remaining_credit 5
## Book with ISBN 1 should have 0 copy available
call borrow_via_guest(11, 1, @enough_credit2, @copy_available2);
select @enough_credit2, @copy_available2; # Expect 1 and 0

## After the updete, the guest with ID 11 should have remaining_credit 4
## Book with ISBN 47 should have 2 copy available
call borrow_via_guest(11, 47, @enough_credit3, @copy_available3);
select @enough_credit3, @copy_available3; # Expect 1 and 1

## After the updete, the guest with ID 11 should have remaining_credit 3
## Book with ISBN 47 should have 1 copy available
call borrow_via_guest(11, 47, @enough_credit4, @copy_available4);
select @enough_credit4, @copy_available4; # Expect 1 and 1

## After the updete, the guest with ID 11 should have remaining_credit 2
## Book with ISBN 47 should have 0 copy available
call borrow_via_guest(11, 47, @enough_credit5, @copy_available5);
select @enough_credit5, @copy_available5; # Expect 1 and 1


## After the updete, the guest with ID 11 should have remaining_credit 2
## Book with ISBN 47 should have 0 copy available
call borrow_via_guest(11, 47, @enough_credit6, @copy_available6);
select @enough_credit6, @copy_available6; # Expect 1 and 0


## After the updete, the guest with ID 11 should have remaining_credit 1
## Book with ISBN 3 should have 0 copy available
call borrow_via_guest(11, 3, @enough_credit7, @copy_available7);
select @enough_credit7, @copy_available7; # Expect 1 and 1


## After the updete, the guest with ID 11 should have remaining_credit 0
## Book with ISBN 21 should have 0 copy available
call borrow_via_guest(11, 21, @enough_credit7, @copy_available7);
select @enough_credit7, @copy_available7; # Expect 1 and 1

## After the updete, the guest with ID 11 should have remaining_credit 0
## Book with ISBN 13 should have 1 copy available
call borrow_via_guest(11, 13, @enough_credit7, @copy_available7);
select @enough_credit7, @copy_available7; # Expect 0 and 1

