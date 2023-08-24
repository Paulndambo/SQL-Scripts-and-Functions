def get_last_mbd_policy_id():
    policy = Policy.objects.filter(policy_number__startswith="MBD").order_by("-id").first()
    return policy.id + 1


def generate_mbd_policy_numbers(last_policy_id: int, user_id: int):
    policy_number = f"MBD_{last_policy_id}"
    policy_number_str = ''

    policy = Policy.objects.filter(policy_number=policy_number)

    if policy:
        policy_number_str = f"MBD{last_policy_id}{user_id}"
    else:
        policy_number_str = policy_number

    return policy_number_str