-- 
select * from member_import
select * from users_user order by id desc
select * from users_individualuser order by id desc
select * from users_policyholder order by id desc
select * from schemes_schemegroup order by id desc
select * from users_membership order by id desc
select * from users_membershipconfiguration order by id desc
select * from policies_policy order by id desc
select * from policy_details order by id desc
select * from payments_policypremium order by id desc

delete from users_user where email in ('jalome+csvtest1@click2sure.co.za','jalome+csvtest2@click2sure.co.za','jalome+csvtest3@click2sure.co.za')
delete from users_policyholder where individual_user_id in (15249,15250,15251)
delete from users_individualuser where user_id in (16148,16149,16150)

delete from users_user_notification_type
where user_id in (16148,16149,16150)
/* functions */
-- function to calculate individual's age
-- and determine if user is eligble or not
create or replace function validate_age(_sa_id_number text)
returns bool
language plpgsql
as
$$
declare
   _age smallint;
   _id_first_num text;
   _birth_day text;
   _birth_month text;
   _birth_year text;
   _full_date_of_birth text;
   _age_is_valid bool;
   
begin
	_id_first_num := substring(_sa_id_number from 1 for 1);
	_birth_year := substring(_sa_id_number from 1 for 2);
	_birth_month := substring(_sa_id_number from 3 for 2);
	_birth_day := substring(_sa_id_number from 5 for 2);
	
	-- get date of birth
	if _id_first_num = '0' then
	  _full_date_of_birth := CONCAT('20',_birth_year,'-',_birth_month,'-',_birth_day);
	else
	  _full_date_of_birth := CONCAT('19',_birth_year,'-',_birth_month,'-',_birth_day);
	END if;
	
	-- calculate user's age
	_age := date_part('year',age(CURRENT_DATE,_full_date_of_birth::date));
	
	-- check if age is valid
	if _age >= 18 and _age <= 64 then
	  _age_is_valid := true;
	else
	  _age_is_valid := false;
	END if;
	
	return _age_is_valid;
end;
$$;

select validate_age('2001014800086');
DROP FUNCTION validate_age(text)

-- function to get date or birth from id number
create or replace function get_date_of_bith(_sa_id_number text)
returns text
language plpgsql
as
$$
declare
   _id_first_num text;
   _birth_day text;
   _birth_month text;
   _birth_year text;
   _full_date_of_birth text;
   
begin
	_id_first_num := substring(_sa_id_number from 1 for 1);
	_birth_year := substring(_sa_id_number from 1 for 2);
	_birth_month := substring(_sa_id_number from 3 for 2);
	_birth_day := substring(_sa_id_number from 5 for 2);
	
	-- get date of birth
	if _id_first_num = '0' then
	  _full_date_of_birth := CONCAT('20',_birth_year,'-',_birth_month,'-',_birth_day);
	else
	  _full_date_of_birth := CONCAT('19',_birth_year,'-',_birth_month,'-',_birth_day);
	END if;
	
	return _full_date_of_birth;
end;
$$;

select get_date_of_bith('2001014800086')


-- function to get gender from id number
create or replace function get_gender(_sa_id_number text)
returns text
language plpgsql
as
$$
declare
   _gender text;
   _id_gender_identifier text;
   
begin
	_id_gender_identifier := substring(_sa_id_number from 7 for 4);
	
	-- get gender
	if _id_gender_identifier::smallint >= 5000 then
	  _gender := 'MALE';
	else
	  _gender := 'FEMALE';
	END if;
	
	return _gender;
end;
$$;

select get_gender('2001014800086')



-- function to get identification method
create function get_identification_method(_identification_method_id int)
returns text
language plpgsql
as
$$
declare
   _identification_method text;
begin
	if _identification_method_id = 0 then
	  _identification_method := 'Passport';
	else
	  _identification_method := 'South African ID';
	END if;
   
   return _identification_method;
end;
$$;

select get_identification_method(1)

-- function to get pricing plan
create function get_pricing_plan(_pricing_id int)
returns text
language plpgsql
as
$$
declare
   _pricing_plan text;
