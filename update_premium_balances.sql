CREATE OR REPLACE FUNCTION update_policy_premium_balances()
returns text
language plpgsql
as
$$
declare
 _policy_premium record;
begin
    for _policy_premium in select * from payments_policypremium where status = 'unpaid' and balance = 0;
    loop	      -- get the user id
        UPDATE payments_policypremium
        SET balance = -abs(_policy_premium.balance)
        WHERE id = _policy_premium.id;
    end loop;
    return 'new premiums raised'
end;
$$;