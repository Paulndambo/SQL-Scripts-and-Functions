CREATE OR REPLACE FUNCTION public.get_membership_configuration_id(
	_id_number text,
	_policy_number text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $$
DECLARE
	_membership_id int;
	_membership_configuration_id int;
	_user_id int;
	_scheme_group_id int;
	_policy_id int;
BEGIN
	SELECT policies_policy.id INTO _policy_id FROM policies_policy WHERE policy_number=_policy_number;
	SELECT schemes_schemegroup.id INTO _scheme_group_id FROM schemes_schemegroup WHERE policy_id = _policy_id;
	SELECT users_profile.user_id INTO _user_id FROM users_profile WHERE id_number=_id_number;
	SELECT users_membership.id INTO _membership_id FROM users_membership WHERE user_id=_user_id AND scheme_group_id=_scheme_group_id;
	SELECT users_membershipconfiguration.id INTO _membership_configuration_id FROM users_membershipconfiguration WHERE membership_id=_membership_id;
   return _membership_configuration_id;
END;
$$;


CREATE OR REPLACE FUNCTION get_membership_configuration_id_updated(_id_number text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $$
DECLARE
	_membership_id int;
	_membership_configuration_id int;
	_user_id int;
BEGIN
	SELECT users_profile.user_id INTO _user_id FROM users_profile WHERE id_number = _id_number; 
	SELECT users_membership.id INTO _membership_id FROM users_membership WHERE user_id=_user_id LIMIT 1;
	SELECT users_membershipconfiguration.id INTO _membership_configuration_id FROM users_membershipconfiguration WHERE membership_id=_membership_id AND beneficiary_id IS NULL;
   return _membership_configuration_id;
END;
$$;


CREATE OR REPLACE FUNCTION get_membership_configuration_id_updated_passport_number(_passport_number text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $$
DECLARE
	_membership_id int;
	_membership_configuration_id int;
	_user_id int;
BEGIN
	SELECT users_profile.user_id INTO _user_id FROM users_profile WHERE passport_number = _passport_number; 
	SELECT users_membership.id INTO _membership_id FROM users_membership WHERE user_id=_user_id LIMIT 1;
	SELECT users_membershipconfiguration.id INTO _membership_configuration_id FROM users_membershipconfiguration WHERE membership_id=_membership_id AND beneficiary_id IS NULL;
   return _membership_configuration_id;
END;
$$;


