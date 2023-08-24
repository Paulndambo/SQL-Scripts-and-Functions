CREATE FUNCTION get_profile(identification_number VARCHAR) RETURNS INT AS $$
DECLARE
    profile_id INT;
BEGIN
    SELECT id INTO profile_id
    FROM users_profile
    WHERE id_number = identification_number
    ORDER BY created DESC
    LIMIT 1;

    IF profile_id IS NOT NULL THEN
        RETURN profile_id;
    ELSE
        RETURN NULL;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_membership(pr_id_number VARCHAR) RETURNS INT AS $$
DECLARE
    profile_id INT;
    membership_id INT;
BEGIN
    SELECT id INTO profile_id
    FROM users_profile
    WHERE id_number = pr_id_number
    ORDER BY created DESC
    LIMIT 1;

    IF profile_id IS NOT NULL THEN
        SELECT id INTO membership_id
        FROM users_membership
        WHERE user_id = (SELECT user_id FROM users_profile WHERE id = profile_id)
        ORDER BY created DESC
        LIMIT 1;

        IF membership_id IS NOT NULL THEN
            RETURN membership_id;
        END IF;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION get_membership_configuration(um_id INT) RETURNS INT AS $$
DECLARE
    membership_config_id INT;
BEGIN
    SELECT id INTO membership_config_id
    FROM users_membershipconfiguration
    WHERE membership_id = um_id
      AND beneficiary_id IS NULL
    ORDER BY created DESC
    LIMIT 1;

    IF membership_config_id IS NOT NULL THEN
        RETURN membership_config_id;
    ELSE
        RETURN NULL;
    END IF;
END;
$$ LANGUAGE plpgsql;
