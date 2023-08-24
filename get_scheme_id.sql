CREATE OR REPLACE FUNCTION get_scheme_id(_scheme_group_id int)
RETURNS integer
LANGUAGE 'plpgsql'
AS $$
DECLARE
    _scheme_id int;
BEGIN
    SELECT scheme_id INTO _scheme_id FROM schemes_schemegroup WHERE id = _scheme_group_id;
    RETURN _scheme_id;
END;
$$;