CREATE OR REPLACE FUNCTION raise_future_premiums()
returns text
language plpgsql
as
$$
declare
 _policy_premium record;
begin
    for _policy_premium in select * from payments_policypremium where expected_date BETWEEN '2023-05-01' AND '2023-05-31'
    loop	      -- get the user id
        INSERT into payments_policypremium(created,modified,balance,expected_payment,expected_date,status,policy_id,detailed_balance,payments_details,membership_id,retry_status)
		VALUES(now(),now(),-_policy_premium.expected_payment,_policy_premium.expected_payment,DATE('2023-06-24'),'unpaid',_policy_premium.policy_id,'{}','{}',_policy_premium.membership_id,'Unknown');
    end loop;
    return 'new premiums raised';
end;
$$;