begin
	if _pricing_id = 0 then
	  _pricing_plan := 'Synergy';
	elsif _pricing_id = 6 then
	  _pricing_plan := 'Nutun MBD Legal Collections Legacy';
	elsif _pricing_id = 9 then
		_pricing_plan := 'Nutun Kwande Legacy';
	elsif _pricing_id = 7 then 
		_pricing_plan := 'Nutun Business Services SA Legacy';
	elsif _pricing_id = 5 then
		_pricing_plan := 'Nutun Munnik Basson Da Gama Inc Legacy';
	elsif _pricing_id = 3 then
		_pricing_plan := 'Nutun Wellness Legacy';
	elsif _pricing_id = 4 then
		_pricing_plan := 'Nutun Transact Legacy';
	END if;
   	return _pricing_plan;
end;
$$;

select get_pricing_plan(0);


create or replace function get_policy_number_prefix(_pricing_id int)
returns text
language plpgsql
as
$$
declare
   _policy_number_prefix text;
begin

	if _pricing_id = 0 then
	  _policy_number_prefix := 'SYN_';
	elsif _pricing_id = 6 then
	  _policy_number_prefix := 'NMBD_';
	elsif _pricing_id = 9 then
		_policy_number_prefix := 'NKL_';
	elsif _pricing_id = 7 then 
		_policy_number_prefix := 'NBSL_';
	elsif _pricing_id = 5 then
		_policy_number_prefix := 'NMBL_';
	elsif _pricing_id = 3 then
		_policy_number_prefix := 'NWL_';
	elsif _pricing_id = 4 then
		_policy_number_prefix := 'NTL_';
	END if;

   return _policy_number_prefix;
end;
$$;


-- function to get premium amount 
create or replace function get_premium_amount(_pricing_plan text)
returns decimal
language plpgsql
as
$$
declare
   _premium decimal;
begin
	_premium := 40.00;
   return _premium;
end;
$$;

select get_premium_amount('Synergy')

-- function to validate id number
create or replace function id_is_valid(_sa_id_number text)
returns bool
language plpgsql
as
$$
declare
   _id_is_valid bool;
   _id_number_count smallint;
   _id_number_sum smallint;
   _id_checksum smallint;
   _id_last_digit smallint;
   _id_number_parity smallint;
   _current_id_number text;
   _id_num text;
begin

	_id_number_count := length(_sa_id_number);
	if _id_number_count = 13 then
		_id_number_sum := 0;
		_id_number_parity := _id_number_count % 2;
		-- iterate through the id number to compute the sum   
		FOR _number in 1..(_id_number_count-1)
    		LOOP
				-- get all digits along with their indexes except the last digit
				_current_id_number := substring(_sa_id_number from _number for 1);
				-- double every second second digit
				if _number % 2 != _id_number_parity then
					_current_id_number := _current_id_number::smallint*2;
				end if;
				raise notice 'counter: %',concat(_number, _current_id_number);
				-- substract a 9 to all values greater than 10
				if _current_id_number::smallint > 9 then
					_current_id_number := _current_id_number::smallint-9;
				end if;
				-- compute the sum of all digits
				_id_number_sum := _current_id_number::smallint + _id_number_sum;
				
		END LOOP;
		-- multiply the sum by 9
		_id_number_sum := _id_number_sum * 9;
		-- compute the checksum digit
		_id_checksum := _id_number_sum % 10;
		
	else
	  _id_is_valid := false;
	END if;
	
	-- compare checksum with last digit
	_id_last_digit := substring(_sa_id_number from 13 for 1);
	if _id_last_digit::smallint = _id_checksum then
		_id_is_valid := true;
	else
	 	_id_is_valid := false;
	end if;
	
   return _id_is_valid;
end;
$$;

select id_is_valid('2001014800086')

/* functions */


