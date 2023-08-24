from apps.policies.models import Policy
from apps.schemes.models import Scheme, SchemeGroup
from apps.users.models import User, Profile, Membership, MembershipConfiguration

def generate_guardrisk_data_report():
    policies = Policy.objects.all()
    scheme_groups = SchemeGroup.objects.all()
    memberships = Membership.objects.all()
    profiles = Profile.objects.all()

    for membership in memberships:
        test_data = f"""
        1. Policy: No.: {membership.scheme_group.policy.policy_number}, Status: {membership.scheme_group.policy.status}, Created: {membership.scheme_group.policy.created} 
        2. Scheme Group: ID: {membership.scheme_group.id}, Pricing Plan: {membership.scheme_group.pricing_group}
        """
        print(test_data)