-- FUNCTION: public.get_synergy_dependents_cover_level(text, text)

-- DROP FUNCTION IF EXISTS public.get_synergy_dependents_cover_level(text, text)

CREATE OR REPLACE FUNCTION public.get_synergy_dependents_cover_level(
	_id_number text,
	_dependent_type text)
RETURNS integer
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
_cover_level int
_date_of_birth date
_age int

BEGIN
SELECT get_date_of_bith(_id_number) INTO _date_of_birth
SELECT EXTRACT(YEAR FROM age(cast(_date_of_birth as date))) INTO _age
IF _dependent_type = 'Spouse' AND _age BETWEEN 18 AND 65 THEN _cover_level = 35000
ELSIF _dependent_type IN('Daughter', 'Son', 'Child') AND _age BETWEEN 14 AND 21 THEN _cover_level = 27000
ELSIF _dependent_type IN('Daughter', 'Son', 'Child') AND _age BETWEEN 6 AND 13 THEN _cover_level = 18000
ELSIF _dependent_type IN('Daughter', 'Son', 'Child') AND _age BETWEEN 1 AND 5 THEN _cover_level = 12500
ELSIF _dependent_type = 'Stillborn' AND _age < 1 THEN _cover_level = 12500
END IF

return _cover_level
END
$BODY$

ALTER FUNCTION public.get_synergy_dependents_cover_level(text, text)
OWNER TO postgres
