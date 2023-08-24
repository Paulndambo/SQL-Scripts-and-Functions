import datetime

def get_gender(id):
    gender_slice = int(id[6:10])
    gender = 'male' if gender_slice>=5000 else 'female'
    return gender
    

def get_date_of_birth(id):
    day = int(id[4:6])
    month = int(id[2:4])
    year = id[0:2]

    first_construct = int('20' + year)
    second_construct = int('19' + year)

    first_date = datetime.datetime(first_construct, 1, 1)
    second_date = datetime.datetime(second_construct, 1, 1)

    first_diff = datetime.datetime.today() - first_date
    second_diff = datetime.datetime.today() - second_date

    number = first_diff.days

    # CHECK NUMBER
    if number > 0 and first_diff < second_diff:
        dob = datetime.datetime(first_construct, month, day)
    else:
        dob = datetime.datetime(second_construct, month, day)

    return dob


dob = get_date_of_birth('2209141227087')
gender = get_gender('2209141227087')
message = f"Date of Birth {dob}, Gender: {gender}"
print(message)