{{ config(materialized='view') }}

{%- set yaml_metadata -%}
control_snap_v0: 'control_snap_v0'
log_logic: 
    daily:
        duration: 3
        unit: 'MONTH'
    weekly:
        duration: 1
        unit: 'YEAR'
    monthly:
        duration: 5
        unit: 'YEAR'
    yearly:
        forever: true
{%- endset -%}    

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

SELECT *
FROM (
    {{ teradata_automate_dv.control_snap_v1(control_snap_v0=metadata_dict.get('control_snap_v0'),
                                        log_logic=metadata_dict.get('log_logic')
                                        ) }}
) t
