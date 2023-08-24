CREATE OR REPLACE FUNCTION check_if_premium_exists(_membership_id int)
returns boolean 
language plpgsql
as
$$
declare
    _premium_id int;
    _premium_exists boolean;
begin
    SELECT id INTO _premium_id FROM payments_policypremium WHERE membership_id = _membership_id AND expected_date = DATE('2023-01-01');
    IF  _premium_id IS NOT NULL THEN _premium_exists = true;
    ELSIF _premium_id IS NULL THEN _premium_exists = false;
    END IF;
        
    --for _membership in select * from users_membership
    --loop	      -- get the user id
    --    SELECT id INTO _premium FROM payments_policypremium WHERE membership_id = _membership_id AND expected_date = '2022-01-01';
     --   IF _premium IS NOT NULL THEN 
      --      RAISE NOTICE 'Membership %, has %, Premium', _membership.id, '2023-01-01';
      --  ELSIF _premium IS NULL THEN 
       --     RAISE NOTICE 'Membership %, has no premium for %', _membership.id, '2023-01-01';
        --END IF;
        --INSERT into payments_policypremium(created,modified,balance,expected_payment,expected_date,status,policy_id,detailed_balance,payments_details,membership_id,retry_status)
		--VALUES(now(),now(),0,_policy_premium.expected_payment,DATE('2022-12-01'),'unpaid',_policy_premium.policy_id,'{}','{}',_policy_premium.membership_id,'Unknown');
    --end loop;
    RETURN _premium_exists;
end;
$$;

