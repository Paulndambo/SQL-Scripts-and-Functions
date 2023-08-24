do $$
declare
	_funeral_dependent record;
begin
FOR _funeral_dependent in select * from dependent_import
    LOOP
		if _funeral_dependent.identification_method = 1 then
			INSERT INTO prices_dependent(created,modified,is_additional_family_member,dependent_type,dependent_type_notes,membership_configuration_id,cover_level,age_max,age_metric,age_min,date_of_birth,first_name,gender,guid,last_name,relative_id,relative_option,id_number,is_deleted,identification_number)
			
            VALUES(now(),now(),true,get_relation_type(_funeral_dependent.dependent_type),null,get_membership_configuration_id(_funeral_dependent.main_member_identification_number, 'SYN_132'),_funeral_dependent.cover_level,null,'years',null,_funeral_dependent.date_of_birth,
				_funeral_dependent.firstname,_funeral_dependent.gender,gen_random_uuid(),_funeral_dependent.lastname,get_relative_id(_funeral_dependent.dependent_type),
				get_relation_type(_funeral_dependent.dependent_type),_funeral_dependent.indentification_number,false,_funeral_dependent.indentification_number);
		--else
		--	INSERT INTO prices_dependent(created,modified,is_additional_family_member,dependent_type,dependent_type_notes,membership_configuration_id,cover_level,age_max,age_metric,age_min,date_of_birth,first_name,gender,guid,last_name,relative_id,relative_option,passport_number)
		--	VALUES(now(),now(),false,lower(_funeral_dependent.format_dependents_relationship),null,get_membership_config_id(_funeral_dependent.format_dependents_nda_policy_number),_funeral_dependent.format_dependents_cover_level,null,'years',null,DATE(_funeral_dependent.format_dependents_date_of_birth),
	    --			_funeral_dependent.format_dependents_first_name,_funeral_dependent.format_dependents_gender,gen_random_uuid(),_funeral_dependent.format_dependents_last_name,get_relative_type_id(lower(_funeral_dependent.format_dependents_relationship)),
		--		lower(_funeral_dependent.format_dependents_relationship),_funeral_dependent.format_dependents_identification_number);
		end if;
    END LOOP;
end; $$