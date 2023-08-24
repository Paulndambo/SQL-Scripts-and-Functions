## Active Transition
CREATE OR REPLACE FUNCTION policy_transition_updated()
RETURNS text
LANGUAGE PLPGSQL
AS
$$
DECLARE
    _cycle record;
BEGIN
    FOR _cycle IN SELECT * FROM policies_cycle WHERE status='active' 
    LOOP 
        INSERT INTO policies_cyclestatusupdates(created,modified,previous_status,next_status,cycle_id)
        VALUES('2023-05-30','2023-05-30','awaiting_payment','active',_cycle.id);
    END LOOP;
    RETURN _cycle.status;
END;
$$;



CREATE OR REPLACE FUNCTION policy_transition_task()
RETURNS text
LANGUAGE PLPGSQL
AS
$$
DECLARE
    _cycle record;
BEGIN
    FOR _cycle IN SELECT * FROM policies_cycle
        WHERE id NOT IN (
            SELECT cycle_id FROM policies_cyclestatusupdates
	        WHERE DATE(created) BETWEEN '2023-07-01' AND '2023-07-31'
        ) AND status = 'active'
    LOOP 
        INSERT INTO policies_cyclestatusupdates(created,modified,previous_status,next_status,cycle_id)
        VALUES('2023-07-31','2023-07-31','awaiting_payment','active',_cycle.id);
    END LOOP;
    RETURN 'Done!';
END;
$$;








## Cancelled Transition
CREATE OR REPLACE FUNCTION policy_cancelled_transition()
RETURNS text
LANGUAGE PLPGSQL
AS
$$
DECLARE
    _cycle record;
BEGIN
    FOR _cycle IN SELECT * FROM policies_cycle WHERE status='cancelled'
    LOOP 
        INSERT INTO policies_cyclestatusupdates(created,modified,previous_status,next_status,cycle_id)
        VALUES('2023-03-21','2023-03-21','active','cancelled',_cycle.id);
    END LOOP;
    RETURN _cycle.status;
END;
$$;

## Transition Awaiting Payment
CREATE OR REPLACE FUNCTION policy_awaiting_transition()
RETURNS text
LANGUAGE PLPGSQL
AS
$$
DECLARE
    _cycle record;
BEGIN
    FOR _cycle IN SELECT * FROM policies_cycle WHERE status='awaiting_payment'
    LOOP 
        INSERT INTO policies_cyclestatusupdates(created,modified,previous_status,next_status,cycle_id)
        VALUES(_cycle.created,_cycle.modified,'created','awaiting_payment',_cycle.id);
    END LOOP;
    RETURN _cycle.status;
END;
$$;


BETWEEN '2023-06-01' AND '2023-06-30'