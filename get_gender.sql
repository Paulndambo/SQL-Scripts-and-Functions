-- FUNCTION: public.get_gender(text)

-- DROP FUNCTION IF EXISTS public.get_gender(text);

CREATE OR REPLACE FUNCTION public.get_gender(
	_sa_id_number text)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
   _gender text;
   _id_gender_identifier text;
   
begin
	_id_gender_identifier := substring(_sa_id_number from 7 for 4);
	
	-- get gender
	if _id_gender_identifier::smallint >= 5000 then
	  _gender := 'MALE';
	else
	  _gender := 'FEMALE';
	END if;
	
	return _gender;
end;
$BODY$;

ALTER FUNCTION public.get_gender(text)
    OWNER TO postgres;
