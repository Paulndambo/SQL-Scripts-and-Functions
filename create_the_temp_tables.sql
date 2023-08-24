-- Table: public.format_beneficiarie

-- DROP TABLE IF EXISTS public.format_beneficiarie;

CREATE TABLE IF NOT EXISTS public.format_beneficiarie
(
    format_beneficiarie_id integer NOT NULL DEFAULT nextval('format_beneficiarie_format_beneficiarie_id_seq'::regclass),
    format_beneficiarie_nda_policy_number character varying(255) COLLATE pg_catalog."default",
    format_beneficiarie_first_name character varying(250) COLLATE pg_catalog."default" NOT NULL,
    format_beneficiarie_last_name character varying(250) COLLATE pg_catalog."default" NOT NULL,
    format_beneficiarie_identification_method integer NOT NULL,
    format_beneficiarie_identification_number character varying COLLATE pg_catalog."default" NOT NULL,
    format_beneficiarie_relationship character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_beneficiarie_date_of_birth character varying(25) COLLATE pg_catalog."default",
    format_credit_life_mobile_number character varying(10) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT format_beneficiarie_pkey PRIMARY KEY (format_beneficiarie_id),
    CONSTRAINT format_beneficiarie_format_beneficiarie_identification_numb_key UNIQUE (format_beneficiarie_identification_number),
    CONSTRAINT format_beneficiarie_format_credit_life_mobile_number_key UNIQUE (format_credit_life_mobile_number),
    CONSTRAINT format_beneficiarie_format_beneficiarie_identification_me_check CHECK (format_beneficiarie_identification_method >= 0 AND format_beneficiarie_identification_method <= 1)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.format_beneficiarie
    OWNER to postgres;


-- Table: public.format_credit_life

-- DROP TABLE IF EXISTS public.format_credit_life;

CREATE TABLE IF NOT EXISTS public.format_credit_life
(
    format_credit_life_id integer NOT NULL DEFAULT nextval('format_credit_life_format_credit_life_id_seq'::regclass),
    format_credit_life_username character varying(250) COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_first_name character varying(250) COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_last_name character varying(250) COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_identification_method integer NOT NULL,
    format_credit_life_identification_number character varying COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_mobile_number character varying(10) COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_landline character varying(25) COLLATE pg_catalog."default",
    format_credit_life_workline character varying(25) COLLATE pg_catalog."default",
    format_credit_life_date_of_birth character varying(25) COLLATE pg_catalog."default",
    format_credit_life_physical_address character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_postal_address character varying(255) COLLATE pg_catalog."default",
    format_credit_life_gender character varying(25) COLLATE pg_catalog."default",
    format_credit_life_product integer NOT NULL,
    format_credit_life_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_insurer character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_nda_policy_number character varying(255) COLLATE pg_catalog."default",
    format_credit_life_payment_frequency character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_sum_insured character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_policy_payment_method character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_credit_life_premium_total double precision,
    format_credit_life_inception_date date,
    format_credit_life_sasria double precision,
    format_credit_life_fees double precision,
    format_credit_life_debit_day integer,
    format_credit_life_consultant_marketer character varying(255) COLLATE pg_catalog."default",
    format_credit_life_user_who_activated_the_policy character varying(255) COLLATE pg_catalog."default",
    format_credit_life_processed_date date,
    format_credit_life_all_risk_per_policy character varying(255) COLLATE pg_catalog."default",
    format_credit_life_risk_premium_total double precision,
    format_credit_life_asset_number character varying(255) COLLATE pg_catalog."default",
    format_credit_life_ncb integer,
    CONSTRAINT format_credit_life_pkey PRIMARY KEY (format_credit_life_id),
    CONSTRAINT format_credit_life_format_credit_life_email_key UNIQUE (format_credit_life_email),
    CONSTRAINT format_credit_life_format_credit_life_identification_number_key UNIQUE (format_credit_life_identification_number),
    CONSTRAINT format_credit_life_format_credit_life_mobile_number_key UNIQUE (format_credit_life_mobile_number),
    CONSTRAINT format_credit_life_format_credit_life_username_key UNIQUE (format_credit_life_username),
    CONSTRAINT format_credit_life_format_credit_life_identification_meth_check CHECK (format_credit_life_identification_method >= 0 AND format_credit_life_identification_method <= 1),
    CONSTRAINT format_credit_life_format_credit_life_product_check CHECK (format_credit_life_product >= 0 AND format_credit_life_product <= 1)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.format_credit_life
    OWNER to postgres;


-- Table: public.format_dependents

-- DROP TABLE IF EXISTS public.format_dependents;

CREATE TABLE IF NOT EXISTS public.format_dependents
(
    format_dependents_id integer NOT NULL DEFAULT nextval('format_dependents_format_dependents_id_seq'::regclass),
    format_dependents_nda_policy_number character varying(255) COLLATE pg_catalog."default",
    format_dependents_first_name character varying(250) COLLATE pg_catalog."default" NOT NULL,
    format_dependents_last_name character varying(250) COLLATE pg_catalog."default" NOT NULL,
    format_dependents_identification_method integer NOT NULL,
    format_dependents_identification_number character varying COLLATE pg_catalog."default" NOT NULL,
    format_dependents_date_of_birth character varying(25) COLLATE pg_catalog."default",
    format_dependents_gender character varying(25) COLLATE pg_catalog."default",
    format_dependents_relationship character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_dependents_cover_level integer,
    CONSTRAINT format_dependents_pkey PRIMARY KEY (format_dependents_id),
    CONSTRAINT format_dependents_format_dependents_identification_number_key UNIQUE (format_dependents_identification_number),
    CONSTRAINT format_dependents_format_dependents_identification_method_check CHECK (format_dependents_identification_method >= 0 AND format_dependents_identification_method <= 1)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.format_dependents
    OWNER to postgres;


-- Table: public.format_funeral

-- DROP TABLE IF EXISTS public.format_funeral;

CREATE TABLE IF NOT EXISTS public.format_funeral
(
    format_funeral_id integer NOT NULL DEFAULT nextval('format_funeral_format_funeral_id_seq'::regclass),
    format_funeral_username character varying(250) COLLATE pg_catalog."default" NOT NULL,
    format_funeral_first_name character varying(250) COLLATE pg_catalog."default" NOT NULL,
    format_funeral_last_name character varying(250) COLLATE pg_catalog."default" NOT NULL,
    format_funeral_email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_funeral_identification_method integer NOT NULL,
    format_funeral_identification_number character varying COLLATE pg_catalog."default" NOT NULL,
    format_funeral_mobile_number character varying(10) COLLATE pg_catalog."default" NOT NULL,
    format_funeral_landline character varying(25) COLLATE pg_catalog."default",
    format_funeral_workline character varying(25) COLLATE pg_catalog."default",
    format_funeral_date_of_birth character varying(25) COLLATE pg_catalog."default",
    format_funeral_physical_address character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_funeral_postal_address character varying(255) COLLATE pg_catalog."default",
    format_funeral_gender character varying(25) COLLATE pg_catalog."default",
    format_funeral_product integer NOT NULL,
    format_funeral_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_funeral_insurer character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_funeral_nda_policy_number character varying(255) COLLATE pg_catalog."default",
    format_funeral_payment_frequency character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_funeral_sum_insured integer,
    format_funeral_policy_payment_method character varying(255) COLLATE pg_catalog."default" NOT NULL,
    format_funeral_premium integer,
    format_funeral_inception_date date,
    format_funeral_sasria double precision,
    format_funeral_fees double precision,
    format_funeral_debit_day integer,
    format_funeral_consultant_marketer character varying(255) COLLATE pg_catalog."default",
    format_funeral_brokerage character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT format_funeral_pkey PRIMARY KEY (format_funeral_id),
    CONSTRAINT format_funeral_format_funeral_email_key UNIQUE (format_funeral_email),
    CONSTRAINT format_funeral_format_funeral_identification_number_key UNIQUE (format_funeral_identification_number),
    CONSTRAINT format_funeral_format_funeral_mobile_number_key UNIQUE (format_funeral_mobile_number),
    CONSTRAINT format_funeral_format_funeral_username_key UNIQUE (format_funeral_username),
    CONSTRAINT format_funeral_format_funeral_identification_method_check CHECK (format_funeral_identification_method >= 0 AND format_funeral_identification_method <= 1),
    CONSTRAINT format_funeral_format_funeral_product_check CHECK (format_funeral_product >= 0 AND format_funeral_product <= 1)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.format_funeral
    OWNER to postgres;