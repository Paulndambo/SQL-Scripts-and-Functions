
create or replace function get_user_email(_user_id int)
returns text
language plpgsql
as
$$
declare
   _email text;
   
begin
	select email into _email from users_user
	where id = _user_id;
	return _email;
end;
$$;

create or replace function get_policy_premium_amount(_group_name text)
returns text
language plpgsql
as
$$
declare
   _premium_amount bigint;
   
begin
	select total_premium into _premium_amount from prices_pricingplan
	where name = _group_name;
	return _premium_amount;
end;
$$;


--- MAIN MEMBERS GUARDRISK REPORT ---
select now() as "Report Generation date", schemes_schemegroup.policy_id as "Policy ID",policy_number as "Policy Number",get_premium_amount_updated(schemes_schemegroup.pricing_group) as "Policy Premium Amount", users_membershipconfiguration.cover_level as "Cover Level", scheme_id as "Scheme ID", schemes_schemegroup.pricing_group as "Package Type",  'Guardrisk Life' AS "Insurer Name", start_date as "Policy Start Date",payment_frequency as "Policy Payment Frequency", status as "Policy Status",CONCAT(first_name, ' ', last_name) as "PolicyHolder Full Name", get_user_email(users_profile.user_id) as "Email Address", users_profile.phone as "Phone Number", address as "Address",id_number as "ID Number",passport_number as "Passport Number", date_of_birth as "Date of Birth",gender as "Gender"  from users_membership
left join schemes_schemegroup on users_membership.scheme_group_id = schemes_schemegroup.id
left join users_membershipconfiguration on users_membershipconfiguration.membership_id = users_membership.id
left join policies_policy on schemes_schemegroup.policy_id = policies_policy.id
left join users_profile on users_membership.user_id = users_profile.user_id;
WHERE schemes_schemegroup.pricing_group != 'Nutun Telesales Funeral'

select now() as "Report Generation date", schemes_schemegroup.policy_id as "Policy ID",policy_number as "Policy Number",get_premium_for_telesales(users_membership.id) as "Policy Premium Amount", users_membershipconfiguration.cover_level as "Cover Level", scheme_id as "Scheme ID", schemes_schemegroup.pricing_group as "Package Type",  'Guardrisk Life' AS "Insurer Name", start_date as "Policy Start Date",payment_frequency as "Policy Payment Frequency", status as "Policy Status",CONCAT(first_name, ' ', last_name) as "PolicyHolder Full Name", get_user_email(users_profile.user_id) as "Email Address", users_profile.phone as "Phone Number", address as "Address",id_number as "ID Number",passport_number as "Passport Number", date_of_birth as "Date of Birth",gender as "Gender"  from users_membership
left join schemes_schemegroup on users_membership.scheme_group_id = schemes_schemegroup.id
left join users_membershipconfiguration on users_membershipconfiguration.membership_id = users_membership.id
left join policies_policy on schemes_schemegroup.policy_id = policies_policy.id
left join users_profile on users_membership.user_id = users_profile.user_id
WHERE schemes_schemegroup.pricing_group = 'Nutun Telesales Funeral'

select now() as "Report Generation date", schemes_schemegroup.policy_id as 'Policy ID',policy_number as 'Policy Number',get_premium_for_telesales(users_membership.id) as "Policy Premium Amount", scheme_id as 'Scheme ID', schemes_schemegroup.pricing_group as "Package Type",  'Guardrisk Life' AS "Insurer Name", start_date as "Policy Start Date",payment_frequency as "Policy Payment Frequency", status as "Policy Status",CONCAT(first_name, ' ', last_name) as "PolicyHolder Fullname", get_user_email(users_profile.user_id) as "Email Address", users_profile.phone as "Phone Number", address as 'Address',id_number as 'ID Number',passport_number as 'Passport Number', date_of_birth as 'Date of Birth',gender as 'Gender' from users_membership
left join schemes_schemegroup on users_membership.scheme_group_id = schemes_schemegroup.id
left join policies_policy on schemes_schemegroup.policy_id = policies_policy.id
left join users_profile on users_membership.user_id = users_profile.user_id
WHERE schemes_schemegroup.pricing_group = 'Nutun Telesales Funeral'


--- FAMILY MEMBERS GUARDRISK REPORT ---
SELECT NOW() AS date_generated, d.id, d.created, d.modified, s.policy_id, policy.policy_number, cycle.status as policy_status, s.pricing_group as product,
profile.first_name as main_member_first_name, profile.last_name as main_member_last_name, profile.id_number as main_member_identification_number,
rel.use_type as relationship_type, rel.relative_key as relation, d.first_name as first_name, d.last_name as last_name, d.id_number as id_number,
d.passport_number as passport_number, d.date_of_birth as date_of_birth, d.gender as gender, d.cover_level as cover_amount, d.add_on_premium as premium
FROM prices_dependent d
INNER JOIN users_membershipconfiguration mc on mc.id = membership_configuration_id
INNER JOIN users_membership m on m.id = mc.membership_id
INNER JOIN schemes_schemegroup s on m.scheme_group_id = s.id
INNER JOIN policies_policy policy on s.policy_id = policy.id
INNER JOIN policies_cycle cycle on cycle.membership_id = m.id
INNER JOIN users_profile profile on m.user_id = profile.user_id
INNER JOIN users_policyholderrelative rel on rel.id = d.relative_id
INNER JOIN prices_pricingplan plan on plan.group = s.pricing_group
UNION ALL

SELECT NOW() AS date_generated, d.id, d.created, d.modified, s.policy_id, policy.policy_number, cycle.status as policy_status, s.pricing_group as product,
profile.first_name as main_member_first_name, profile.last_name as main_member_last_name, profile.id_number as main_member_identification_number,
'beneficiary' as relationship_type, rel.relative_key as relation, d.first_name as first_name, d.last_name as last_name, d.id_number as id_number,
d.passport_number as passport_number, d.date_of_birth as date_of_birth, '' as gender, 0 as cover_amount, NULL as premium
FROM users_membershipconfiguration mc
INNER JOIN dependents_funeralbeneficiary d on d.id=mc.beneficiary_id
INNER JOIN users_membership m on m.id = mc.membership_id
INNER JOIN schemes_schemegroup s on m.scheme_group_id = s.id
INNER JOIN policies_policy policy on s.policy_id = policy.id
INNER JOIN policies_cycle cycle on cycle.membership_id = m.id
INNER JOIN users_profile profile on m.user_id = profile.user_id
INNER JOIN users_policyholderrelative rel on rel.id = d.relative_id
INNER JOIN prices_pricingplan plan on plan.group = s.pricing_group
where mc.beneficiary_id is not null