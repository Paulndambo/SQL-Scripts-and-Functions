CREATE OR REPLACE FUNCTION get_last_policy_id()
returns text
language plpgsql
as
$$
declare
 _last_policy_id integer;
begin
    SELECT id INTO _last_policy_id FROM policies_policy ORDER BY id DESC LIMIT 1
    RETURN _last_policy_id + 1;
end;
$$;

CREATE FUNCTION get_last_mbd_policy_id_updated() RETURNS INTEGER AS $$
    DECLARE
        last_policy_id INTEGER;
        next_policy_id INTEGER;
    BEGIN
        SELECT id INTO last_policy_id
        FROM policies_policy
        WHERE policy_number LIKE 'MBD%'
        ORDER BY id DESC
        LIMIT 1;
        
        next_policy_id := last_policy_id + 1;
        
        RETURN next_policy_id;
    END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION generate_mbd_policy_numbers(last_policy_id INTEGER, user_id INTEGER) RETURNS TEXT AS $$
DECLARE
    policy_number_t TEXT := 'MBD_' || last_policy_id;
    policy_exists BOOLEAN;
    policy_number_str TEXT;
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM policies_policy
        WHERE policy_number = policy_number_t
    ) INTO policy_exists;
    
    IF policy_exists THEN
        policy_number_str := 'MBD_' || last_policy_id || user_id;
    ELSE
        policy_number_str := policy_number_t;
    END IF;

    RETURN policy_number_str;
END;
$$ LANGUAGE plpgsql;
