-- FUNCTION: public.get_membership_id_1(text, text)

-- DROP FUNCTION IF EXISTS public.get_membership_id_1(text, text);

CREATE OR REPLACE FUNCTION public.get_membership_id(
	_id_number text,
	_policy_number text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $$
DECLARE
	_membership_id int;
	_user_id int;
	_scheme_group_id int;
	_policy_id int;
BEGIN
	SELECT policies_policy.id INTO _policy_id FROM policies_policy WHERE policy_number=_policy_number;
	SELECT schemes_schemegroup.id INTO _scheme_group_id FROM schemes_schemegroup WHERE policy_id = _policy_id;
	SELECT users_profile.user_id INTO _user_id FROM users_profile WHERE id_number=_id_number;
	SELECT users_membership.id INTO _membership_id FROM users_membership WHERE user_id=_user_id AND scheme_group_id=_scheme_group_id;
   return _membership_id;
END;
$$;

CREATE OR REPLACE FUNCTION get_member_id(_id_number)
RETURNS integer
LANGUAGE 'plpgsql'
AS $$
DECLARE
	_membership_id integer;
	_user_id integer;
BEGIN

$$;