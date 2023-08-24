def legacy_extended_pricing(age, cover_level):
    level_premium = 0
    if cover_level == 20000:
        if age >= 75:
            level_premium = 182.125
        elif age >= 65 and age <= 74:
            level_premium = 78.01
        elif age >= 0 and age <= 64:
            level_premium = 25.94

    elif cover_level == 15000:
        if age >= 75:
            level_premium = 136.67
        elif age >= 65 and age <= 74:
            level_premium = 58.46
        elif age >= 0 and age <= 64:
            level_premium = 19.55

    elif cover_level == 10000:
        if age >= 75:
            level_premium = 90.97
        elif age >= 65 and age <= 74:
            level_premium = 39.10
        elif age >= 0 and age <= 64:
            level_premium = 12.98

    return level_premium
