from apps.payments.models import PolicyPremium

def match_policy_premium_and_balance():
    policy_premiums = PolicyPremium.objects.filter(status='unpaid', balance=0, expected_payment__gte=12)
    for premium in policy_premiums:
        premium.balance = -abs(premium.expected_payment)
        premium.save()
        print(f"Premium: {premium.id}, Amount: {premium.expected_payment}, Bal: {premium.balance}, Premium Status: {premium.status}")