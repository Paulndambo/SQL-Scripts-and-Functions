CREATE OR REPLACE FUNCTION get_retail_scheme_policy_id(_id_number text)
RETURNS integer
LANGUAGE 'plpgsql'
AS $$
DECLARE
    _membership_id int;
    _scheme_group_id int;
    _policy_id int;
BEGIN
    SELECT get_membership_id_updated(_id_number) INTO _membership_id;
    SELECT users_membership.scheme_group_id INTO _scheme_group_id FROM users_membership WHERE id = _membership_id;
    SELECT schemes_schemegroup.policy_id INTO _policy_id FROM schemes_schemegroup WHERE id = _scheme_group_id;
    RETURN _policy_id;
END;
$$;