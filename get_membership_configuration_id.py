def get_membership_configuration_id(id_number, policy_number):
    policy = Policy.objects.get(policy_number=policy_number)
    scheme_group = SchemeGroup.objects.get(policy_id=policy.id)
    profile = Profile.objects.get(id_number=id_number)
    membership = Membership.objects.get(
        user_id=profile.user_id, scheme_group_id=scheme_group.id)
    membership_configuration = MembershipConfiguration.objects.get(membership_id=membership.id)
    return membership_configuration.id