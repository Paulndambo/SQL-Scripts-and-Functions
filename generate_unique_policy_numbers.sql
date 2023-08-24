CREATE OR REPLACE FUNCTION generate_unique_policy_number()
RETURNS integer
LANGUAGE plpgsql
AS
$$
DECLARE
    _latest_policy_id int;
    _new_policy_id int;
BEGIN
    SELECT id INTO _latest_policy_id FROM policies_policy ORDER BY id DESC LIMIT 1;
    _new_policy_id = SUM(_latest_policy_id)
    RETURN _premium_exists;
END;
$$;
