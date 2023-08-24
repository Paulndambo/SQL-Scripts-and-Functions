CREATE OR REPLACE FUNCTION set_membership_configuration_id()
returns text
language plpgsql
as
$$
declare
    _member record;
    _membership_config_id integer;
begin
    for _member in select * from cancellation_data
    loop	      -- get the user id
        _membership_config_id = get_membership_configuration_id_updated(_member.member_import_identification_number);
        UPDATE prices_dependent
        SET membership_configuration_id = _membership_config_id, modified=now()
        WHERE id_number = _member.dependent_id_number AND membership_configuration_id IS NULL AND DATE(created) = '2023-03-14' AND is_additional_family_member = true;
    end loop;
    RETURN 'Hello World!!';
end;
$$;