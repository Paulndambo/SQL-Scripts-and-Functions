child_relatives = ['Son', 'Daughter', 'Child']

def get_relative_relation(dependent_type):
    relative_type = None
    if dependent_type.lower() in [(x).lower() for x in child_relatives]:
        relative_type = 'child'
    elif dependent_type.lower() == 'Adult Child'.lower():
        relative_type = 'adult_child'
    elif dependent_type.lower() == 'Minor Child'.lower():
        relative_type = 'minor_child'
    elif dependent_type.lower() == 'Sibling In-Law'.lower():
        relative_type = 'sibling_in_law'
    elif dependent_type.lower() == 'Parent In-Law'.lower():
        relative_type = 'parent_in_law'
    elif dependent_type.lower() == 'Senior Citizen Parent'.lower():
        relative_type = 'senior_citizen_parent'
    return relative_type

print(get_relative_relation('Sibling In-Law'))