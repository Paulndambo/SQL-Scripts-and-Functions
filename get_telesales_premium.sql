CREATE OR REPLACE FUNCTION get_specific_membership_premium(_membership_id int)
RETURNS integer 
LANGUAGE plpgsql
AS $$
DECLARE 
    _membership_id int;
    _membership_premium int;
    _pricing_plan text;
    _scheme_group_id int;
    _scheme_group record;
    _cover_level int;
BEGIN 
    SELECT scheme_group_id INTO _scheme_group_id FROM users_membership WHERE id = _membership_id;
    SELECT pricing_group INTO _pricing_plan FROM schemes_schemegroup WHERE id = _scheme_group_id;
    
    _membership_premium = get_premium_for_telesales(_membership_id);
    RETURN _membership_premium;
END;
$$;