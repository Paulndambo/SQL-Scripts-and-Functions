DROP TABLE IF EXISTS member_import;
CREATE TABLE member_import (
	import_id serial PRIMARY KEY,
	policy_number VARCHAR ( 250 ) UNIQUE NOT NULL,
	identification_number VARCHAR ( 250 ) NOT NULL,
	policy_type VARCHAR(255) NOT NULL,
	pricing_group VARCHAR(255) NOT NULL,
	start_date VARCHAR ( 255 ) NOT NULL,
    first_name VARCHAR (255) NOT NULL, 
    last_name VARCHAR (255) NOT NULL,
	identification_method INT NOT NULL CHECK (identification_method >= 0 and identification_method <= 1),
	gender VARCHAR (255) NOT NULL,
    physical_address VARCHAR ( 255 ) NOT NULL,
	postal_address VARCHAR ( 255 ),
    occupation VARCHAR ( 255 ),
	mobile_number VARCHAR ( 255 ) NOT NULL,
    email VARCHAR ( 255 ) NOT NULL,
    sum_insured DECIMAL NOT NULL,
    premium DECIMAL NOT NULL,
    insurer_name VARCHAR ( 255 ) NOT NULL
);

do $$
declare
	_credit_life_record record;
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
	_user_identification_method text;
	_premium decimal;
    _qoute_id int;
	_cycle_id int;
	_pricing_group_name text;
	_pricing_plan_id int;
	_username_exists BOOLEAN;
	_id_number_exists BOOLEAN;
	_user_profile_id int;
