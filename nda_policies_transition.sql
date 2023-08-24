CREATE OR REPLACE FUNCTION policy_transition()
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
        VALUES('2023-07-29','2023-07-29','awaiting_payment','active',_cycle.id);
    END LOOP;
    RETURN _cycle.status;
END;
$$;