-- create the table where data will be temporarily imported into
CREATE TABLE member_import (
	member_import_id serial PRIMARY KEY,
	member_import_username VARCHAR ( 250 ) UNIQUE NOT NULL,
	member_import_first_name VARCHAR ( 250 ) NOT NULL,
	member_import_last_name VARCHAR ( 250 ) NOT NULL,
	member_import_email VARCHAR ( 255 ) UNIQUE NOT NULL,
	member_import_identification_method INT NOT NULL CHECK (member_import_identification_method >= 0 and member_import_identification_method <= 1),
	member_import_identification_number VARCHAR UNIQUE NOT NULL,
	member_import_mobile_number VARCHAR NOT NULL,
	member_import_landline VARCHAR ( 25 ),
	member_import_date_of_birth VARCHAR ( 25 ),
	member_import_physical_address VARCHAR ( 255 ) NOT NULL,
	member_import_postal_address VARCHAR ( 255 ),
	member_import_gender VARCHAR ( 25 ), 
	member_import_product INT NOT NULL
);





-- partial import script
do $$
declare
	_imported_member record;
	_user_id int;
	_scheme_group_id int;
	_membership_id int;
	_policy_id int;
	_individual_user_id int;
	_policy_holder_id int;
	_sa_id_is_valid bool;
	_user_age_is_valid bool;
	_user_geder text;
	_user_date_of_birth text;
	_user_pricing_plan text;
	_product_id int;
	_user_identification_method text;
	_premium decimal;
	_cycle_id int;
begin

	-- get the product id from the first row
	select member_import_product into _product_id from member_import limit 1;

	-- create synergy scheme group
	INSERT INTO schemes_schemegroup (created,modified,scheme_id,description,name,payment_method,period_frequency,period_type,pricing_group,cycle_type) 
	VALUES (now(),now(),3,get_pricing_plan_updated(_product_id),get_pricing_plan_updated(_product_id),'off_platform',1,'MONTH',get_pricing_plan_updated(_product_id),'MEMBER_CYCLE')
	RETURNING id INTO _scheme_group_id;

	INSERT INTO policies_policy(created,modified,policy_number,amount,start_date,payment_due_day,payment_frequency,status,terms_and_conditions_accepted,claim_lodging_awaiting_period,insurance_product_id,creator_id,proxy_purchase,is_group_policy,dg_required,config,policy_number_counter,policy_document,welcome_letter)
	VALUES (now(),now(),CONCAT(get_policy_number_prefix_updated(_product_id),_scheme_group_id),0,TO_CHAR(now(), 'yyyy-mm-01')::date,2,'monthly','active',true,0,1,_user_id,'false','false','false','{}',1,'','')
	RETURNING id INTO _policy_id;

	-- create entry in policy details table
	INSERT INTO policy_details(created,modified,extra_premium,policy_id,funeral_policy_details,activation_details)
	VALUES (now(),now(),0,_policy_id,'{}','{}');


	UPDATE schemes_schemegroup
	SET policy_id = _policy_id
	where id = _scheme_group_id;

