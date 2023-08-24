CREATE OR REPLACE FUNCTION get_membership_id_updated(_id_number text)
RETURN integer
LANGUAGE 'plpgsql'
AS $$
DECLARE
    _membership_id int;
    _user_id int;
    _scheme_group_id int;
    _policy_id int;
    _profile_id int;
BEGIN
    SELECT users_profile.user_id INTO _user_id FROM users_profile WHERE id_number = _id_number;
    SELECT users_membership.id INTO _membership_id FROM users_membership WHERE user_id = _user_id;
    RETURN _membership_id;
END;
$$;


CREATE OR REPLACE FUNCTION get_cycle_id(_membership_id integer)
RETURNS integer
LANGUAGE 'plpgsql'
AS $$
DECLARE
    _cycle_id integer;
BEGIN
    SELECT policies_cycle.id INTO _cycle_id FROM policies_cycle WHERE membership_id = _membership_id;
    RETURN _cycle_id;
END;
$$;

DO $$
DECLARE 
    _member record;
    _membership_id integer;
    _cycle_id integer;
BEGIN
FOR _member IN SELECT * FROM cancellation_data
    LOOP
    _membership_id = get_membership_id_updated(_member.identification_number);
    IF check_if_cycle_exists(_membership_id) = true THEN
        UPDATE policies_cycle SET status='cancelled' WHERE membership_id=_membership_id;
        RAISE NOTICE 'new membership cycle status for % is cancelled', _membership_id;

        INSERT INTO policies_cyclestatusupdates(created,modified,cycle_id,previous_status,next_status)
		VALUES(now(),now(),get_cycle_id(_membership_id),'active','cancelled');
    END IF;
    END LOOP;
END;
$$;


DO $$
DECLARE 
    _member RECORD;
    _membership_id integer;
    _cycle_id integer;
BEGIN
FOR _member IN SELECT * FROM cancellation_data
    LOOP
    _membership_id = get_membership_id_updated(_member.member_import_identification_number);
    IF check_if_cycle_exists(_membership_id) = true THEN
        UPDATE policies_cycle SET status='cancelled', modified=now() WHERE membership_id=_membership_id;
        RAISE NOTICE 'new membership cycle status for % is cancelled', _membership_id;

        INSERT INTO policies_cyclestatusupdates(created,modified,cycle_id,previous_status,next_status)
		VALUES(now(),now(),get_cycle_id(_membership_id),'active','cancelled');
    END IF;
    END LOOP;
END;
$$;


DO $$
DECLARE 
    _cycle_id integer;
    _cycle_status_id integer;
    _cycle record;
BEGIN
FOR _cycle IN SELECT * FROM policies_cycle WHERE status = 'cancelled' AND DATE(modified) = '2023-03-24'
    LOOP
        SELECT id INTO _cycle_status_id FROM policies_cyclestatusupdates WHERE cycle_id=_cycle.id AND next_status = 'active' ORDER BY id DESC LIMIT 1;
        UPDATE policies_cyclestatusupdates SET previous_status = 'active', next_status='cancelled' 
        WHERE id = _cycle_status_id AND cycle_id=_cycle.id;

    END IF;
    END LOOP;
END;
$$;

