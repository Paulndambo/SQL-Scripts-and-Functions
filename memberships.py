from apps.users.models import User, Membership, Profile
from apps.schemes.models import SchemeGroup

def get_membership(id_number: str):
    profile = Profile.objects.get(id_number=id_number)
    membership = Membership.objects.get(user_id=profile.user.id)
    scheme_group = SchemeGroup.objects.get(id=membership.scheme_group.id)
    print(f"ID No: {id_number}, Policy No: {scheme_group.policy.policy_number}")


for x in cs:
    get_membership(x)