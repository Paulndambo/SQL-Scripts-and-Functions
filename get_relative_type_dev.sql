CREATE OR REPLACE FUNCTION get_relative_id(_dependent_type text)
RETURNs int
LANGUAGE 'plpgsql'
AS 
$$
DECLARE
    _relative_id int;
BEGIN
    IF _dependent_type IN ('Son', 'Daughter', 'DAUGHTER', 'Child') THEN _relative_id = 4;
    ELSIF _dependent_type IN ('Spouse', 'Partner', 'partner', 'Wife', 'wife', 'HUSBAND', 'Husband', 'husband', 'SPOUSE') THEN _relative_id = 3;
    ELSIF _dependent_type IN ('Mother', 'Father', 'Parent', 'mother', 'father', 'parent') THEN _relative_id = 5;
    ELSIF _dependent_type = 'Stillborn' THEN _relative_id = 22;
    ELSIF _dependent_type IN ('Sibling', 'Brother', 'Sister', 'brother', 'sister', 'SISTER') THEN _relative_id = 7;
    ELSIF _dependent_type = 'Adult Child' THEN _relative_id = 6;
    ELSIF _dependent_type = 'Aunt' THEN _relative_id = 8;
    ELSIF _dependent_type = 'Uncle' THEN _relative_id = 9;
    ELSIF _dependent_type = 'Cousin' THEN _relative_id = 10;
    ELSIF _dependent_type = 'Niece' THEN _relative_id = 11;
    ELSIF _dependent_type = 'Nephew' THEN _relative_id = 12;
    ELSIF _dependent_type = 'Grandchild' THEN _relative_id = 13;
    ELSIF _dependent_type IN ('Grandparent', 'Grandfather', 'Grandmother') THEN _relative_id = 14;
    ELSIF _dependent_type = 'Minor Child' THEN _relative_id = 15;
    ELSIF _dependent_type = 'Sibling In-Law' THEN _relative_id = 16;
    ELSIF _dependent_type = 'Parent In-Law' THEN _relative_id = 17;
    ELSIF _dependent_type = 'Senior Citizen Parent' THEN _relative_id = 18;
    ELSIF _dependent_type = 'Guardian' THEN _relative_id = 24;
    ELSIF _dependent_type = 'Friend' THEN _relative_id = 23;
    END IF;
    RETURN _relative_id;
END;
$$;