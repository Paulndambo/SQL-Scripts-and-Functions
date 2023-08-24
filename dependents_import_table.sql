CREATE TABLE dependent_import(
    dependent_import_id serial PRIMARY KEY,
    main_member_identification_number VARCHAR NOT NULL,
    use_type VARCHAR NOT NULL,
    dependent_type VARCHAR NOT NULL,
    cover_level BIGINT,
    firstname VARCHAR NOT NULL,
    lastname VARCHAR NOT NULL,
    identification_method INT NOT NULL CHECK (identification_method >= 0 and identification_method <= 1),
    indentification_number VARCHAR NOT NULL,
    date_of_birth DATE,
    gender VARCHAR,
    product INT NOT NULL
)

CREATE TABLE IF NOT EXISTS public.dependent_import
(
    dependent_import_id integer NOT NULL DEFAULT nextval('dependent_import_dependent_import_id_seq'::regclass),
    main_member_identification_number character varying COLLATE pg_catalog."default" NOT NULL,
    use_type character varying COLLATE pg_catalog."default" NOT NULL,
    dependent_type character varying COLLATE pg_catalog."default" NOT NULL,
    cover_level bigint,
    firstname character varying COLLATE pg_catalog."default" NOT NULL,
    lastname character varying COLLATE pg_catalog."default" NOT NULL,
    identification_method integer NOT NULL,
    indentification_number character varying COLLATE pg_catalog."default" NOT NULL,
    date_of_birth date,
    gender character varying COLLATE pg_catalog."default",
    product integer NOT NULL,
    CONSTRAINT dependent_import_pkey PRIMARY KEY (dependent_import_id),
    CONSTRAINT dependent_import_indentification_number_key UNIQUE (indentification_number),
    CONSTRAINT dependent_import_identification_method_check CHECK (identification_method >= 0 AND identification_method <= 1)
)
