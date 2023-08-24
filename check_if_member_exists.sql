create or replace function check_if_member_exists()
returns text
language plpgsql
as
$$
declare
	_id_number text;
    _user_profile record;
    _member record;
begin
    for _member in select * from cancellation_data
    loop
		_user_profile = select * from users_profile where id_number = _member.main_member_import_identification_number limit 1

        if not exists _user_profile then
            raise _member.main_member_import_identification_number
		--_previous_status:= 'awaiting_payment';
		--_cycle_id:= _policy_cycle.id;
		_next_status := 'active';


		-- create new cyclestatusupdates entry
		insert into policies_cyclestatusupdates(created,modified,previous_status,next_status,cycle_id)
		values('2022-12-20 13:04:27.150118+00','2022-12-20 13:04:27.150118+00',_previous_status,_next_status,_cycle_id);

   end loop;
   
   return 'Done!';
end;
$$














