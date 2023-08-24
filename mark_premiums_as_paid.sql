CREATE OR REPLACE FUNCTION mark_premiums_as_paid()
returns text
language plpgsql
as
$$
declare
    _payment record;
    _latest_payment integer;
    _membership_id integer;
begin
    for _payment in select * from cancellation_data
    loop	      -- get the user id
        _membership_id = get_membership_id_updated(_payment.identification_number);
        SELECT id INTO _latest_payment FROM payments_policypremium WHERE membership_id = _membership_id AND status = 'unpaid' AND expected_date BETWEEN '2023-04-01' AND  ORDER BY expected_date DESC LIMIT 1;
        UPDATE payments_policypremium SET status = 'paid' WHERE id = _latest_payment;
    end loop;
    RETURN _payment.identification_number;
end;
$$;


CREATE OR REPLACE FUNCTION mark_premiums_as_paid()
returns text
language plpgsql
as
$$
declare
    _payment record;
    _latest_payment integer;
    _membership_id integer;
begin
    for _payment in select * from cancellation_data
    loop	      -- get the user id
        _membership_id = get_membership_id_updated(_payment.member_import_identification_number);
        SELECT id INTO _latest_payment FROM payments_policypremium WHERE membership_id = _membership_id AND status = 'unpaid' ORDER BY expected_date DESC LIMIT 1;
        UPDATE payments_policypremium SET status = 'paid' WHERE id = _latest_payment;
    end loop;
    RETURN _payment.member_import_identification_number;
end;
$$;