Welcome to your new dbt project!

#### Preparation of DBT project

``` bash
mkdir _demo
cd _demo

pip install virtualenv
virtualenv venv

venv/Scripts/activate.bat #activate virtual env in cmd

#install dbt-core and dbt-teradata
# https://github.com/Teradata/dbt-teradata

pip install dbt-core>=1.8.0
pip install dbt-teradata

# craetion DBT project
dbt init mandatum_demo

#open project in vs code
cd mandatum_demo
code .
```
#### Installing GIT repositories (packages) to DBT project
``` bash
clone dbt-teradata
cd dbt-teradata
pip install -e .

# cloning is optional, repos are in packages.yml
git clone dbt-utils
git clone dbt-teradata-utils
git clone automate-dv
git clone automate-dv-demo

# add repos to package.yml in project as :
dbt deps
```
#### Preparation of DB environment in Teradata Virtual Express Environment
[Init ClearScape SQL](sql_scripts/01_Init_clearscape.sql)
#### Preparation of DB environment in SnowFlake - registered free cloud
[Init Teradata SQL](sql_scripts/01_Init_snowflake.sql)

#### Creation foreign tables (in teradata), snowflake has data already loaded
``` bash
dbt run-operation stage_external_sources
```

#### Execution
- set variable load_date in dbt_project.yml
execute
``` bash
dbt run
```
- for full refresh, its possible to execute
``` bash
dbt run --full-refresh
```
- for incremental run, execute
``` bash
py increment_load_date.py
dbt run
```
