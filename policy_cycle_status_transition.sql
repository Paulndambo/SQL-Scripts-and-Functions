## Active Transition
CREATE OR REPLACE FUNCTION policy_cycle_status_transition()
RETURNS text
LANGUAGE PLPGSQL
AS
$$
DECLARE
    _cs record;
BEGIN
    FOR _cs IN SELECT * FROM policies_cyclestatusupdates WHERE next_status='active' AND DATE(created) BETWEEN '2023-01-01' AND '2023-01-31'
    LOOP 
        INSERT INTO policies_cyclestatusupdates(created,modified,previous_status,next_status,cycle_id)
        VALUES('2023-02-07','2023-02-07','awaiting_payment','active',_cs.cycle_id);
    END LOOP;
    RETURN _cycle.status;
END;
$$;