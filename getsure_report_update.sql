CREATE OR REPLACE FUNCTION getsure_policy_lapse_dates_matching()
returns text
language plpgsql
as
$$
declare
    _policy record;
begin
    for _policy in select * from policies_policystatusupdates WHERE next_status = 'lapsed'
    loop	      -- get the user id
        UPDATE members_report
        SET policy_status_date = DATE(_policy.lapse_date)
        WHERE policy_id = _policy.policy_id;
    end loop;
    RETURN 'Lapse Dates Fully Updated';
end;
$$;