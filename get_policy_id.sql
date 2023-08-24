-- FUNCTION: public.get_membership_id_1(text, text)

-- DROP FUNCTION IF EXISTS public.get_membership_id_1(text, text);

CREATE OR REPLACE FUNCTION public.get_membership_id(_policy_number text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $$
DECLARE
	_policy_id int;
BEGIN
	SELECT policies_policy.id INTO _policy_id FROM policies_policy WHERE policy_number=_policy_number;
   return _policy_id;
END;
$$;

