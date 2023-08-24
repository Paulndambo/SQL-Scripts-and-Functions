def get_cover_level(id_number, dependent_type):
    dob = get_date_of_birth(id_number)
    age = calculate_age(dob)

    cover_level = 0
    child_types = ['Daughter', 'Son', 'Child']

    if dependent_type.lower() == 'Spouse'.lower() and age >= 18 and age <= 65:
        cover_level = 35000
    elif dependent_type.lower() in [(x).lower() for x in child_types] and age >= 14 and age <= 21:
        cover_level = 27000
    elif dependent_type.lower() in [(x).lower() for x in child_types] and age >= 6 and age <= 13:
        cover_level = 18000
    elif dependent_type.lower() in [(x).lower() for x in child_types] and age >= 0 and age <= 5:
        cover_level = 12500
    elif dependent_type.lower() == 'Stillborn'.lower() and age < 1:
        cover_level = 12500
    return cover_level

