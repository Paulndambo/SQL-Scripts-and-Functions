CREATE OR REPLACE FUNCTION get_membership_premium_amount() 
RETURNS integer
language plpgsql
as
$$
declare
 _membership record;
 _membership_id integer;
 _premium decimal;
 _scheme_group_id integer;
 _latest_premium integer;
 _pricing_plan text;
 _policy_id integer;
begin
    for _membership in select * from users_membership
    loop	      -- get the user id
        SELECT pricing_group INTO _pricing_plan FROM schemes_schemegroup WHERE id = _membership.scheme_group_id;
		--SELECT policy_id INTO _policy_id FROM schemes_schemegroup WHERE id = _membership.scheme_group_id;
        _premium = get_premium_amount_updated(_pricing_plan);
        IF check_if_premium_exists(_membership.id) = false THEN
            IF get_membership_policy_id(_membership.id) IS NOT NULL THEN
                INSERT into payments_policypremium(created,modified,balance,expected_payment,expected_date,status,policy_id,detailed_balance,payments_details,membership_id,retry_status)
                VALUES(now(),now(),0,_premium,DATE('2023-01-01'),'unpaid',get_membership_policy_id(_membership.id),'{}','{}',_membership.id,'Unknown');
            END IF;
        END IF;
    end loop;
    RETURN _premium;
end;
$$;

CREATE OR REPLACE FUNCTION get_membership_policy_id(_membership_id int)  
RETURNS integer
language plpgsql
as
$$
declare
    _policy_id integer;
    _scheme_group_id integer;
begin
    SELECT scheme_group_id INTO _scheme_group_id FROM users_membership WHERE id = _membership_id;
    SELECT policy_id INTO _policy_id FROM schemes_schemegroup WHERE id = _scheme_group_id;
    RETURN _policy_id;
end;
$$;