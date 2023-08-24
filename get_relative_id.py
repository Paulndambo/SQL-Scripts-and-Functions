parents = ['Mother', 'Father', 'Parent', 'mother', 'father', 'parent']
children = ['Son', 'Daughter', 'DAUGHTER' 'Child']
partners = ['Spouse', 'Partner', 'Wife', 'wife']
grandparents = ['Grandparent', 'Grandfather', 'Grandmother']
siblings = ['Brother', 'Sister']

def get_relative_id(dependent_type):
    relative_id = None
    if dependent_type.lower() in [(x).lower() for x in children]:
        relative_id = 4
    elif dependent_type.lower() in [(x).lower() for x in partners]:
        relative_id = 3
    elif dependent_type.lower() in [(x).lower() for x in grandparents]:
        relative_id = 14
    elif dependent_type.lower() in [(x).lower() for x in siblings]:
        relative_id = 22
    elif dependent_type.lower() == 'Sibling'.lower():
        relative_id = 7
    elif dependent_type.lower() == 'Adult Child'.lower():
        relative_id = 6
    elif dependent_type.lower() == 'Aunt'.lower():
        relative_id = 8
    elif dependent_type.lower() == 'Uncle'.lower():
        relative_id = 9
    elif dependent_type.lower() == 'Niece'.lower():
        relative_id = 11
    elif dependent_type.lower() == 'Nephew'.lower():
        relative_id = 12
    elif dependent_type.lower() == 'Grandchild'.lower():
        relative_id = 13
    elif dependent_type.lower() == 'Minor Child'.lower():
        relative_id = 15
    elif dependent_type.lower() == 'Sibling In-Law'.lower():
        relative_id = 16
    elif dependent_type.lower() == 'Parent In-Law'.lower():
        relative_id = 17
    elif dependent_type.lower() == 'Senior Citizen Parent'.lower():
        relative_id = 18
    elif dependent_type.lower() == 'Guardian'.lower():
        relative_id = 24
    elif dependent_type.lower() == 'Friend'.lower():
        relative_id = 23
    return relative_id


print(get_relative_id('son'))