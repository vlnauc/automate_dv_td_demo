from datetime import datetime, timedelta

# Define the path to your dbt_project.yml and the variable name
dbt_project_path = 'dbt_project.yml'
load_date_var = 'load_date'

# Define the increment logic
with open(dbt_project_path, 'r') as file:
    lines = file.readlines()

# Process each line to find and update the load_date variable
with open(dbt_project_path, 'w') as file:
    for line in lines:
        # Check if the line contains the load_date variable
        if f"{load_date_var}:" in line:
            # Extract the current date, increment it, and format it
            current_date = line.split(":")[-1].strip().strip("'\"")
            new_date = (datetime.strptime(current_date, '%Y-%m-%d') + timedelta(days=1)).strftime('%Y-%m-%d')
            # Replace the line with the new load_date value
            file.write(f"  {load_date_var}: '{new_date}'\n")
        else:
            # Write the line unchanged
            file.write(line)

print(f"Updated {load_date_var} to {new_date}")
