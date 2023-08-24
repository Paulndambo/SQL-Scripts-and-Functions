
CREATE OR REPLACE FUNCTION get_legacy_extended_premium(_age int, _cover_level int)
RETURNS int
LANGUAGE 'plpgsql'
AS 
$$
DECLARE
    --_age int;
    _level_premium decimal;

BEGIN
    --SELECT get_date_of_bith(_id_number) INTO _date_of_birth;
    --SELECT EXTRACT(YEAR FROM age(_date_of_birth)) INTO _age;

    IF _cover_level = 20000 AND _age >= 75 THEN _level_premium = 182.15;
    ELSIF _cover_level = 20000 AND _age BETWEEN 65 AND 74 THEN _level_premium = 78.01;
    ELSIF _cover_level = 20000 AND _age BETWEEN 0 AND 64 THEN _level_premium = 25.94;
    ELSIF _cover_level = 15000 AND _age >= 75 THEN _level_premium = 136.67;
    ELSIF _cover_level = 15000 AND _age BETWEEN 65 AND 74 THEN _level_premium = 58.46;
    ELSIF _cover_level = 15000 AND _age BETWEEN 0 AND 64 THEN _level_premium = 19.55;
    ELSIF _cover_level = 10000 AND _age >= 75 THEN _level_premium = 90.97;
    ELSIF _cover_level = 10000 AND _age BETWEEN 65 AND 74 THEN _level_premium = 39.10;
    ELSIF _cover_level = 10000 AND _age BETWEEN 0 AND 64 THEN _level_premium = 12.98;
    END IF;
    return _level_premium;
END;
$$;



CREATE OR REPLACE FUNCTION add_addon_premiums()
returns text
language plpgsql
as
$$
declare
    _age integer;
    _cover_level integer;
    _level_premium decimal;
	_dependent record;

begin
    for _dependent in select * from prices_dependent WHERE is_additional_family_member = true AND DATE(created) = '2023-03-14' AND add_on_premium IS NULL
    loop	      -- get the user id
        _age = get_age(_dependent.id_number);
        IF _cover_level = 20000 AND _age >= 75 THEN _level_premium = 182.15;
            ELSIF _dependent.cover_level = 20000 AND _age BETWEEN 65 AND 74 THEN _level_premium = 78.01;
            ELSIF _dependent.cover_level = 20000 AND _age BETWEEN 0 AND 64 THEN _level_premium = 25.94;
            ELSIF _dependent.cover_level = 15000 AND _age >= 75 THEN _level_premium = 136.67;
            ELSIF _dependent.cover_level = 15000 AND _age BETWEEN 65 AND 74 THEN _level_premium = 58.46;
            ELSIF _dependent.cover_level = 15000 AND _age BETWEEN 0 AND 64 THEN _level_premium = 19.55;
            ELSIF _dependent.cover_level = 10000 AND _age >= 75 THEN _level_premium = 90.97;
            ELSIF _dependent.cover_level = 10000 AND _age BETWEEN 65 AND 74 THEN _level_premium = 39.10;
            ELSIF _dependent.cover_level = 10000 AND _age BETWEEN 0 AND 64 THEN _level_premium = 12.98;
        END IF;

        UPDATE prices_dependent
        SET add_on_premium = _level_premium
        WHERE id = _dependent.id;
        
    end loop;
    RETURN 'Hello World!!';
end;
$$;



