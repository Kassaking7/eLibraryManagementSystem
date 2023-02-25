call match_password('1', '0123Kem45mis!@', @password_match_t1);
select @password_match_t1 as t1; #Expect: 1

call match_password('1', '0123em45mis!@', @password_match_f1);
select @password_match_f1 as f1; #Expect: 0