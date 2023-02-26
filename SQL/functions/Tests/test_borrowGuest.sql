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
