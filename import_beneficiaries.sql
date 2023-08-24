do $$
declare
	_funeral_beneficiarie record;
	_beneficiarie_id int;
begin
FOR _funeral_beneficiarie in select * from dependent_import
    LOOP
		if _funeral_beneficiarie.use_type = 'Beneficiary' AND _funeral_beneficiarie.identification_method = 1 then
			INSERT INTO dependents_funeralbeneficiary(created,modified,first_name,last_name,phone_number,id_number,policy_id,email,is_deleted,date_of_birth,
	relative_id,guardian_or_trustee_first_name,guardian_or_trustee_last_name,guardian_or_trustee_phone_number,guardian_or_trustee_date_of_birth)
			VALUES(now(),now(),_funeral_beneficiarie.firstname,_funeral_beneficiarie.lastname,null,_funeral_beneficiarie.indentification_number,null,
			null,false,DATE(get_date_of_bith(_funeral_beneficiarie.indentification_number)),get_relative_id(_funeral_beneficiarie.dependent_type),
			null,null,null,null)

			RETURNING id INTO _beneficiarie_id;
			insert into users_membershipconfiguration(created,modified,beneficiary_id,membership_id,cover_level,pricing_plan_id)
			values(now(),now(), _beneficiarie_id,get_membership_id_updated(_funeral_beneficiarie.main_member_identification_number),5000,4);
		end if;
    END LOOP;
end; $$