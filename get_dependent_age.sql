
CREATE OR REPLACE FUNCTION get_age(_id_number text)
RETURNS int
LANGUAGE 'plpgsql'
AS 
$$
DECLARE
    _date_of_birth date;
    _age int;

BEGIN
    SELECT get_date_of_bith(_id_number) INTO _date_of_birth;
    SELECT EXTRACT(YEAR FROM age(cast(_date_of_birth as date))) INTO _age;
    return _age;
END;
$$;