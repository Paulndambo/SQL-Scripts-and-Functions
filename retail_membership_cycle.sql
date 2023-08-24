do $$
declare 
    _membership record;
begin
FOR _membership IN SELECT * FROM users_membership
    LOOP
        IF get_scheme_id(_membership.scheme_group_id) = 1  then
            INSERT INTO policies_cycle(created, modified, status, membership_id, scheme_group_id)
            VALUES(now(), now(), 'active', _membership.id, _membership.scheme_group_id);
        END IF;
    END LOOP;
end; $$