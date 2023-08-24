CREATE OR REPLACE FUNCTION update_synergy_member_addresses(_policy_id integer)
returns text
language plpgsql
as
$$
declare
    _payment record;
    _latest_payment integer;
    _membership_id integer;
begin
    SELECT id INTO 
end;
$$;