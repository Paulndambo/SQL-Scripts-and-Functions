CREATE OR REPLACE FUNCTION check_if_cycle_exists(_membership_id integer)
RETURNS boolean
LANGUAGE 'plpgsql'
AS $$
DECLARE
    _cycle_exists boolean;
    _cycle_id integer;
BEGIN
    SELECT id INTO _cycle_id FROM policies_cycle WHERE membership_id=_membership_id;
    IF _cycle_id IS NOT NULL THEN _cycle_exists = true;
    ELSIF _cycle_id IS NULL THEN _cycle_exists = false;
    END IF;
    RETURN _cycle_exists;
END;
$$;