-- View: public.member_report

-- DROP VIEW public.member_report;

CREATE OR REPLACE VIEW public.member_report
 AS
 SELECT to_char(now()::date::timestamp with time zone, 'yyyy/mm/dd'::text) AS time_stamp,
    pp.policy_holder_id AS id,
    pp.id AS policy_id,
    ''::text AS report_period_start,
    ''::text AS report_period_end,
    'Niftycover'::text AS administrator_identifier,
    'Guardrisk Life'::text AS insurer_name,
    143 AS client_identifier,
        CASE
            WHEN lower(ip.short_description::text) = 'funeral'::text THEN '2'::text
            ELSE '5'::text
        END AS division_identifier,
    ip.short_description AS sub_scheme_name,
    pp.policy_number,
    package.name AS product_name,
    cover_level.product_option,
    to_char(pp.activation_date::timestamp with time zone, 'yyyy/mm/dd'::text) AS policy_commencement_date,
    to_char(pp.expiration_date::timestamp with time zone, 'yyyy/mm/dd'::text) AS policy_expiry_date,
        CASE
            WHEN pp.expiration_date IS NOT NULL THEN ( SELECT (date_part('years'::text, pp.expiration_date::timestamp without time zone)::integer - date_part('years'::text, pp.expiration_date::timestamp without time zone)::integer) * 12 - date_part('month'::text, pp.activation_date::timestamp without time zone)::integer + date_part('month'::text, pp.activation_date::timestamp without time zone)::integer)
            ELSE ( SELECT (date_part('years'::text, now()::timestamp without time zone)::integer - date_part('years'::text, now()::timestamp without time zone)::integer) * 12 - date_part('month'::text, pp.activation_date::timestamp without time zone)::integer + date_part('month'::text, pp.activation_date::timestamp without time zone)::integer)
        END AS term_of_policy,
        CASE
            WHEN pp.status::text = 'active'::text THEN 'A'::character varying
            WHEN pp.status::text = 'lapsed'::text THEN 'L'::character varying
            WHEN pp.status::text = 'cancelled'::text THEN 'X'::character varying
            WHEN pp.status::text = 'expired'::text THEN 'E'::character varying
            WHEN pp.status::text = 'claimed'::text THEN 'C'::character varying
            WHEN pp.status::text = 'awaiting_payment'::text THEN 'N'::character varying
            ELSE pp.status
        END AS policy_status,
    to_char(( SELECT policies_policystatusupdates.modified
           FROM policies_policystatusupdates
          WHERE policies_policystatusupdates.policy_id = pp.id
          ORDER BY policies_policystatusupdates.modified DESC
         LIMIT 1), 'yyyy/mm/dd'::text) AS policy_status_date,
    ''::text AS new_policy_indicator,
    'Direct marketing via internet'::text AS sales_channel,
    ''::text AS cancelled_by,
    'Y'::text AS death_indicator,
    '12'::text AS premium_frequency,
    'Regular'::text AS premium_type,
    cover_level.cover_amount AS death_original_sum_insured,
    'Lumpsum'::text AS death_cover_structure,
    cover_level.cover_amount AS death_current_sum_insured,
    ''::text AS reinsurer_name,
    0 AS death_current_ri_sum_insured,
    0 AS death_ri_premium,
    0 AS death_ri_percent,
    0 AS total_premium_collected,
    pp.amount AS total_premium_payable,
    pp.amount AS total_premium,
    0 AS total_premium_subsidy,
    0 AS total_reinsurance_premium,
    0 AS total_reinsurance_premium_payable,
    0 AS total_financial_reinsurance_cashflows,
    0 AS total_financial_reinsurance_payable,
    12 AS commission_frequency,
    0 AS commission,
    0 AS binder_fees,
    0 AS outsourcing_fees,
    0 AS marketing_fees,
    0 AS management_fees,
    0 AS claims_handling_fees,
    0 AS total_gross_claim_amount,
    0 AS gross_claim_paid,
    0 AS reinsurance_recoveries,
    uu.last_name AS principal_surname,
    uu.first_name AS principal_firstname,
    substr(uu.first_name::text, 1, 1) AS principal_initials,
    up.id_number AS principal_id,
    upper(substr(up.gender::text, 1, 1)) AS principal_gender,
    up.date_of_birth AS principal_date_of_birth,
    replace(up.address::text, ','::text, ';'::text) AS principal_physical_address,
    ( SELECT replace(policies_policyadditionalfield.value::text, ','::text, ';'::text) AS replace
           FROM policies_policyadditionalfield
          WHERE policies_policyadditionalfield.field::text = 'second_address'::text AND policies_policyadditionalfield.policy_id = pp.id
         LIMIT 1) AS second_address,
    ( SELECT replace(policies_policyadditionalfield.value::text, ','::text, ';'::text) AS replace
           FROM policies_policyadditionalfield
          WHERE policies_policyadditionalfield.field::text = 'suburb'::text AND policies_policyadditionalfield.policy_id = pp.id
         LIMIT 1) AS suburb,
    ( SELECT replace(policies_policyadditionalfield.value::text, ','::text, ';'::text) AS replace
           FROM policies_policyadditionalfield
          WHERE policies_policyadditionalfield.field::text = 'province'::text AND policies_policyadditionalfield.policy_id = pp.id
         LIMIT 1) AS province,
    ( SELECT replace(policies_policyadditionalfield.value::text, ','::text, ';'::text) AS replace
           FROM policies_policyadditionalfield
          WHERE policies_policyadditionalfield.field::text = 'city'::text AND policies_policyadditionalfield.policy_id = pp.id
         LIMIT 1) AS city,
    ( SELECT policies_policyadditionalfield.value
           FROM policies_policyadditionalfield
          WHERE policies_policyadditionalfield.field::text = 'postal_code'::text AND policies_policyadditionalfield.policy_id = pp.id
         LIMIT 1) AS principal_postal_code,
    ( SELECT policies_policyadditionalfield.value
           FROM policies_policyadditionalfield
          WHERE policies_policyadditionalfield.field::text = 'dpip'::text AND policies_policyadditionalfield.policy_id = pp.id
         LIMIT 1) AS dpip,
    ( SELECT policies_policyadditionalfield.value
           FROM policies_policyadditionalfield
          WHERE policies_policyadditionalfield.field::text = 'referral_code'::text AND policies_policyadditionalfield.policy_id = pp.id
         LIMIT 1) AS reference_number,
    date(pp.created) AS policy_start_date,
    up.phone_number AS principal_phone_number,
    uu.email AS principal_email,
    ''::text AS income_group,
    ''::text AS spouse_indicator,
    0 AS number_adult_dependants,
    0 AS number_child_dependants,
    0 AS number_extended_family,
    ''::text AS spouse_surname,
    ''::text AS spouse_firstname,
    ''::text AS spouse_initials,
    ''::text AS spouse_id,
    ''::text AS spouse_gender,
    ''::text AS spouse_date_of_birth,
    0 AS spouse_cover_amount,
    ''::text AS spouse_cover_commencement_date,
    ''::text AS dependent_1_gender,
    ''::text AS dependent_1_date_of_birth,
    ''::text AS dependent_1_type,
    0 AS dependent_1_cover_amount,
    ''::text AS dependent_1_cover_commencement_date,
    ''::text AS dependent_2_gender,
    ''::text AS dependent_2_date_of_birth,
    ''::text AS dependent_2_type,
    0 AS dependent_2_cover_amount,
    ''::text AS dependent_2_cover_commencement_date,
    ''::text AS dependent_3_gender,
    ''::text AS dependent_3_date_of_birth,
    ''::text AS dependent_3_type,
    0 AS dependent_3_cover_amount,
    ''::text AS dependent_3_cover_commencement_date,
    ''::text AS dependent_4_gender,
    ''::text AS dependent_4_date_of_birth,
    ''::text AS dependent_4_type,
    0 AS dependent_4_cover_amount,
    ''::text AS dependent_4_cover_commencement_date,
    ''::text AS dependent_5_gender,
    ''::text AS dependent_5_date_of_birth,
    ''::text AS dependent_5_type,
    0 AS dependent_5_cover_amount,
    ''::text AS dependent_5_cover_commencement_date,
    ''::text AS dependent_6_gender,
    ''::text AS dependent_6_date_of_birth,
    ''::text AS dependent_6_type,
    0 AS dependent_6_cover_amount,
    ''::text AS dependent_6_cover_commencement_date,
    ''::text AS dependent_7_gender,
    ''::text AS dependent_7_date_of_birth,
    ''::text AS dependent_7_type,
    0 AS dependent_7_cover_amount,
    ''::text AS dependent_7_cover_commencement_date,
    ''::text AS dependent_8_gender,
    ''::text AS dependent_8_date_of_birth,
    ''::text AS dependent_8_type,
    0 AS dependent_8_cover_amount,
    ''::text AS dependent_8_cover_commencement_date,
    ''::text AS dependent_9_gender,
    ''::text AS dependent_9_date_of_birth,
    ''::text AS dependent_9_type,
    0 AS dependent_9_cover_amount,
    ''::text AS dependent_9_cover_commencement_date
   FROM policies_policy pp
     JOIN users_policyholder up ON pp.policy_holder_id = up.id
     JOIN users_individualuser ui ON up.individual_user_id = ui.id
     JOIN users_user uu ON ui.user_id = uu.id
     LEFT JOIN insurance_products_insuranceproduct ip ON pp.insurance_product_id = ip.id
     LEFT JOIN generics_insurance_products_genericinsuranceproduct gipg ON ip.id = gipg.insurance_product_id
     LEFT JOIN payments_debitorder pd ON pp.id = pd.policy_id
     LEFT JOIN payments_bank bank ON pd.bank_id = bank.id
     LEFT JOIN policy_details pdetails ON pp.id = pdetails.policy_id
     LEFT JOIN prices_packagecoverlevel cover_level ON pdetails.cover_level_id = cover_level.id
     LEFT JOIN insurance_products_package package ON cover_level.package_id = package.id;

ALTER TABLE public.member_report
    OWNER TO c2s;

