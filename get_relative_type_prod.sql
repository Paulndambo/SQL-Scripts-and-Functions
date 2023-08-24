CREATE OR REPLACE FUNCTION get_relative_id(_dependent_type text)
RETURNs int
LANGUAGE 'plpgsql'
AS 
$$
DECLARE
    _relative_id int;
BEGIN
    IF _dependent_type IN ('Son', 'son', 'Daughter', 'daughter', 'DAUGHTER' 'Child') THEN _relative_id = 4;
    ELSIF _dependent_type IN ('Spouse', 'spouse', 'Partner', 'partner', 'Wife', 'wife', 'HUSBAND', 'Husband', 'husband', 'SPOUSE') THEN _relative_id = 3;
    ELSIF _dependent_type IN ('Mother', 'Father', 'Parent', 'mother', 'father', 'parent', 'Step Mother', 'Step Father') THEN _relative_id = 5;
    ELSIF _dependent_type = 'Stillborn' THEN _relative_id = 19;
    ELSIF _dependent_type IN ('Sibling', 'Brother', 'Sister', 'brother', 'sister', 'SISTER') THEN _relative_id = 7;
    ELSIF _dependent_type = 'Adult Child' THEN _relative_id = 6;
    ELSIF _dependent_type = 'Aunt' THEN _relative_id = 8;
    ELSIF _dependent_type = 'Uncle' THEN _relative_id = 9;
    ELSIF _dependent_type IN ('Cousin', 'cousin', 'COUSIN') THEN _relative_id = 10;
    ELSIF _dependent_type = 'Niece' THEN _relative_id = 11;
    ELSIF _dependent_type = 'Nephew' THEN _relative_id = 12;
    ELSIF _dependent_type IN ('Grandchild', 'Granddaughter', 'Grandson') THEN _relative_id = 13;
    ELSIF _dependent_type IN ('Grandparent', 'Grandfather', 'Grandmother') THEN _relative_id = 14;
    ELSIF _dependent_type = 'Minor Child' THEN _relative_id = 15;
    ELSIF _dependent_type IN ('Sibling In-Law', 'Brother in law', 'Brother-in-law', 'Sister in law', 'Son in law', 'Daughter in law') THEN _relative_id = 16;
    ELSIF _dependent_type IN ('Parent In-Law', 'Mother in law', 'Father in law') THEN _relative_id = 17;
    ELSIF _dependent_type = 'Senior Citizen Parent' THEN _relative_id = 18;
    ELSIF _dependent_type = 'Guardian' THEN _relative_id = 21;
    ELSIF _dependent_type = 'Friend' THEN _relative_id = 20;
    END IF;
    RETURN _relative_id;
END;
$$;