begin
FOR _credit_life_record in select * from member_import
    LOOP
		-- Check if the username already exists in the users_user table
        SELECT 1 FROM users_user WHERE username = _credit_life_record.email INTO _username_exists;

        -- If the username already exists, continue to the next iteration of the loop
        IF _username_exists THEN
            CONTINUE;
        END IF;
		
				
		-- Check if the id_number already exists in the users_profile table
		SELECT 1 FROM users_profile WHERE id_number = _credit_life_record.identification_number INTO _id_number_exists;
		-- If the id_number already exists, continue to the next iteration of the loop
        IF _id_number_exists THEN
            CONTINUE;
        END IF;

		-- create user
		INSERT INTO users_user (password,is_superuser,username,first_name,last_name,is_staff,is_active,date_joined,created,modified,email,role,sent_emails,reset_password)
        VALUES ('temp_password',false,_credit_life_record.email,_credit_life_record.first_name,_credit_life_record.last_name,false,true,now(),now(),now(),_credit_life_record.email,'individual',0,false)
        RETURNING id INTO _user_id;


		-- create user profile
    	if _credit_life_record.identification_method = 1 then
			INSERT INTO users_profile(created,modified,user_id,first_name,last_name,id_number,date_of_birth,gender,occupation,address,phone,address1,phone1)
			VALUES(now(),now(),_user_id,_credit_life_record.first_name,_credit_life_record.last_name,_credit_life_record.identification_number,DATE(get_date_of_bith(_credit_life_record.identification_number)),_credit_life_record.gender,_credit_life_record.occupation,_credit_life_record.physical_address,_credit_life_record.mobile_number,'','')
			RETURNING id INTO _user_profile_id;
		else
			INSERT INTO users_profile(created,modified,user_id,first_name,last_name,passport_number,date_of_birth,gender,address,phone,address1,phone1)
			VALUES(now(),now(),_user_id,_credit_life_record.first_name,_credit_life_record.last_name,_credit_life_record.identification_number,DATE(get_date_of_bith(_credit_life_record.identification_number)),_credit_life_record.gender,_credit_life_record.occupation,_credit_life_record.physical_address,_credit_life_record.mobile_number,'','')
			RETURNING id INTO _user_profile_id;
		end if;


		-- create individual user
		INSERT INTO users_individualuser (user_id)
		VALUES (_user_id)
		RETURNING id INTO _individual_user_id;
		
		-- create policy holder using S.A if provided
    	if _credit_life_record.identification_method = 1 then
			INSERT INTO users_policyholder(name,address,phone_number,id_number,individual_user_id,date_of_birth,gender,address1,phone,phone1)
			VALUES (_credit_life_record.first_name,_credit_life_record.physical_address,_credit_life_record.mobile_number,_credit_life_record.identification_number,_individual_user_id,DATE(get_date_of_bith(_credit_life_record.identification_number)),_credit_life_record.gender,_credit_life_record.physical_address,_credit_life_record.mobile_number,_credit_life_record.mobile_number)
			RETURNING id INTO _policy_holder_id;
		else
			INSERT INTO users_policyholder(name,address,phone_number,passport_number,individual_user_id,date_of_birth,gender,address1,phone,phone1)
			VALUES (_credit_life_record.first_name,_credit_life_record.physical_address,_credit_life_record.mobile_number,_credit_life_record.identification_number,_individual_user_id,DATE(get_date_of_bith(_credit_life_record.identification_number)),_credit_life_record.gender,_credit_life_record.physical_address,_credit_life_record.mobile_number,_credit_life_record.mobile_number)
			RETURNING id INTO _policy_holder_id;
		end if;


		-- create scheme group
		INSERT INTO schemes_schemegroup (created,modified,scheme_id,description,name,payment_method,period_frequency,period_type,pricing_group,cycle_type) 
		VALUES (now(),now(),1,_credit_life_record.pricing_group,CONCAT(_credit_life_record.first_name,' ',_credit_life_record.last_name),'debit_order',1,'MONTH',_credit_life_record.pricing_group,'MEMBER_CYCLE')
		RETURNING id, pricing_group INTO _scheme_group_id, _pricing_group_name;


		-- create membership
		INSERT INTO users_membership(created,modified,user_id,scheme_group_id,member_id,properties)
		VALUES (now(),now(),_user_id,_scheme_group_id, gen_random_uuid(),'{}')
		RETURNING id INTO _membership_id;

		-- get the pricing plan id
		SELECT get_pricing_plan_id(_pricing_group_name) INTO _pricing_plan_id;


		-- create membership config
		INSERT INTO users_membershipconfiguration(created,modified,membership_id,cover_level,pricing_plan_id)
		VALUES (now(),now(),_membership_id,20000,_pricing_plan_id);

		-- create unpdaid payment records
		INSERT into payments_policypremium(created,modified,balance,expected_payment,expected_date,status,policy_id,detailed_balance,payments_details,membership_id,retry_status)
		VALUES(now(),now(),0,_credit_life_record.premium,now(),'unpaid',_policy_id,'{}','{}',_membership_id,'Unknown');


		-- create policy
		INSERT INTO policies_policy(policy_holder_id,created,modified,policy_number,amount,start_date,payment_due_day,payment_frequency,status,terms_and_conditions_accepted,claim_lodging_awaiting_period,insurance_product_id,creator_id,proxy_purchase,is_group_policy,dg_required,config,policy_number_counter,policy_document,welcome_letter)
		VALUES (_policy_holder_id,now(),now(),_credit_life_record.policy_number,_credit_life_record.premium::double precision,TO_CHAR(now(), 'yyyy-mm-01')::date,2,'Monthly','active',true,0,1,_user_id,'false','false','false','{}',1,'','false')
		RETURNING id INTO _policy_id;
		
		-- create entry in policy details table
		INSERT INTO policy_details(created,modified,extra_premium,policy_id,funeral_policy_details,activation_details)
		VALUES (now(),now(),0,_policy_id,'{}','{}');
		
		-- update membership with policy id
		UPDATE schemes_schemegroup
		SET policy_id = _policy_id
		where id = _scheme_group_id;
		
        -- create a generic policy price request
        INSERT INTO generic_policy_prices_policypricerequest(created,modified,market_value,policy_id,is_embedded)
        VALUES (now(),now(),'0',_policy_id,'false')
        RETURNING id INTO _qoute_id;


		-- create scheme qoute 
        INSERT INTO schemes_quote(created,modified,value,period,period_frequency,component_id,membership_id,price_request_id,active)
		VALUES (now(),now(),_credit_life_record.premium::double precision,'MONTH','1','1',_membership_id,_qoute_id,'true'); -- credit life is one for compnent id and 2 for funeral

		-- membership cycle record
		INSERT INTO policies_cycle(created,modified,status,membership_id,scheme_group_id)
		VALUES (now(),now(),'awaiting_payment',_membership_id,_scheme_group_id)
		RETURNING id INTO _cycle_id;

		-- policy cycle status update 
		INSERT INTO policies_cyclestatusupdates(created,modified,previous_status,next_status,cycle_id)
		VALUES (now(),now(),'draft','created',_cycle_id);

		-- create the next status 
		INSERT INTO policies_cyclestatusupdates(created,modified,previous_status,next_status,cycle_id)
		VALUES (now(),now(),'created','awaiting_payment',_cycle_id);


    END LOOP;
end; $$