do $$
declare
	_funeral_dependent record;
begin
FOR _funeral_dependent in select * from dependent_import
    LOOP
		if _funeral_dependent.identification_method = 1 then
			INSERT INTO prices_dependent(created,modified,is_additional_family_member,dependent_type,dependent_type_notes,membership_configuration_id,cover_level,age_max,age_metric,age_min,date_of_birth,first_name,gender,guid,last_name,relative_id,relative_option,id_number)
			VALUES(now(),now(),false,get_relation_type(_funeral_dependent.dependent_type),null,get_membership_configuration_id_updated(_funeral_dependent.main_member_identification_number),_funeral_dependent.cover_level,null,'years',null,DATE(get_date_of_bith(_funeral_dependent.indentification_number)),
				_funeral_dependent.firstname,get_gender(_funeral_dependent.gender),gen_random_uuid(),_funeral_dependent.lastname,get_relative_id(_funeral_dependent.dependent_type),get_relation_type(_funeral_dependent.dependent_type),_funeral_dependent.indentification_number)

    END LOOP;
end; $$