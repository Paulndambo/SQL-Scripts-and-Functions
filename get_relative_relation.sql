CREATE OR REPLACE FUNCTION get_relation_type(_dependent_type text)
RETURNs text
LANGUAGE 'plpgsql'
AS 
$$
DECLARE
    _relation_type text;
    
BEGIN
    IF _dependent_type IN ('Son', 'Daughter', 'Child') THEN _relation_type = 'child';
    ELSEIF _dependent_type IN ('Spouse', 'Partner', 'Husband', 'Wife', 'spouse', 'husband', 'wife', 'partner') THEN _relation_type = 'spouse';
    ELSIF _dependent_type = 'Adult Child' THEN _relation_type = 'adult_child';
    ELSIF _dependent_type = 'Minor Child' THEN _relation_type = 'minor_child';
    ELSIF _dependent_type = 'Sibling In-Law' THEN _relation_type = 'sibling_in_law';
    ELSIF _dependent_type = 'Parent In-Law' THEN _relation_type = 'parent_in_law';
    ELSIF _dependent_type = 'Senior Citizen Parent' THEN _relation_type = 'senior_citizen_parent';
    ELSE _relation_type = lower(_dependent_type)

    END IF;
    RETURN _relation_type;
END;
$$;