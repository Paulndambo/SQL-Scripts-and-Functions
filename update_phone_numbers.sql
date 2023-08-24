do
$$
declare
    r record;
	newval Text;
begin
    for r in select * from users_policyholder where LENGTH(phone_number) = 9
    loop
		newval := CONCAT('0',r.phone_number);
		update users_policyholder set phone_number = newval where id = r.id;
		raise notice 'new number is %', newval;
    end loop;
end;
$$