def get_membership_id(id_number, policy_number):
    policy = Policy.objects.get(policy_number=policy_number)
    scheme_group = SchemeGroup.objects.get(policy_id=policy.id)
    profile = Profile.objects.get(id_number=id_number)
    membership = Membership.objects.get(user_id=profile.user_id, scheme_group_id=scheme_group.id)
    return membership.id
