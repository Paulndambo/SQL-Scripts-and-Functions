def get_policy_number_prefix(pricing_plan_id):
    policy_number_prefix = None

    if pricing_plan_id == 0:
        policy_number_prefix = "SYN_"
    elif pricing_plan_id == 1:
        policy_number_prefix = "NW_"
    elif pricing_plan_id == 2:
        policy_number_prefix = "MBD_"
    elif pricing_plan_id == 3:
        policy_number_prefix = "NWL_"
    elif pricing_plan_id == 4:
        policy_number_prefix = "NTL_"
    elif pricing_plan_id == 5:
        policy_number_prefix = "NMBL_"
    elif pricing_plan_id == 6:
        policy_number_prefix = "NMBD_"
    elif pricing_plan_id == 7:
        policy_number_prefix = "NBSL_"
    elif pricing_plan_id == 8:
        pass
    elif pricing_plan_id == 9:
        policy_number_prefix = "NKL_"
    
    return policy_number_prefix


def get_pricing_plan(pricing_plan_id):
    pricing_plan_name = None

    if pricing_plan_id == 0:
        pricing_plan_name = "Synergy"
    elif pricing_plan_id == 1:
        pricing_plan_name = "Nutun Wellness"
    elif pricing_plan_id == 2:
        pricing_plan_name = "MBD Funeral"
    elif pricing_plan_id == 3:
        pricing_plan_name = "Nutun Wellness Legacy"
    elif pricing_plan_id == 4:
        pricing_plan_name = "Nutun Transact Legacy"
    elif pricing_plan_id == 5:
        pricing_plan_name = "Nutun Munnik Basson Da Gama Inc Legacy"
    elif pricing_plan_id == 6:
        pricing_plan_name = "Nutun MBD Legal Collections Legacy"
    elif pricing_plan_id == 7:
        pricing_plan_name = "Nutun Business Services SA Legacy"
    elif pricing_plan_id == 8:
        pass
    elif pricing_plan_id == 9:
        pricing_plan_name = "Nutun Kwande Legacy"

    return pricing_plan_name


def get_premium_amount(pricing_plan):
    premium = None

    if pricing_plan == "Nutun Wellness":
        premium = 12.00
    elif pricing_plan == "MBD Funeral":
        premium = 15.23
    else:
        premium = 40.00

    return premium
    
