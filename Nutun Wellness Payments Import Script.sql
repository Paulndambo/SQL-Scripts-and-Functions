-- payment script

create or replace function get_premium_amount(_pricing_plan text)
returns decimal
language plpgsql
as
$$
declare
   _premium decimal;
begin
	if _pricing_plan = 'Nutun Wellness' then
	  _premium := 12.00;
	else
	  _premium := 40.00;
	END if;
   
   return _premium;
end;
$$;


-- create the table where data will be temporarily imported into
CREATE TABLE member_import (
	member_import_id serial PRIMARY KEY,
	member_import_product VARCHAR NOT NULL,
	member_import_identification_method INT NOT NULL CHECK (member_import_identification_method >= 0 and member_import_identification_method <= 1),
	member_import_identification_number VARCHAR UNIQUE NOT NULL,
	member_import_mobile_number VARCHAR ( 10 ) NOT NULL,
);

do
$$
declare
	_imported_member record;
	_user_id int;
	_scheme_group_id int;
	_membership_id int;
	_policy_id int;
	_pricing_plan text;
begin
    for _imported_member in select * from member_import
    loop

			      -- get the user id
            --  if statement 
            if _imported_member.member_import_identification_method = 0 then
              select user_id into _user_id from users_profile where passport_number = _imported_member.member_import_identification_number;
            else
              select user_id into _user_id from users_profile where id_number = _imported_member.member_import_identification_number;
            end if;

            -- get the membership id
            select id into _membership_id from users_membership where user_id = _user_id;
            -- get the scheme group id
            select scheme_group_id into _scheme_group_id from users_membership where user_id = _user_id;

            -- get the policy id 
            select policy_id into _policy_id from schemes_schemegroup where id = _scheme_group_id;

            -- if statement
            if _policy_id isNull then
            	RAISE NOTICE 'Policy ID is null';
            else
                --  print user id number and user_id
                RAISE NOTICE 'user_id: %, user_id_number: %, policy_id: %', _user_id, _imported_member.member_import_identification_number, _policy_id;

                -- create unpdaid payment records
                INSERT into payments_policypremium(created,modified,balance,expected_payment,expected_date,status,policy_id,detailed_balance,payments_details,membership_id,retry_status)
                VALUES(now(),now(),0,get_premium_amount(_imported_member.member_import_product),now(),'paid',_policy_id,'{}','{}',_membership_id,'Unknown');
                
                INSERT into payments_policypayment(created,modified,premium,vat,state,type,payment_due_date,policy_id,extra_premium,membership_id)
                values(now(),now(),get_premium_amount(_imported_member.member_import_product),0,'SUCCESSFUL','Debit Order',now(),_policy_id,0,_membership_id);
            end if;
		
    end loop;
end;
$$

-- drop table
drop table member_import;