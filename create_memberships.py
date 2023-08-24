from apps.policies.models import Policy
from apps.schemes.models import SchemeGroup
from apps.users.models import Membership
from apps.payments.models import PolicyPremium
from datetime import datetime
date_today = datetime.now().date()

def create_memberships():
    policies = Policy.objects.filter(created__date=date_today)

    for policy in policies:
        scheme_group = SchemeGroup.objects.filter(policy=policy).order_by("-created").first()
        membership = Membership.objects.filter(scheme_group=scheme_group).order_by("-created").first()

        premium = PolicyPremium.objects.create(
            policy=policy,
            membership=membership,
            expected_payment=policy.amount,
            status="future",
            expected_date=date_today,
            balance=-abs(policy.amount)
        )


def get_profile(identification_number: str):
    profile = Profile.objects.filter(id_number=identification_number).order_by("-created").first()

    if profile:
        return profile.id
    else:
        return None


def get_membership(pr_id_number: str):
    profile = Profile.objects.filter(id_number=pr_id_number).order_by("-created").first()
    if profile:
        membership = Membership.objects.filter(user=profile.user).order_by("-created").first()
        if membership:
            return membership.id


def get_membership_configuration(um_id: int):
    membership_config = MembershipConfiguration.objects.filter(membership_id=um_id, beneficiary__isnull=True).order_by("-created").first()
    if membership_config:
        return membership_config.id
    else:
        return None
    
   
