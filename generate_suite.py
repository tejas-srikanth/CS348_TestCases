import os
import json

def create_test_suite(json_file, output_folder, set_base_file):
    # Read the JSON file
    with open(json_file, 'r') as file:
        data = json.load(file)
    
    # Ensure the output folder exists
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
    
    with open(set_base_file, 'r') as base_file:
        base_sql_lines = base_file.readlines()

    for entry in data:
        print(entry['Expected'])
        name = entry['Name']
        using_base = entry['UsingBase']
        additional = entry['Additional']
        args = entry['Args']
        expected = entry['Expected']
        
        # Create Testx.sql
        test_sql_file = os.path.join(output_folder, f'Test{name}.sql')
        with open(test_sql_file, 'w') as sql_file:
            if using_base:
                sql_file.writelines(base_sql_lines)
            for line in additional:
                sql_file.write(line + '\n')
        
        # Create Testx.txt
        test_txt_file = os.path.join(output_folder, f'Test{name}.txt')
        with open(test_txt_file, 'w') as txt_file:
            for arg in args:
                txt_file.write(arg + '\n')
        
        # Create TestxExpected.txt
        test_expected_file = os.path.join(output_folder, f'Test{name}Expected.txt')
        with open(test_expected_file, 'w') as expected_file:
            for exp in expected:
                expected_file.write(exp + '\n')

suite_name = input()


json_file = f'{suite_name}.json'  
output_folder = f'{suite_name}_suite'  
create_test_suite(json_file, output_folder, "SetBase.sql")