FOR _imported_member in select * from member_import
    LOOP
		raise notice 'counter: %',concat('member ', _imported_member.member_import_username);
		-- first check the identification method and assign variables
		_user_pricing_plan := get_pricing_plan_updated(_product_id);
		_user_identification_method := get_identification_method(_imported_member.member_import_identification_method);
		if _user_identification_method = 'South African ID' and validate_age(_imported_member.member_import_identification_number) = true and id_is_valid(_imported_member.member_import_identification_number) = true then
			_user_geder := get_gender(_imported_member.member_import_identification_number);
			_user_date_of_birth := get_date_of_bith(_imported_member.member_import_identification_number);
		else
			_user_geder := _imported_member.member_import_gender;
			_user_date_of_birth := _imported_member.member_import_date_of_birth;
		end if;


		-- check if the user already exists 
		IF EXISTS (select * from users_profile where id_number = _imported_member.member_import_identification_number) then
			raise notice 'User exists';
			-- get the user id
			select user_id into _user_id from users_profile where id_number = _imported_member.member_import_identification_number;
			-- get individual user id
			select id into _individual_user_id from users_individualuser where user_id = _user_id;
			-- get policy holder id 
			select id into _policy_holder_id from users_policyholder where individual_user_id = _user_id;
		ELSE
			raise notice 'User does notexists';
			-- create user
			INSERT INTO users_user (password,is_superuser,username,first_name,last_name,is_staff,is_active,date_joined,created,modified,email,role,sent_emails,reset_password)
			VALUES ('temp_password',false,_imported_member.member_import_username,_imported_member.member_import_first_name,_imported_member.member_import_last_name,false,true,now(),now(),now(),_imported_member.member_import_email,'individual',0,false)
			RETURNING id INTO _user_id;


			-- create user profile
			if _user_identification_method = 'South African ID' then
				INSERT INTO users_profile(created,modified,user_id,first_name,last_name,id_number,date_of_birth,gender,address,phone,address1,phone1)
				VALUES(now(),now(),_user_id,_imported_member.member_import_first_name,_imported_member.member_import_last_name,_imported_member.member_import_identification_number,DATE(_user_date_of_birth),_user_geder,_imported_member.member_import_physical_address,_imported_member.member_import_mobile_number,'','');
			else
				INSERT INTO users_profile(created,modified,user_id,first_name,last_name,passport_number,date_of_birth,gender,address,phone,address1,phone1)
				VALUES(now(),now(),_user_id,_imported_member.member_import_first_name,_imported_member.member_import_last_name,_imported_member.member_import_identification_number,DATE(_imported_member.member_import_date_of_birth),_imported_member.member_import_gender,_imported_member.member_import_physical_address,_imported_member.member_import_mobile_number,'','');
			end if;

			-- create individual user
			INSERT INTO users_individualuser (user_id)
			VALUES (_user_id)
			RETURNING id INTO _individual_user_id;


			-- create policy holder using S.A if provided
			-- if not passport
			if _user_identification_method = 'South African ID' then
				INSERT INTO users_policyholder(name,address,phone_number,id_number,individual_user_id,date_of_birth,gender,address1,phone,phone1)
				VALUES (_imported_member.member_import_first_name,_imported_member.member_import_physical_address,_imported_member.member_import_mobile_number,_imported_member.member_import_identification_number,_individual_user_id,DATE(_user_date_of_birth),_user_geder,_imported_member.member_import_physical_address,_imported_member.member_import_mobile_number,_imported_member.member_import_landline)
				RETURNING id INTO _policy_holder_id;
			else
				INSERT INTO users_policyholder(name,address,phone_number,passport_number,individual_user_id,date_of_birth,gender,address1,phone,phone1)
				VALUES (_imported_member.member_import_first_name,_imported_member.member_import_physical_address,_imported_member.member_import_mobile_number,_imported_member.member_import_identification_number,_individual_user_id,DATE(_imported_member.member_import_date_of_birth),_imported_member.member_import_gender,_imported_member.member_import_physical_address,_imported_member.member_import_mobile_number,_imported_member.member_import_landline)
				RETURNING id INTO _policy_holder_id;
			end if;
		END IF;
			
				
		-- create membership
		INSERT INTO users_membership(created,modified,user_id,scheme_group_id,member_id,properties)
		VALUES (now(),now(),_user_id,_scheme_group_id,gen_random_uuid(),'{}')
		RETURNING id INTO _membership_id;

		--create cycle
		INSERT INTO policies_cycle(created,modified,membership_id,scheme_group_id, status)
		VALUES (now(),now(),_membership_id, _scheme_group_id, 'active')
		RETURNING id INTO _cycle_id;

		--create cycle status update
		INSERT INTO policies_cyclestatusupdates(created,modified,cycle_id,previous_status,next_status)
		VALUES(now(),now(),_cycle_id,'awaiting_payment','active');
		
		-- create membership config
		INSERT INTO users_membershipconfiguration(created,modified,membership_id,cover_level)
		VALUES (now(),now(),_membership_id,50000);		


		-- create unpaid payment records
		INSERT into payments_policypremium(created,modified,balance,expected_payment,expected_date,status,policy_id,detailed_balance,payments_details,membership_id,retry_status)
		VALUES(now(),now(),0,get_premium_amount(_user_pricing_plan),now(),'unpaid',_policy_id,'{}','{}',_membership_id,'Unknown');
		
		INSERT into payments_policypayment(created,modified,premium,vat,state,type,payment_due_date,policy_id,extra_premium,membership_id)
		values(now(),now(),get_premium_amount(_user_pricing_plan),0,'SUCCESSFUL','Off Platform',now(),_policy_id,0,_membership_id);
    END LOOP;

end; $$


-- delete temp table
DROP TABLE member_import;