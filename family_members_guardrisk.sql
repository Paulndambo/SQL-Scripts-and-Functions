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