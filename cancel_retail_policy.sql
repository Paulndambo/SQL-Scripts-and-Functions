DO $$
DECLARE 
    _policy record;
    _member record;
    _membership_id integer;
    _policy_id integer;
BEGIN
FOR _member IN SELECT * FROM cancellation_data
    LOOP
    _policy_id = get_retail_scheme_policy_id(_member.member_import_identification_number);

    UPDATE policies_policy SET status = LOWER(_member.action_type) WHERE id = _policy_id;

    --INSERT INTO policies_policycancellation(created,modified,policy_id,status,cancellation_origin,phone_number,bank_account,branch_code,bank_id,cancel_reason,policy_previous_status,refund_amount,payment_reference)
    --VALUES(now(),now(),_policy_id,'confirmed','insurer',null,null,null,null,'No Payment','active',0,null);

    --INSERT INTO policies_policystatusupdates(created,modified,policy_id,previous_status,next_status)
    --VALUES(now(),now(),_policy_id,'active',LOWER(_member.action_type));

    --INSERT INTO policies_policymovement(created,modified,policy_id,type,effective_date,short_description)
    --VALUES(now(),now(),_policy_id,LOWER(_member.action_type),now(),'No Payment');

    _membership_id = get_membership_id_updated(_member.member_import_identification_number);
    IF check_if_cycle_exists(_membership_id) = true THEN
        UPDATE policies_cycle SET status='cancelled' WHERE membership_id=_membership_id;
        RAISE NOTICE 'new membership cycle status for % is cancelled', _membership_id;

        INSERT INTO policies_cyclestatusupdates(created,modified,cycle_id,previous_status,next_status)
		VALUES(now(),now(),get_cycle_id(_membership_id),'active','cancelled');
    END IF;

    END LOOP;
END;
$$;