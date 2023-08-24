CREATE OR REPLACE FUNCTION get_premium_for_telesales(_membership_id int)
RETURNS integer 
LANGUAGE plpgsql
AS $$
DECLARE 
    _premium int;
    _cover_level int;
BEGIN 
    SELECT cover_level INTO _cover_level FROM users_membershipconfiguration WHERE membership_id=_membership_id;
    IF _cover_level = 20000 THEN 
        _premium := 74;
    ELSIF _cover_level = 10000 THEN 
        _premium := 38;
    ELSIF _cover_level = 5000:
        _premium := 20;
    END IF; 
    RETURN _premium; 
END;
$$;