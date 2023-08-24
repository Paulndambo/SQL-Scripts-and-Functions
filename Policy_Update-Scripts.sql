--  Create temporary table to hold the policy details
CREATE TABLE temp_policy_details_update (
	"id" serial PRIMARY KEY,
	identification_method INT NOT NULL CHECK (identification_method >= 0 and identification_method <= 1),
	identification_number VARCHAR UNIQUE NOT NULL,
	action_type VARCHAR ( 250 ) NOT NULL,
	reference_reason VARCHAR ( 250 ) NOT NULL
);

do $$
declare
	_policy_update_record record;
	_user_id int;
	_membership_id int;
	_scheme_group_id int;
	_scheme_id int;
	_is_group_scheme boolean;
	_policy_id int;
begin
FOR _policy_update_record in select * from temp_policy_details_update
    LOOP
	
	-- 	get user by id or passport
	if _policy_update_record.identification_method = '1' then
		select users_profile.user_id into _user_id from users_profile where id_number = _policy_update_record.identification_number;
		raise notice 'user id is: % and identification method is %',_user_id,'id number';
	else
		select users_profile.user_id into _user_id from users_profile where passport_number = _policy_update_record.identification_number;
		raise notice 'user id is: % and identification method is %',_user_id,'passport';
	end if;
	
	
	-- get scheme group id from membership table
	select users_membership.scheme_group_id into _scheme_group_id from users_membership where user_id = _user_id;
	-- get membership id
	select users_membership.id into _membership_id from users_membership where user_id = _user_id;
	-- get policy id from scheme_group table 
	select schemes_schemegroup.policy_id into _policy_id from schemes_schemegroup where id = _scheme_group_id;
	-- get scheme id from scheme group table
	select schemes_schemegroup.scheme_id into _scheme_id from schemes_schemegroup where id = _scheme_group_id;
	-- get check if it's a group scheme or not
	select schemes_scheme.is_group_scheme into _is_group_scheme from schemes_scheme where id = _scheme_id;

	
	raise notice 'policy to update is: %',_policy_id;
	
	if _is_group_scheme = true then
		-- update membership
		insert into policies_cycle(created,modified,status,membership_id)
		values(now(),now(),lower(_policy_update_record.action_type),_membership_id);
	else
		-- update policy
		update policies_policy set status = lower(_policy_update_record.action_type), sub_status = _policy_update_record.reference_reason where policies_policy.id = _policy_id;
	end if;

	
    END LOOP;
end; $$