def update_policy_premium_balance(policy_premium):
    policy_premium.balance = -abs(policy_premium.expected_payment)
    policy_premium.save()