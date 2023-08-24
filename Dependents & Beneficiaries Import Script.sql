-- dependents import script
do $$
declare
	_funeral_dependent record;
begin
FOR _funeral_dependent in select * from format_dependents
    LOOP
		if _funeral_dependent.format_dependents_identification_method = 1 then
			INSERT INTO prices_dependent(created,modified,is_additional_family_member,dependent_type,dependent_type_notes,membership_configuration_id,cover_level,age_max,age_metric,age_min,date_of_birth,first_name,gender,guid,last_name,relative_id,relative_option,id_number)
			VALUES(now(),now(),false,lower(_funeral_dependent.format_dependents_relationship),null,get_membership_config_id(_funeral_dependent.format_dependents_nda_policy_number),_funeral_dependent.format_dependents_cover_level,null,'years',null,DATE(_funeral_dependent.format_dependents_date_of_birth),
				_funeral_dependent.format_dependents_first_name,_funeral_dependent.format_dependents_gender,gen_random_uuid(),_funeral_dependent.format_dependents_last_name,get_relative_type_id(lower(_funeral_dependent.format_dependents_relationship)),
				lower(_funeral_dependent.format_dependents_relationship),_funeral_dependent.format_dependents_identification_number);
		else
			INSERT INTO prices_dependent(created,modified,is_additional_family_member,dependent_type,dependent_type_notes,membership_configuration_id,cover_level,age_max,age_metric,age_min,date_of_birth,first_name,gender,guid,last_name,relative_id,relative_option,passport_number)
			VALUES(now(),now(),false,lower(_funeral_dependent.format_dependents_relationship),null,get_membership_config_id(_funeral_dependent.format_dependents_nda_policy_number),_funeral_dependent.format_dependents_cover_level,null,'years',null,DATE(_funeral_dependent.format_dependents_date_of_birth),
				_funeral_dependent.format_dependents_first_name,_funeral_dependent.format_dependents_gender,gen_random_uuid(),_funeral_dependent.format_dependents_last_name,get_relative_type_id(lower(_funeral_dependent.format_dependents_relationship)),
				lower(_funeral_dependent.format_dependents_relationship),_funeral_dependent.format_dependents_identification_number);
		end if;
    END LOOP;
end; $$

-- Beneficiaries import script
do $$
declare
	_funeral_beneficiarie record;
	_beneficiarie_id int;
begin
FOR _funeral_beneficiarie in select * from format_beneficiarie
    LOOP
		if _funeral_beneficiarie.format_beneficiarie_identification_method = 1 then
			INSERT INTO dependents_funeralbeneficiary(created,modified,first_name,last_name,phone_number,id_number,policy_id,email,is_deleted,date_of_birth,
	relative_id,guardian_or_trustee_first_name,guardian_or_trustee_last_name,guardian_or_trustee_phone_number
	,guardian_or_trustee_date_of_birth)
			VALUES(now(),now(),_funeral_beneficiarie.format_beneficiarie_first_name,_funeral_beneficiarie.format_beneficiarie_last_name,_funeral_beneficiarie.format_credit_life_mobile_number,
			_funeral_beneficiarie.format_beneficiarie_identification_number,null,
			null,false,DATE(_funeral_beneficiarie.format_beneficiarie_date_of_birth),get_relative_type_id(lower(_funeral_beneficiarie.format_beneficiarie_relationship)),
			null,null,null,null)
			RETURNING id INTO _beneficiarie_id;
			insert into users_membershipconfiguration (created,modified,beneficiary_id,membership_id,cover_level,pricing_plan_id)
			values(now(),now(), _beneficiarie_id,get_membership_id(_funeral_beneficiarie.format_beneficiarie_nda_policy_number),5000,1);
		else
			INSERT INTO dependents_funeralbeneficiary( created,modified,first_name,last_name,phone_number,passport_number,policy_id,email,is_deleted,date_of_birth,
	relative_id,guardian_or_trustee_first_name,guardian_or_trustee_last_name,guardian_or_trustee_phone_number
	,guardian_or_trustee_date_of_birth)
			VALUES(now(),now(),_funeral_beneficiarie.format_beneficiarie_first_name,_funeral_beneficiarie.format_beneficiarie_last_name,_funeral_beneficiarie.format_credit_life_mobile_number,
			_funeral_beneficiarie.format_beneficiarie_identification_number,null,
			null,false,DATE(_funeral_beneficiarie.format_beneficiarie_date_of_birth),get_relative_type_id(lower(_funeral_beneficiarie.format_beneficiarie_relationship)),
			null,null,null,null)
			RETURNING id INTO _beneficiarie_id;
			insert into users_membershipconfiguration (created,modified,beneficiary_id,membership_id,cover_level,pricing_plan_id)
			values(now(),now(), _beneficiarie_id,get_membership_id(_funeral_beneficiarie.format_beneficiarie_nda_policy_number),5000,1);
		end if;
    END LOOP;
end; $$